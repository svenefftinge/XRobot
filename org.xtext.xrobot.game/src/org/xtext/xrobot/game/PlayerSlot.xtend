package org.xtext.xrobot.game

import com.google.inject.Inject
import com.google.inject.Provider
import java.util.concurrent.CopyOnWriteArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtext.resource.XtextResourceSet
import org.xtext.xrobot.RobotID
import org.xtext.xrobot.dsl.interpreter.IRobotListener
import org.xtext.xrobot.dsl.interpreter.ScriptParser
import org.xtext.xrobot.dsl.xRobotDSL.Mode
import org.xtext.xrobot.dsl.xRobotDSL.Program
import org.xtext.xrobot.server.IRemoteRobot

import static org.xtext.xrobot.game.PlayerStatus.*

class PlayerSlot implements IRobotListener {
	
	static class Factory {
	
		@Inject IRemoteRobot.Connector remoteRobotConnector
		
		@Inject IErrorReporter display
		
		@Inject Provider<IRobotPreparer> robotPreparerProvider
		
		@Inject Provider<XtextResourceSet> resourceSetProvider
		
		@Inject ScriptParser scriptParser
		
		def create(RobotID robotID) {
			new PlayerSlot(robotID, remoteRobotConnector, display, robotPreparerProvider,
					resourceSetProvider, scriptParser)
		}
		
		def createAll() {
			#[ create(RobotID.Blue), create(RobotID.Red) ]
		}
		
	}

	@Accessors(PUBLIC_GETTER)
	val RobotID robotID

	@Accessors(PUBLIC_GETTER)
	val IErrorReporter display

	val IRemoteRobot.Connector connector
	
	val Provider<XtextResourceSet> resourceSetProvider
	
	val ScriptParser scriptParser
	
	@Accessors(PUBLIC_GETTER)
	Program program

	@Accessors(PUBLIC_GETTER)
	AccessToken token

	@Accessors(PUBLIC_GETTER)
	PlayerStatus status = AVAILABLE

	IRemoteRobot.Factory robotFactory

	val listeners = new CopyOnWriteArrayList<Listener>
	val robotListeners = new CopyOnWriteArrayList<IRobotListener>

	IRobotPreparer preparer
	
	private new(RobotID robotID, IRemoteRobot.Connector connector, IErrorReporter display,
			Provider<? extends IRobotPreparer> preparerProvider,
			Provider<XtextResourceSet> resourceSetProvider,
			ScriptParser scriptParser) {
		this.robotID = robotID
		this.connector = connector
		this.display = display
		this.resourceSetProvider = resourceSetProvider
		this.scriptParser = scriptParser
		token = new AccessToken
		preparer = preparerProvider.get()
		preparer.slot = this
	}
	
	def getRobotFactory() {
		if(robotFactory == null || !robotFactory.isAlive)
			robotFactory = connector.getRobotFactory(robotID)
		robotFactory
	}
	
	def setStatus(PlayerStatus status) {
		this.status = status
		listeners.forEach[slotChanged]
	}
	
	def matches(AccessToken token) {
		this.token == token
	}

	def isAvailable() {
		program == null
	}

	def acquire(Program program) {
		this.program = program
		preparer.prepare
	}
	
	def acquire(String serializedProgram) {
		val resourceSet = resourceSetProvider.get
		val program = scriptParser.parse(serializedProgram, resourceSet)
		if (program != null) {
			acquire(program)
		}
	}
	
	def prepare() {
		if(status != READY)
			preparer.prepare
	}
	
	def waitReady() {
		preparer.waitReady
		return status == READY
	}	
	
	def release() {
		this.program = null
		robotFactory?.release
		token = new AccessToken
		status = AVAILABLE
		listeners.forEach[slotChanged]
	}

	def addSlotListener(Listener listener) {
		listeners += listener
	}

	def addRobotListener(IRobotListener listener) {
		robotListeners += listener
	}

	def getScriptName() {
		program.name
	}

	static interface Listener {
		def void slotChanged()
	}

	override stateRead(IRemoteRobot robot) {
		robotListeners.forEach[stateRead(robot)]
	}

	override modeChanged(IRemoteRobot robot, Mode newMode) {
		robotListeners.forEach[modeChanged(robot, newMode)]
	}

	override stateChanged(IRemoteRobot robot) {
		robotListeners.forEach[stateChanged(robot)]
	}

	override variableChanged(String name, Object value) {
		robotListeners.forEach[variableChanged(name, value)]
	}

	override lineChanged(int line) {
		robotListeners.forEach[lineChanged(line)]
	}

}
