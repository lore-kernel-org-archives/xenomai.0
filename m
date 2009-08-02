From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.2.00.0907292209410.5958@domain.hid>
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
	<alpine.DEB.2.00.0907292209410.5958@domain.hid>
Content-Type: text/plain
Date: Sun, 02 Aug 2009 19:53:36 +0200
Message-Id: <1249235616.4010.24.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stack sizes etc. (Re: POSIX skin/Blackfin:
 SIGSEGV when stracing or gdb'ing)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2009-07-29 at 22:55 +0200, Waschk,Kolja wrote:
> Hi,
> 
> > This may be an I-pipe issue. As I understand, you are currently running
> > 2009R1-RC2 unmodified, could you summarize where the various Xenomai
> > related components come from so I could try looking at the issue?
> 
> I'll try: I haven't put in any extra sources, and it seems that
> user/xenomai/Makefile indeed refers to ADEOS =
> $(ROOTDIR)/bfin_patch/adeos_patch/adeos-bfin.patch
> 
> The latest SVN log entry says "update to
> http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-2.6.28.10-blackfin.git-1.10-00.patch"
> however adeos-bfin.patch in there is not exactly that file.
> 
> Also, I use and didn't touch anything inside the dist's
> user/xenomai/xenomai-2.4.7 directory which seems to contain
> the almost unmodified 2.4.7 sources. Only minor changes regarding an
> installation prefix check and asm-blackfin/calibration.h are present. And it
> modifies the link order for the test programs. I noticed that last "trick" only
> just now; I'll try(*) tomorrow whether linking to (e.g) libnative.la changes
> anything over linking with -lnative. Specifying an extra -static anyway didn't
> help.  The uclinux-dist build puts the build Xenomai libraries into
> uClinux-dist/staging/usr/lib, and that's where my app links to.
> 
> *) Because there's one more (strange, to me) observation: If I do not try
> "next" over the rt_task_shadow (which is the first line in main()), but "step",
> it seems to go directly into "__map_heap_memory" with heap=0 and php=argv[0]
> (i.e. the arguments to main()). So it seems it's not in main() but in in
> __map_heap_memory?!  In another case, I was able to make the code run further
> until a rt_task_create. A breakpoint there and one step, and all of the sudden
> gdb says I'm was actually in "rt_heap_create" but with the arguments that were
> passed to rt_task_create. It happens that both take similar type and count of
> arguments. This may be gdb displaying wrong info or a badly linked FDPIC elf?!
> 

You seem to be using flat binaries, not ELF, at least if you did not
change anything to the stock Blackfin Makefiles for 2009R1-RC2.

> BTW, the toolchain is ADI's 2009R1-RC10 (binary download),
> bfin-linux-uclibc-gcc reports version 4.1.2.

I have just rebuilt your exact setup, i.e. everything from a stock
2009R1-RC2 which includes Xenomai 2.4.7, with the 09r1-rc10 toolchain.
So far, everything looks fine when running the testsuite.

It seems that you made some changes to the kernel configuration compared
to the default one, since you did activate the Xenomai debug option
which is off by default (this is the one that triggers the
xnshadow_relax() assertion). I would suggest to try the following, in
sequence:

- rebuild your full uclinux-dist stuff based on default settings, still
using the Xenomai code that ships with it; I would not try to tweak
anything before getting a working default system though.

- override the shipped Xenomai release with a stock one:
http://download.gna.org/xenomai/stable/xenomai-2.4.7.tar.bz2
You will have to rebuild the kernel and Xenomai libs/programs aside of
the standard uclinux-dist process, the following should do the trick
(untested though):

$ cd $uclinux-dist-root/linux-2.6.x
$ ~/xenomai-stock/scripts/prepare-kernel.sh --arch=blackfin --linux=.
--forcelink

$ cd /tmp/somewhere
$ ~/xenomai-stock/configure --build=i686-pc-linux-gnu
--host=blackfin-unknown-linux-gnu CC=bfin-linux-uclibc-gcc
CXX=bfin-linux-uclibc-gcc AR=bfin-linux-uclibc-ar
LD=bfin-linux-uclibc-ld --prefix=/usr
$ make DESTDIR=$uclinux-dist-root/staging install
$ cd $uclinux-dist-root && make linux image
$ cp images/uImage /tftpboot/somewhere/

The Xenomai libs/programs will be produced in ELF format, not flat. I
understand this may be an issue for some users, but this is how the
Xenomai project tests them anyway. In any case, you may want to check
whether building for ELF without converting to FLT makes a difference
with your GDB issue.

PS: looking at the toolchain code (09r1-rc10), the mcount bug is still
there in the gcc config frag for blackfin, so don't even bother trying
ftrace or the I-pipe tracer; they would break your kernel during early
boot up.

> 
> Kolja
> 
-- 
Philippe.



