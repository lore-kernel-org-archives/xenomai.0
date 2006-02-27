From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="B1WOAmzTTz"
Content-Transfer-Encoding: 7bit
Message-ID: <17411.1445.159527.784570@domain.hid>
Date: Mon, 27 Feb 2006 14:59:01 +0100
Subject: Re: [Xenomai-core] [BUG] prepare-kernel is broken
In-Reply-To: <4402FA52.3080606@domain.hid>
References: <4402FA52.3080606@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


--B1WOAmzTTz
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
 > Hi,
 > 
 > the last check-in seems to have messed something up:
 > 
 > .../xenomai/scripts/prepare-kernel.sh: line 61: syntax error near
 > unexpected token `fi'
 > 
 > I do not understand what's going on here, so I don't want to hack some
 > probably wrong fix for this.

In order to have it work, I had to make the following changes to
revision 610 :


--B1WOAmzTTz
Content-Type: text/plain
Content-Disposition: inline;
	filename="prepare-kernel.diff"
Content-Transfer-Encoding: 7bit

Index: prepare-kernel.sh
===================================================================
--- prepare-kernel.sh	(revision 610)
+++ prepare-kernel.sh	(working copy)
@@ -42,7 +42,7 @@
         recursive_opt=""
         directorytype_opt=""
         if test x$recursive = xr; then
-            directorytype_opt="\( -type d -mindepth 1 \) -o"
+            directorytype_opt="( -type d -mindepth 1 ) -o"
         else
             recursive_opt="-maxdepth 1"
         fi
@@ -51,13 +51,13 @@
             link_makefiles_opt="-name Makefile -o"
         fi
 
-        if test "x$output_patch" = "x"; then
+        if test "x$output_patch" = "x" -a -e $linux_tree/$link_dir; then
             cd $linux_tree/$link_dir &&
 	    find . $recursive_opt \( $directorytype_opt \
                 $link_makefiles_opt -name $config_file -o -name '*.[chS]' \) |
             while read f; do
                 if test ! -e $xenomai_root/$target_dir/$f; then rm -Rf $f; fi
-            done; else true; fi &&
+            done
         fi
 
         cd $xenomai_root/$target_dir &&

--B1WOAmzTTz
Content-Type: text/plain; charset=us-ascii
Content-Description: .signature
Content-Transfer-Encoding: 7bit


-- 


					    Gilles Chanteperdrix.

--B1WOAmzTTz--

