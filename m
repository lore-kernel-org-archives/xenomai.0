From: Lange Norbert <norbert.lange@andritz.com>
Date: Mon, 23 Apr 2018 14:37:33 +0000
Message-ID: <99BAB48E90E86D42AD41F0BCE3225AEB019FC0FA2C@GRZSMS582.andritz.com>
References: <20180423142420.5429-1-norbert.lange@andritz.com>
 <20180423142420.5429-3-norbert.lange@andritz.com>
In-Reply-To: <20180423142420.5429-3-norbert.lange@andritz.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [PATCH 3/3] provide an extended xenomai_init function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Short Explanation:

This first patch adds a header for creating bootstrap code,
The difference with the auto-init method being that this
should be preferable compiled together with the application.
Upside is that the compilation units (xenomai libs and applications)
now are cleanly separated and arcane linker wrapping is not needed.

This will need some changes, which should be no issue for new
Applications, eg. The main routine needs a small adaption:

--------------------------------
int xenomai_init_getargv(int *argc, char *const** argv);

extern "C" int main(int argc, char *const argv[], char * const envp[])
{
    xenomai_init_getargv(&argc, &argv);
....
}

--------------------------------

And in one file you need to instance the bootstrap code like this:
--------------------------------
#define _XENOMAI_BOOTSTRAP_DEFINE_MAINWRAPPER __real_main
#define _XENOMAI_BOOTSTRAP_WEAKREF_MAINWRAPPER __wrap_main
#include <xenomai/bootstrap-template.h>
--------------------------------

auto-init is still supported as before.

Second patch would move some code into the xenomai libraries,
The last one would allow passing flags to the xenomai_init routine.


I would also like to know if the glibc specific simplification would be
acceptable to be enabled by default. (_XENOMAI_BOOTSTRAP_GLIBC_CONSTRUCTORS=
)
I tested it both for executable and shared libraries and it does work,
But I am not so certain with the macro guards and how long this extended
Functionality has been available.

Kind regards,
Norbert

-----Original Message-----
From: Norbert Lange <nolange79@gmail.com>
Sent: Montag, 23. April 2018 16:24
To: xenomai@xenomai.org
Cc: Lange Norbert <norbert.lange@andritz.com>
Subject: [PATCH 3/3] provide an extended xenomai_init function

E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE EXERCISE CA=
UTION WITH E-MAIL CONTENT AND ANY LINKS OR ATTACHMENTS.


This function is a single entrypoint for both shared libraries and executab=
les.
Futher it allows passing flags as additional argument.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 include/xenomai/bootstrap-template.h | 19 +++++++++++++
 include/xenomai/init.h               |  2 ++
 lib/boilerplate/setup.c              | 42 +++++++++++++++++++---------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/xenomai/bootstrap-template.h b/include/xenomai/bootstr=
ap-template.h
index d9fb0b313..29eb8e8d6 100644
--- a/include/xenomai/bootstrap-template.h
+++ b/include/xenomai/bootstrap-template.h
@@ -81,6 +81,8 @@
  *                  Set a weak reference to the defined main function
  * _XENOMAI_BOOTSTRAP_DSO
  *                  Should be defined when building shared libraries
+ * _XENOMAI_BOOTSTRAP_INITFLAGS
+ *                  Flags passed to the xenomai_init_ext function
  */

 #define _XENOMAI_BOOTSTRAP_GLIBC_CONSTRUCTORS
@@ -256,11 +258,28 @@ __bootstrap_ctor static void xenomai_bootstrap(void)
                return;
 #endif

+
+#if !defined(_XENOMAI_BOOTSTRAP_INITFLAGS)
+       /* prefer previously existing functions for better backwards
+capability */
 #ifdef _XENOMAI_BOOTSTRAP_DSO
        xenomai_init_dso(&argc, &argv);
 #else
        xenomai_init(&argc, &argv);
 #endif
+#else
+       {
+               int isDso =3D 0;
+               unsigned long long bflags =3D 0; #ifdef
+_XENOMAI_BOOTSTRAP_DSO
+               isDso =3D 1;
+#endif
+#ifdef _XENOMAI_BOOTSTRAP_INITFLAGS
+               bflags =3D _XENOMAI_BOOTSTRAP_INITFLAGS; #endif
+               xenomai_init_ext(&argc, &argv, isDso, bflags);
+       }
+#endif
+
        early_argc =3D argc;
        early_argv =3D argv;
 }
diff --git a/include/xenomai/init.h b/include/xenomai/init.h index 2a241aa3=
b..cca3d4c22 100644
--- a/include/xenomai/init.h
+++ b/include/xenomai/init.h
@@ -29,6 +29,8 @@ void xenomai_init(int *argcp, char *const **argvp);

 void xenomai_init_dso(int *argcp, char *const **argvp);

+void xenomai_init_ext(int *argcp, char *const **argvp, int isDso,
+unsigned long flags);
+
 int xenomai_bootstrap_getargv(int *argc, char *const** argv);

 int xenomai_init_fetchargv(int *argcp, char *const **argvp); diff --git a/=
lib/boilerplate/setup.c b/lib/boilerplate/setup.c index 6cd035134..60d37e35=
e 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -486,7 +486,7 @@ __setup_section static int parse_setup_options(int *arg=
cp, char **uargv,
        return 0;
 }

-__setup_section static void __xenomai_init(int *argcp, char *const **argvp=
, const char *me)
+static void __xenomai_init(int *argcp, char *const **argvp, const char
+*me, unsigned long flags)
 {
        struct setup_descriptor *setup;
        int ret, base_opt_start;
@@ -641,25 +641,41 @@ fail:
        early_panic("initialization failed, %s", symerror(ret));  }

-__setup_section void xenomai_init(int *argcp, char *const **argvp)
+static void _xenomai_init_ext(int *argcp, char *const **argvp, int
+isDso, unsigned long flags)
 {
-       const char *me =3D get_program_name();
+       const char *me =3D "DSO";
+       if (isDso)
+       {
+               __xenomai_init(argcp, argvp, me, flags);
+       } else
+       {
+               me =3D get_program_name();

-       if (main_init_done) {
-               early_warning("duplicate call from main program "
-                             "to %s() ignored", __func__);
-               early_warning("(xeno-config --no-auto-init disables implici=
t call)");
-       }
+               if (main_init_done) {
+                       early_warning("duplicate call from main program "
+                                     "to %s() ignored", __func__);
+                       early_warning("(xeno-config --no-auto-init disables=
 implicit call)");
+               }

-       __xenomai_init(argcp, argvp, me);
-       main_init_done =3D 1;
+               __xenomai_init(argcp, argvp, me, flags);
+               main_init_done =3D 1;
+       }
        trace_me("%s bootstrap done", me);  }

-__setup_section void xenomai_init_dso(int *argcp, char *const **argvp)
+void xenomai_init_ext(int *argcp, char *const **argvp, int isDso,
+unsigned long flags) {
+       _xenomai_init_ext(argcp, argvp, isDso, flags); }
+
+void xenomai_init(int *argcp, char *const **argvp) {
+       _xenomai_init_ext(argcp, argvp, 0, 0); }
+
+void xenomai_init_dso(int *argcp, char *const **argvp)
 {
-       __xenomai_init(argcp, argvp, "DSO");
-       trace_me("DSO bootstrap done");
+       _xenomai_init_ext(argcp, argvp, 1, 0);
 }

 void __trace_me(const char *fmt, ...)
--
2.17.0

________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corpor=
ation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

