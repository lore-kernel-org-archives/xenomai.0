Message-ID: <443E9BF5.2050702@domain.hid>
Date: Thu, 13 Apr 2006 20:44:05 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems running testsuite
References: <200604131149.40706.tmarscha@domain.hid>
	<443E4F7D.6090103@domain.hid>
In-Reply-To: <443E4F7D.6090103@domain.hid>
Content-Type: multipart/mixed; boundary="------------090703000702060809040707"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090703000702060809040707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jim Cromie wrote:
> Tobias Marschall wrote:
> 
>> Hallo,
>>
>> I've been using rtai until now and decided to give xenomai (release 
>> 2.1) a try. I followed the instructions from README.INSTALL, and 
>> everything (kernel patching, compilation, etc.) went fine. Then I 
>> tried to run the latency test, which failed:
>>
>> -----------
>> /usr/xenomai/testsuite/latency $ ./run
>> head: `-1' option is obsolete; use `-n 1' since this will be removed 
>> in the   
> 
> 
> this particular error is patched, attached.

While I was at it, I've fixed other spots in the same vein, in other 
scripts. This patch applies against v2.1.0.

-- 

Philippe.

--------------090703000702060809040707
Content-Type: text/x-patch;
 name="fix-head-obsolete-syntax.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-head-obsolete-syntax.patch"

Index: scripts/xeno-info
===================================================================
--- scripts/xeno-info	(revision 924)
+++ scripts/xeno-info	(working copy)
@@ -54,7 +54,7 @@
 -e 's/\.so$//' | awk -F'[.-]'   '{print "Linux C Library        " \
 $(NF-2)"."$(NF-1)"."$NF}'
 
-ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -1 | awk \
+ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -n1 | awk \
 'NR==1{print "Dynamic linker (ldd)  ", $NF}'
 
 ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
Index: scripts/prepare-kernel.sh
===================================================================
--- scripts/prepare-kernel.sh	(revision 924)
+++ scripts/prepare-kernel.sh	(working copy)
@@ -321,7 +321,7 @@
    exit 2
 else
    if test x$adeos_patch = x; then
-      default_adeos_patch=`( ls $xenomai_root/ksrc/arch/$xenomai_arch/patches/adeos-ipipe-$linux_VERSION.$linux_PATCHLEVEL*|sort -r ) 2>/dev/null | head -1`
+      default_adeos_patch=`( ls $xenomai_root/ksrc/arch/$xenomai_arch/patches/adeos-ipipe-$linux_VERSION.$linux_PATCHLEVEL*|sort -r ) 2>/dev/null | head -n1`
    fi
    if test x$default_adeos_patch = x; then
       default_adeos_patch=/dev/null
Index: scripts/xeno-load.in
===================================================================
--- scripts/xeno-load.in	(revision 924)
+++ scripts/xeno-load.in	(working copy)
@@ -56,7 +56,7 @@
 fi
 
 if test $target_name = default; then
-  target_name=`cut -s -d: -f1 $run_info_file | head -1`
+  target_name=`cut -s -d: -f1 $run_info_file | head -n1`
   if test "x$target_name" = x; then
      echo "xeno-load: no target defined in $run_info_file"
      exit 2

--------------090703000702060809040707--

