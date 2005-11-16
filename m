Message-ID: <437B162F.1040109@domain.hid>
Date: Wed, 16 Nov 2005 13:21:19 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040709050101060806080208"
Subject: [Xenomai-core] [PATCH] Small build system fix for Xenomai 2.1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040709050101060806080208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The prepare-kernel.sh script doesn't link assembly files to the kernel 
at all. This should fix it.

-- Heikki Lindholm

--------------040709050101060806080208
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai2.1-051116-buildsys.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai2.1-051116-buildsys.patch"

diff -Nru xenomai.orig/scripts/prepare-kernel.sh xenomai/scripts/prepare-kernel.sh
--- xenomai.orig/scripts/prepare-kernel.sh	2005-11-14 20:04:19.000000000 +0200
+++ xenomai/scripts/prepare-kernel.sh	2005-11-16 13:03:27.000000000 +0200
@@ -4,7 +4,7 @@
 do_links() {
     rm -fr $2
     ( cd $1 &&
-      find . \( -name Makefile -o -name Kconfig -o -name '*.[ch]' \) |
+      find . \( -name Makefile -o -name Kconfig -o -name '*.[chS]' \) |
       while read f; do
         d=`dirname $f`
 	mkdir -p $2/$d && ln -s $1/$f $2/$f

--------------040709050101060806080208--

