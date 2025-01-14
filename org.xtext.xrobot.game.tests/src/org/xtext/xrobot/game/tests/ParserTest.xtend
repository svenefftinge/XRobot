package org.xtext.xrobot.game.tests

import com.google.inject.Inject
import com.google.inject.Provider
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.parser.ParseException
import org.eclipse.xtext.resource.XtextResourceSet
import org.junit.Test
import org.junit.runner.RunWith
import org.xtext.xrobot.dsl.XRobotDSLInjectorProvider
import org.xtext.xrobot.dsl.interpreter.ScriptParser
import org.xtext.xrobot.dsl.xRobotDSL.Program

import static org.hamcrest.CoreMatchers.instanceOf
import static org.junit.Assert.*

@RunWith(XtextRunner)
@InjectWith(XRobotDSLInjectorProvider)
class ParserTest {
	
	@Inject ScriptParser scriptParser
	
	@Inject Provider<XtextResourceSet> resourceSetProvider
	
	@Test
	def void testParse() {
		val result = scriptParser.parse('dummy.xrobot', TestScripts.IDLE, resourceSetProvider.get)
		assertThat(result, instanceOf(Program))
	}
	
	@Test(expected = ParseException)
	def void testSyntaxError() {
		scriptParser.parse('dummy.xrobot', '''
			robot Test author Test
			Test {
				valz x = 0
			}
		''', resourceSetProvider.get)
	}
	
	@Test(expected = ParseException)
	def void testTypeError() {
		scriptParser.parse('dummy.xrobot', '''
			robot Test author Test
			Test {
				val int x = 0.0
			}
		''', resourceSetProvider.get)
	}
	
	@Test(expected = ParseException)
	def void testUnknownClass() {
		scriptParser.parse('dummy.xrobot', '''
			robot Test author Test
			Test {
				val x = new org.nonsense.Universe()
			}
		''', resourceSetProvider.get)
	}
	
	@Test(expected = ParseException)
	def void testConstructorAccess() {
		scriptParser.parse('dummy.xrobot', '''
			robot Test author Test
			Test {
				new java.io.File("/etc/ftpd.conf")
			}
		''', resourceSetProvider.get)
	}
	
	@Test(expected = ParseException)
	def void testMethodAccess() {
		scriptParser.parse('dummy.xrobot', '''
			robot Test author Test
			Test {
				java.io.File.createTempFile("test", ".txt")
			}
		''', resourceSetProvider.get)
	}
	
}