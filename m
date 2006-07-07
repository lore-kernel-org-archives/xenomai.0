From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XJ/wMgSg8h"
Content-Transfer-Encoding: 7bit
Message-ID: <17582.29404.194269.473795@domain.hid>
Date: Fri, 7 Jul 2006 16:42:36 +0200
Subject: Re: [Xenomai-help] upgrading versions of xenomai 2.2
In-Reply-To: <02AA386EB831044F8537A696BA785C78A66771@domain.hid>
References: <02AA386EB831044F8537A696BA785C78A66771@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org


--XJ/wMgSg8h
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Landau, Bracha wrote:
 > I have encountered trouble upgrading from xenomai-2.2 rc2 to xenomai 2.2 rc3.
 > If the "prepare-script" file encounters a kernel which already has the "xenomai" directories included (from a previous version of xenomai), the "prepare-kernel" script will not do anything.
 > 
 > In order to bypass this problem I had to search for all the "xenomai" subdirectories in the linux tree and rename them. (I searched for the "patch_link" commands inside "prepare-kernel" in order to know what had to be re-patched.)
 > 
 > Is there a way you can indicate that you want to upgrade your kernel?

Revision 1298 should fix this. See attached patch.

 > 
 > Also, for some reason I had to comment out "unset CDPATH" in the "prepare-kernel" script (2nd line) to get it to do anything.

Do you experience this problem even when passing fully qualified pathes ?

-- 


					    Gilles Chanteperdrix.

--XJ/wMgSg8h
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-prepare-kernel.diff"
Content-Transfer-Encoding: 7bit

Index: scripts/prepare-kernel.sh
===================================================================
--- scripts/prepare-kernel.sh	(revision 1297)
+++ scripts/prepare-kernel.sh	(revision 1298)
@@ -113,7 +113,9 @@
             d=`dirname $f`
             if test "x$output_patch" = "x"; then
                 mkdir -p $linux_tree/$link_dir/$d
-                if test x$forcelink = x1 -o ! -h $linux_tree/$link_dir/$f; then
+                if test x$forcelink = x1 -o \
+		   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
+		then
                     ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
                 fi
             else

--XJ/wMgSg8h--

