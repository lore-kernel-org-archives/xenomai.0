From: Norbert Lange <nolange79@gmail.com>
Subject: improve and provide a header for bootstrapping
Date: Tue, 23 Oct 2018 17:16:45 +0200
Message-Id: <20181023151647.25508-1-norbert.lange@andritz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

the following patches allow a variety of options additional
to the linker magic involved for hijacking the aplications main
function.

the original method will still continue to work, differences are

*   the code dealing with retrieving the commandline arguments
    is moved into libcobale/libmercury. Making the necessary per-application
    code much smaller.

*   the implementation was moved into a header, with several macros
    controlling functionality (not everyone wants to define a main function).


The approach I use personally is to compile and link my own bootstrap code,
which is preferable in many build systems as source-files are understood while
objects files generally need some special care. (And it cant hurt if the compiler
flags match exactly).

As example:

----- add this to your file  containing main

int xenomai_init_getargv(int *argc, char *const** argv);

int main(int argc, char *const argv[])
{
#if defined(__COBALT__) || defined(__MERCURY__)
    xenomai_init_getargv(&argc, &argv);
#endif
	....
}

----- create another file, lets call it mybootstrap.c

#define _XENOMAI_BOOTSTRAP_GLIBC_CONSTRUCTORS
#include <xenomai/bootstrap-template.h>

----------------------------------------------

Norbert

[PATCH 1/2] separate bootstrap code to get commandline, move it into
[PATCH 2/2] add a header to create flexible bootstrap code



