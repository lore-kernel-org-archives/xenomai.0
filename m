Message-ID: <4821B345.5070001@domain.hid>
Date: Wed, 07 May 2008 15:48:53 +0200
From: "Hillier, Gernot" <gernot.hillier@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050809000405010609080207"
Subject: [Xenomai-core] [patch] disallow includedir /usr/include
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------050809000405010609080207
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi again!

Current SVN head fails to do "make install" when you use --prefix=/usr 
resulting in the includedir /usr/include:

--- SNIP ---
make[2]: Entering directory `/home/gernot/xenomai/include'
make[3]: Entering directory `/home/gernot/xenomai/include'
make[3]: Nothing to be done for `install-exec-am'.
rm -f /usr/include/asm
rm: cannot remove `/usr/include/asm': Is a directory
make[3]: *** [install-data-local] Error 1
--- SNAP ---

As far as I understood Jan, using /usr/include is a bad idea, so I 
created a patch telling the user what went wrong in a nicer way.

Please apply if you consider it to be the right fix (tm).

-- 
Gernot Hillier
Siemens AG, CT SE 2
Corporate Competence Center Embedded Linux

--------------050809000405010609080207
Content-Type: text/x-diff;
 name="xenomai-catch-wrong-includedir.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-catch-wrong-includedir.diff"

Index: configure.in
===================================================================
--- configure.in	(Revision 3755)
+++ configure.in	(Arbeitskopie)
@@ -14,6 +14,10 @@
 	XENO_EMPTY_CFLAGS=false
 fi
 
+if eval test $includedir = /usr/include; then
+  AC_MSG_ERROR([Using /usr/include as includedir is not supported. Please change your --prefix or specify another --includedir])
+fi
+
 AC_CONFIG_HEADERS(src/include/xeno_config.h)
 AC_CONFIG_AUX_DIR(config)
 AC_CONFIG_SRCDIR(src/skins/native/task.c)

--------------050809000405010609080207--

