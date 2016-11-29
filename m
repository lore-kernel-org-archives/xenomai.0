Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <bfd126e4fbc87bb85340.1480399086@devws148.be.alcatel-lucent.com>
Date: Tue, 29 Nov 2016 06:58:06 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH] Mercury/psos: Solve compiler warning when
	including psos.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In boilerplate function 'get_program_name', basename is used.

When libgen.h is incuded in your program, the basename gets the POSIX
version (no const char*, see 'man basename'):
char *basename(char *path);

This results in the following compiler warning:
boilerplate/setup.h: In function 'const char* get_program_name()':
boilerplate/setup.h:107: error: invalid conversion from 'const char*' to 'char*'
boilerplate/setup.h:107: error:   initializing argument 1 of 'char* __xpg_basename(char*)'

Test application:

#include <libgen.h>
#include <psos/psos.h>
int main(int argc, char * const argv[])
{
  return 0;
}

When the libgen.h is not included, the warning is not seen.

This patch solve the above issue creating a string on the stack instead of
a constant string.

diff --git a/include/boilerplate/setup.h b/include/boilerplate/setup.h
--- a/include/boilerplate/setup.h
+++ b/include/boilerplate/setup.h
@@ -104,7 +104,8 @@ extern struct base_setup_data __base_set
 
 static inline const char *get_program_name(void)
 {
-	return basename(__base_setup_data.arg0 ?: "program");
+	char local_copy[] = {'p', 'r', 'o', 'g', 'r', 'a', 'm', '\0' };
+	return basename( (char*)(__base_setup_data.arg0 ? : local_copy) );
 }
 
 void __trace_me(const char *fmt, ...);

