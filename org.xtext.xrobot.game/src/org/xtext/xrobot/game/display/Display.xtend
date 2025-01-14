package org.xtext.xrobot.game.display

import com.google.inject.Singleton
import java.util.List
import javafx.animation.FadeTransition
import javafx.animation.Interpolator
import javafx.animation.ScaleTransition
import javafx.animation.SequentialTransition
import javafx.application.Platform
import javafx.event.EventHandler
import javafx.geometry.Pos
import javafx.scene.Group
import javafx.scene.Scene
import javafx.scene.control.Button
import javafx.scene.control.Label
import javafx.scene.effect.InnerShadow
import javafx.scene.image.Image
import javafx.scene.image.ImageView
import javafx.scene.input.KeyEvent
import javafx.scene.layout.StackPane
import javafx.scene.layout.VBox
import javafx.scene.paint.Color
import javafx.stage.Screen
import javafx.stage.Stage
import javafx.stage.StageStyle
import javafx.util.Duration
import javax.inject.Inject
import org.xtext.xrobot.game.Game
import org.xtext.xrobot.game.IErrorReporter
import org.xtext.xrobot.game.ITimeListener
import org.xtext.xrobot.game.PlayerSlot

import static javafx.scene.layout.Region.*

import static extension javafx.util.Duration.*
import javafx.scene.text.TextAlignment

@Singleton
class Display implements IErrorReporter, ITimeListener {

	@Inject RootPane rootPane
	@Inject IdleProgram idleProgram
	@Inject StackPane centerPane
	@Inject VBox messagePane
	@Inject Label timeLabel

	List<PlayerSlotBox> slotBoxes
	
	def start(Stage stage, List<PlayerSlot> slots) throws Exception {
		idleProgram.init
		val screenBounds = Screen.getPrimary.bounds
		stage => [
			initStyle(StageStyle.TRANSPARENT);
			scene = new Scene(
				rootPane => [
					styleClass += 'border-pane'
					center = centerPane => [
						children += timeLabel => [
							styleClass += 'time'
							StackPane.setAlignment(timeLabel, Pos.TOP_CENTER)
						]
						children += idleProgram
						children += messagePane => [
							styleClass += 'message-pane'
						]
					]
					val xtendBox = new PlayerSlotBox(slots.head)
					val xtextBox = new PlayerSlotBox(slots.last)
					slotBoxes = #[xtendBox, xtextBox]
					left = xtendBox 
					bottomLeft = new VBox => [
						styleClass += #['outer-box', 'hof', 'hof-box']
						alignment = Pos.CENTER
						children += new Label => [
							text = 'XRobots'
							styleClass += #['boxed-label', 'logo']
							effect = new InnerShadow => [
								color = Color.RED
								width = 3.2
								height = 3.2
							]
						]
						children += new Label => [
							textAlignment = TextAlignment.CENTER
							text = 'Join the game at\nhttp://xrobots.itemis.de'
							styleClass += #['boxed-label', 'side-container-label']
						]
					]
					right = xtextBox
					bottomRight = new VBox => [
						styleClass += #['outer-box', 'hof', 'hof-box']
						alignment = Pos.CENTER
						spacing = 5
						children += new ImageView => [
							image = new Image(IdleProgram.getResourceAsStream('/qrcode.jpg'))
							fitWidth = image.width * 0.67
							fitHeight = image.height * 0.67
						]
					]
					overlay = new Group => [
						children += slots.map[new Balloon(it)]
					]
				], screenBounds.width, screenBounds.height) => [
				fill = null
				stylesheets += 'org/xtext/xrobot/game/display/Styles.css'
			]
			show
		]
		startIdleProgram
	}

	def startIdleProgram() {
		Platform.runLater[
			idleProgram.start
		]
	}
	
	def addKeyAction(Runnable action) {
		Platform.runLater [
			val EventHandler<KeyEvent> handler = [ KeyEvent it | 
				action.run()
				rootPane.scene.removeEventHandler(KeyEvent.KEY_TYPED, self)
			]
			rootPane.scene.addEventHandler(KeyEvent.KEY_TYPED, handler)
		]
	}

	def aboutToStart(Game game) {
		updateTime(game.gameDuration)
		Platform.runLater[
			idleProgram.stop
			countdown()
		]
		Thread.sleep(3000)
	}

	def countdown() {
		val label = new Label('Ready') => [
			styleClass += 'countdown'
			textFill = Color.YELLOW
			effect = new InnerShadow => [
				color = Color.RED
				width = 20
				height = 20
			]
		]
		centerPane.children += label
		new SequentialTransition => [
			children += getPopupTransition(label, 'Steady')
			children += getPopupTransition(label, 'Fight!')
			children += getPopupTransition(label, '')
			onFinished = [
				centerPane.children -= label
			]
			play
		]
	}

	private def getPopupTransition(Label label, String nextText) {
		new ScaleTransition => [
			fromX = 0.01
			toX = 1
			fromY = 0.01
			toY = 1
			node = label
			duration = 1.seconds
			interpolator = Interpolator.EASE_OUT
			onFinished = [
				label => [
					scaleX = 0.1
					scaleY = 0.1
					label.text = nextText
				]
			]
		]
	}

	def boolean askRepeat(Throwable exc) {
		// TODO implement
		false
	}

	override showError(String message, Duration duration) {
		showMessage(message, 'error', duration)
	}
	
	override showWarning(String message, Duration duration) {
		showMessage(message, 'warning', duration)
	}
	
	override showInfo(String message, Duration duration) {
		showMessage(message, 'info', duration)
	}
	
	override showMessage(String message, String stylePrefix, Duration duration) {
		Platform.runLater [
			val errorBox = new VBox => [
				setMaxSize(USE_PREF_SIZE, USE_PREF_SIZE)
				styleClass += #['outer-box', stylePrefix + '-box']
				children += new Label(message) => [
					styleClass += #[stylePrefix + '-label']
				]
			]
			messagePane.children += errorBox
			val fade = new FadeTransition => [
				node = errorBox
				fromValue = 1
				toValue = 0
				onFinished = [
					messagePane.children -= errorBox
				]
			]
			if(duration == INDEFINITE) {
				errorBox.children += new Button('OK') => [
					onAction = [
						fade.play
					]
				]
			} else {
				fade => [
					delay = duration
					play 
				]
			}
		]
	}
	
	override updateTime(long millisLeft) {
		Platform.runLater[
			val minutesLeft = millisLeft / 1000 / 60
			val secondsLeft = millisLeft / 1000
			timeLabel.setText(String.format('%1d:%02d', minutesLeft, secondsLeft))
		]
	}
	
}
