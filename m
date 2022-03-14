From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: [PATCH v7 1/3] build: add options to build plugins of kernelshark
 and libtraceevent
Date: Mon, 14 Mar 2022 01:40:11 +0000
Message-ID: <MN2PR11MB428564BA759A6A2DD0952AB2F20F9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <cover.1647090002.git.jan.kiszka@siemens.com>
 <0b26bd28e2bfca49a4e7582be9f01e74bd74c409.1647090002.git.jan.kiszka@siemens.com>
 <MN2PR11MB428509FCA6398CFBBD3BAC91F20F9@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB428509FCA6398CFBBD3BAC91F20F9@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

>>-----Original Message-----
>>From: Jan Kiszka <jan.kiszka@siemens.com>=20
>>Sent: Saturday, March 12, 2022 9:00 PM
>>To: xenomai@xenomai.org
>>Cc: Chen, Hongzhan <hongzhan.chen@intel.com>
>>Subject: [PATCH v7 1/3] build: add options to build plugins of kernelshar=
k and libtraceevent
>>
>>From: Hongzhan Chen <hongzhan.chen@intel.com>
>>
>>To build plugins of kernelshark and libtraceevent, add options and
>>do necessary configuration.
>>
>>Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>>[Jan: cleaned up AC_ARG_ENABLE matches, add missing kshark dep, drop INST=
ALLDIRs]
>>Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>---
>> configure.ac | 33 +++++++++++++++++++++++++++++++++
>> 1 file changed, 33 insertions(+)
>>
>>diff --git a/configure.ac b/configure.ac
>>index 16cffd8f81..ef450aa582 100644
>>--- a/configure.ac
>>+++ b/configure.ac
>>@@ -91,6 +91,8 @@ AC_ARG_WITH(cxx,
>>     ])
>> AC_PROG_CXX
>>=20
>>+PKG_PROG_PKG_CONFIG
>>+
>> # Do not let autoconf set the default value of CFLAGS
>> if $XENO_EMPTY_CFLAGS; then
>> 	CFLAGS=3D""
>>@@ -826,6 +828,37 @@ AC_ARG_WITH(demodir,
>>     ], [XENO_DEMO_DIR=3D$demodir])
>> AC_MSG_RESULT($XENO_DEMO_DIR)
>>=20
>>+kernelshark_plugin=3D
>>+AC_MSG_CHECKING(whether KernelShark plugin should be built)
>>+AC_ARG_ENABLE(kernelshark_plugin,
>>+	AS_HELP_STRING([--enable-kernelshark-plugin], [build KernelShark plugin=
]),
>>+	[case "$enableval" in
>>+	y | yes) kernelshark_plugin=3Dy ;;
>>+	*) unset kernelshark_plugin ;;
>>+	esac])
>>+AC_MSG_RESULT(${kernelshark_plugin:-no})
>>+AM_CONDITIONAL(XENO_KSHARK_PLUGIN, [test x$kernelshark_plugin =3D xy])
>>+
>>+libtraceevent_plugin=3D
>>+AC_MSG_CHECKING(whether libtraceevent plugin should be built)
>>+AC_ARG_ENABLE(libtraceevent_plugin,
>>+	AS_HELP_STRING([--enable-libtraceevent-plugin], [build libtraceevent pl=
ugin]),
>>+	[case "$enableval" in
>>+	y | yes) libtraceevent_plugin=3Dy ;;
>>+	*) unset libtraceevent_plugin ;;
>>+	esac])
>>+AC_MSG_RESULT(${libtraceevent_plugin:-no})
>>+AM_CONDITIONAL(XENO_LIBTRACEEVENT_PLUGIN, [test x$libtraceevent_plugin =
=3D xy])
>>+
>>+if test x$kernelshark_plugin =3D xy -o x$libtraceevent_plugin =3D xy; th=
en
>>+	PKG_CHECK_MODULES(LIBTRACEEVENT, libtraceevent)
>>+fi
>>+
>>+if test x$kernelshark_plugin =3D xy; then
>>+	PKG_CHECK_MODULES(LIBKSHARK, libkshark)
>>+	PKG_CHECK_MODULES(LIBTRACEFS, libtracefs)
>
>I do not quite understand why we check LIBTRAEFS here because kernelshark =
depend on libtracefs=20
>as described in [1] which should be handled by kernelshark module itself.
>If we have to check libtracefs, why we do not check other dependency modul=
e like libtraceevent  for kernelshark_plugin?

I just found libtraceevent module already be checked in previous code. But =
kernelshark also depends on trace-cmd. Do we need to check it here?

Regards

Hongzhan Chen

>
>Regards
>
>Hongzhan Chen=20
>
>[1]: https://git.kernel.org/pub/scm/utils/trace-cmd/kernel-shark.git/tree/=
README
>
>>+fi
>>+
>> AC_MSG_CHECKING([for test source generation])
>> AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
>>     [AC_MSG_RESULT(ok)], [AC_MSG_RESULT(failed)], [AC_MSG_RESULT(untesta=
ble)])
>>--=20
>>2.34.1
>>

