Content-Type: text/plain; charset="us-ascii"
Date: Fri, 05 Jun 2009 13:31:59 +0200
From: xoro@domain.hid
Message-ID: <20090605113159.98990@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Error during applying a patch created with
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
To: xenomai@xenomai.org

Hi,

I am creating a patch using the the --outpatch option of the prepare-kernel.sh script. During patching the created patch to the linux kernel I get the following messages:
patching file include/xenomai/psos+/queue.h
patching file include/xenomai/psos+/sem.h
patching file init/Kconfig
Hunk #1 FAILED at 1065.
1 out of 1 hunk FAILED -- saving rejects to file init/Kconfig.rej
patching file kernel/Makefile
Hunk #1 succeeded at 124 (offset -1 lines).
patching file kernel/xenomai/Makefile
patching file kernel/xenomai/nucleus/pod.c

This behaviour can be reproduced by executing the following commands:
wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.4.tar.bz2
wget http://download.gna.org/xenomai/stable/xenomai-2.4.8.tar.bz2
tar xjf linux-2.6.29.4.tar.bz2
tar xjf xenomai-2.4.8.tar.bz2
mkdir tmp
./xenomai-2.4.8/scripts/prepare-kernel.sh --linux=./linux-2.6.29.4 --arch=i686 --adeos=./xenomai-2.4.8/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-2.4-01.patch --outpatch=./xenomai-2.4.8_linux-2.6.29.4.patch ./tmp --verbose
mv linux-2.6.29.4 linux-2.6.29.4.bak
tar xjf linux-2.6.29.4.tar.bz2
cd linux-2.6.29.4
patch -p1 < ../xenomai-2.4.8_linux-2.6.29.4.patch

If I patch the kernel directly without using the --outpatch option patching works fine.

Am I missing an option of the prepare-kernel.sh script, or is this a bug in the prepare-kernel.sh script?

PS: Executing "prepare-kernel.sh --help" gives the following output:
usage: prepare-kernel --linux=<linux-tree> --adeos=<adeos-patch> [--arch=<arch>] [--outpatch=<file> <tempdir> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]
It looks as if the closing bracket "]" after "[--outpatch=<file> <tempdir>" is missing.


Thank you for your help!

Xoro

