package org.xtext.xrobot.game.example

import org.eclipse.xtend.lib.annotations.Data

@Data
class ExampleRobot {

	String id
	String code

	def getURI() {
		id + '.xrobot'
	}	
	
	override toString() {
		id
	}
	
	@Data
	static class Provider {
		
		val exampleRobots = #[
			new ExampleRobot('Rotor', '''
				robot Rotor
				author itemis
				
				Spin {
					startMotors(maxDrivingSpeed, -maxDrivingSpeed)
					scoop(1)
					scoop(0)
				}
			''')
		]
	}
}