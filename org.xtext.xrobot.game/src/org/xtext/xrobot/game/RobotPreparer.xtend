package org.xtext.xrobot.game

import org.xtext.xrobot.api.Position
import org.xtext.xrobot.net.INetConfig
import org.xtext.xrobot.server.IRemoteRobot

import static java.lang.Math.*
import static org.xtext.xrobot.api.GeometryExtensions.*
import static org.xtext.xrobot.api.IArena.*
import org.xtext.xrobot.game.display.Display
import static extension javafx.util.Duration.*
import org.apache.log4j.Logger
import org.xtext.xrobot.server.CanceledException

class RobotPreparer {
	
	static val LOG = Logger.getLogger(RobotPreparer)
	
	static double LOW_BATTERY_CHARGE = 0.65
	static double MIN_BATTERY_CHARGE = 0.60
	
	static val DISTANCE_ACCURACY = 5.0
	static val ANGLE_ACCURACY = 8.0
	
	volatile boolean isCanceled = false

	IRemoteRobot robot
	Thread thread
	
	PlayerSlot slot
	
	new(PlayerSlot slot) {
		this.slot = slot
	}
	
	def getReady(Display display) {
		LOG.debug(slot.scriptName + ' getReady()')
		isCanceled = false
		if(thread?.isAlive)
			throw new IllegalStateException('RobotPlacer is already running')
		robot = slot.robotFactory.newRobot [isCanceled]
		if(robot.batteryState < MIN_BATTERY_CHARGE) 
			display.showError(slot.scriptName + ': Change battery', 2.seconds)
		if(robot.batteryState < LOW_BATTERY_CHARGE) 
			display.showInfo(slot.scriptName + ': Battery low', 2.seconds)
		thread = new Thread([
			try {
				goHome
			} catch (CanceledException exc) {
				// ignore
			}
		], 'RobotPlacer')
		thread.start
	}
	
	def isReady(Display display) {
		LOG.debug(slot.scriptName + ' isReady()')
		thread?.join(2000)
		isCanceled = true
		thread?.join
		if(robot.batteryState < MIN_BATTERY_CHARGE) 
			display.showError(slot.scriptName + ': Change battery', 2.seconds)
		return
			robot.batteryState >= MIN_BATTERY_CHARGE 
			&& robot.ownPosition.getRelativeDirection(homePosition).distance < DISTANCE_ACCURACY
			&& abs(normalizeAngle(homeViewDirection - robot.ownPosition.viewDirection)) < ANGLE_ACCURACY
	}
	
	private def goHome() {
		robot.rotateSpeed = robot.maxRotateSpeed * 0.7
		robot.travelSpeed = robot.maxTravelSpeed

		val homePosition = getHomePosition()
		var direction = robot.ownPosition.getRelativeDirection(homePosition)
		while (direction.distance > DISTANCE_ACCURACY) {
			if (abs(direction.angle) <= ANGLE_ACCURACY) {
				robot.forward(direction.distance)
			} else if (abs(normalizeAngle(direction.angle - 180)) <= ANGLE_ACCURACY) {
				robot.backward(direction.distance)
			} else if (abs(direction.angle) <= 120) {
				robot.rotate(direction.angle)
			} else {
				robot.rotate(normalizeAngle(direction.angle - 180))
			}
			robot.waitForUpdate
			direction = robot.ownPosition.getRelativeDirection(homePosition)
		}

		val homeViewDirection = getHomeViewDirection()
		var angle = normalizeAngle(homeViewDirection - robot.ownPosition.viewDirection)
		while (abs(angle) > ANGLE_ACCURACY) {
			robot.rotate(angle)
			robot.waitForUpdate
			angle = normalizeAngle(homeViewDirection - robot.ownPosition.viewDirection)
		}
	}
	
	private def getHomeViewDirection() {
		switch robot.robotID {
			case Xtend: 180
			case Xtext: 0
		}
	}
	
	private def getHomePosition() {
		switch robot.robotID {
			case Xtend: new Position(-ARENA_RADIUS * 0.6, 0)
			case Xtext: new Position(ARENA_RADIUS * 0.6, 0)
		}
	}
	
	private def waitForUpdate(IRemoteRobot robot) {
		Thread.sleep(200)
		robot.waitForUpdate(INetConfig.SOCKET_TIMEOUT)
	}
	
}