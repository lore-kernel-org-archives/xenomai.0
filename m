Message-ID: <4A3CD3C8.2030707@domain.hid>
Date: Sat, 20 Jun 2009 14:19:20 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <20090605113159.98990@domain.hid>
In-Reply-To: <20090605113159.98990@domain.hid>
Content-Type: multipart/mixed; boundary="------------020909050608030608040507"
Subject: Re: [Xenomai-help] Error during applying a patch created with
 --outpatch option of prepare-kernel.sh
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xoro@domain.hid, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020909050608030608040507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

xoro@domain.hid schrieb:
> Hi,
>
> I am creating a patch using the the --outpatch option of the prepare-kernel.sh script. During patching the created patch to the linux kernel I get the following messages:
> patching file include/xenomai/psos+/queue.h
> patching file include/xenomai/psos+/sem.h
> patching file init/Kconfig
> Hunk #1 FAILED at 1065.
> 1 out of 1 hunk FAILED -- saving rejects to file init/Kconfig.rej
>   
patch attached.

@philippe:
the problem is the same hunk as in my "debian specific" unpatch problem [1].

kisda

https://mail.gna.org/public/xenomai-help/2009-06/msg00091.html

> patching file kernel/Makefile
> Hunk #1 succeeded at 124 (offset -1 lines).
> patching file kernel/xenomai/Makefile
> patching file kernel/xenomai/nucleus/pod.c
>
> This behaviour can be reproduced by executing the following commands:
> wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.4.tar.bz2
> wget http://download.gna.org/xenomai/stable/xenomai-2.4.8.tar.bz2
> tar xjf linux-2.6.29.4.tar.bz2
> tar xjf xenomai-2.4.8.tar.bz2
> mkdir tmp
> ./xenomai-2.4.8/scripts/prepare-kernel.sh --linux=./linux-2.6.29.4 --arch=i686 --adeos=./xenomai-2.4.8/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-2.4-01.patch --outpatch=./xenomai-2.4.8_linux-2.6.29.4.patch ./tmp --verbose
> mv linux-2.6.29.4 linux-2.6.29.4.bak
> tar xjf linux-2.6.29.4.tar.bz2
> cd linux-2.6.29.4
> patch -p1 < ../xenomai-2.4.8_linux-2.6.29.4.patch
>
> If I patch the kernel directly without using the --outpatch option patching works fine.
>
> Am I missing an option of the prepare-kernel.sh script, or is this a bug in the prepare-kernel.sh script?
>
> PS: Executing "prepare-kernel.sh --help" gives the following output:
> usage: prepare-kernel --linux=<linux-tree> --adeos=<adeos-patch> [--arch=<arch>] [--outpatch=<file> <tempdir> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]
> It looks as if the closing bracket "]" after "[--outpatch=<file> <tempdir>" is missing.
>
>
> Thank you for your help!
>
> Xoro
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>   


--------------020909050608030608040507
Content-Type: text/x-diff;
 name="outpatch-2.6.29.4-x86.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="outpatch-2.6.29.4-x86.patch"

diff -uNrp xenomai-2.4.8.orig/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-2.4-01.patch xenomai-2.4.8/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-2.4-01.patch
--- xenomai-2.4.8.orig/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-2.4-01.patch	2009-05-27 23:55:00.000000000 +0200
+++ xenomai-2.4.8/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-2.4-01.patch	2009-06-20 13:58:28.000000000 +0200
@@ -6326,11 +6326,6 @@ index 6a5c5fe..759609e 100644
  	help
  	  Append an extra string to the end of your kernel version.
  	  This will show up when you type uname, for example.
-@@ -1064,4 +1065,3 @@ source "block/Kconfig"
- 
- config PREEMPT_NOTIFIERS
- 	bool
--
 diff --git a/init/main.c b/init/main.c
 index 83697e1..cb17ff5 100644
 --- a/init/main.c

--------------020909050608030608040507--

