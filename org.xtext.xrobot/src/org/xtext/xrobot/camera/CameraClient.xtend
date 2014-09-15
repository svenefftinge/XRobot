package org.xtext.xrobot.camera

import TUIO.TuioClient
import java.util.List
import org.xtext.xrobot.RobotID
import org.xtext.xrobot.api.RobotPosition

import static org.xtext.xrobot.api.GeometryExtensions.*
import static org.xtext.xrobot.camera.ICamera.*
import org.xtext.xrobot.net.INetConfig
import java.net.SocketTimeoutException

class CameraClient {

	private val TuioClient client

	new(TuioClient client) {
		this.client = client
		var startTime = System.currentTimeMillis
		while(client.tuioObjects.size() != 2) {
			if(System.currentTimeMillis - startTime > INetConfig.SOCKET_TIMEOUT)
				throw new SocketTimeoutException('No updates from camera server')
			Thread.sleep(50)
		}
	}

	def getRobotPositions() {
		val tuioObjects = client.tuioObjects
		val List<RobotPosition> result = newArrayList
		RobotID.values.forEach [ robotID, i |
			val tuioObject = tuioObjects.findFirst[symbolID == i]
			if (tuioObject != null) {
				result.add(
					new RobotPosition(
						(tuioObject.x - 0.5) * WIDTH_IN_CM,
						(0.5 - tuioObject.y) * HEIGHT_IN_CM,
						robotID,
						// TODO verify: I assume in TUIO 0° means NORTH and 90° means WEST
						normalizeAngle(tuioObject.angleDegrees - 90)
					))
			}
		]
		result
	}
}
