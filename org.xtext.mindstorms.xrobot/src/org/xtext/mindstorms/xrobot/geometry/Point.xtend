package org.xtext.mindstorms.xrobot.geometry

import org.eclipse.xtend.lib.annotations.Data

@Data
class Point {
	double x
	double y
	
	def +(Point other) {
		new Point(other.x + x, other.y + y)
	}
	
	def -(Point other) {
		new Point(x - other.x, y - other.y)
	}
	
	def *(double scale) {
		new Point(x * scale, y * scale)
	}
}