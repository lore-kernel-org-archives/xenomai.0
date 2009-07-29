Date: Wed, 29 Jul 2009 22:55:57 +0200 (CEST)
From: "Waschk,Kolja" <xenoka09@domain.hid>
In-Reply-To: <1248883517.3532.7.camel@domain.hid>
Message-ID: <alpine.DEB.2.00.0907292209410.5958@domain.hid>
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid>
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
	<1248461458.3998.183.camel@domain.hid>
	<alpine.DEB.2.00.0907242259430.4343@domain.hid>
	<1248517986.4438.1.camel@domain.hid>
	<alpine.DEB.2.00.0907281859210.4673@domain.hid>
	<1248855797.3247.16.camel@domain.hid>
	<Pine.LNX.4.62.0907291210470.20869@domain.hid>
	<Pine.LNX.4.62.0907291226390.20869@domain.hid>
	<1248883517.3532.7.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Stack sizes etc. (Re: POSIX skin/Blackfin:
 SIGSEGV when stracing or gdb'ing)
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

> This may be an I-pipe issue. As I understand, you are currently running
> 2009R1-RC2 unmodified, could you summarize where the various Xenomai
> related components come from so I could try looking at the issue?

I'll try: I haven't put in any extra sources, and it seems that
user/xenomai/Makefile indeed refers to ADEOS =
$(ROOTDIR)/bfin_patch/adeos_patch/adeos-bfin.patch

The latest SVN log entry says "update to
http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-2.6.28.10-blackfin.git-1.10-00.patch"
however adeos-bfin.patch in there is not exactly that file.

Also, I use and didn't touch anything inside the dist's
user/xenomai/xenomai-2.4.7 directory which seems to contain
the almost unmodified 2.4.7 sources. Only minor changes regarding an
installation prefix check and asm-blackfin/calibration.h are present. And it
modifies the link order for the test programs. I noticed that last "trick" only
just now; I'll try(*) tomorrow whether linking to (e.g) libnative.la changes
anything over linking with -lnative. Specifying an extra -static anyway didn't
help.  The uclinux-dist build puts the build Xenomai libraries into
uClinux-dist/staging/usr/lib, and that's where my app links to.

*) Because there's one more (strange, to me) observation: If I do not try
"next" over the rt_task_shadow (which is the first line in main()), but "step",
it seems to go directly into "__map_heap_memory" with heap=0 and php=argv[0]
(i.e. the arguments to main()). So it seems it's not in main() but in in
__map_heap_memory?!  In another case, I was able to make the code run further
until a rt_task_create. A breakpoint there and one step, and all of the sudden
gdb says I'm was actually in "rt_heap_create" but with the arguments that were
passed to rt_task_create. It happens that both take similar type and count of
arguments. This may be gdb displaying wrong info or a badly linked FDPIC elf?!

BTW, the toolchain is ADI's 2009R1-RC10 (binary download),
bfin-linux-uclibc-gcc reports version 4.1.2.

Kolja

-- 
Mr. K.Waschk - http://www.ixo.de - http://urjtag.org - Hamburg, DE


