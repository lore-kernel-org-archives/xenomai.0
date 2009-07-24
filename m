From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.2.00.0907241917480.4343@domain.hid>
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid>
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
Content-Type: text/plain
Date: Fri, 24 Jul 2009 20:50:58 +0200
Message-Id: <1248461458.3998.183.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] POSIX skin/Blackfin: SIGSEGV when stracing or
 gdb'ing
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

On Fri, 2009-07-24 at 19:33 +0200, Waschk,Kolja wrote:
> Hi,
> 
> > blackfin toolchain: ce79f3d5449c78877e66965584c55a132d73d4e1
> > uclinux-dist: 2137ff7920b51643c5c84536fe99fe7c5904498a
> > blackfin kernel: 015153eee3851d2c485a85814888f031f3794cf4
> 
> while I was able to locate that toolchain commit at blackfin.uclinux.org (Jun
> 14?), I do not seem to know the correct sources for dist and kernel... I
> mereley downloaded an uclinux-dist SVN snapshot (rev 8572) and a precompiled
> toolchain, probably rev 3515 (20090721) from their Files section, and also just
> used the kernel, kernel patch and Xenomai as they came with that snapshot.

This is what I used to do, until non backward compatible changes were
introduced circa 2.6.29-2.6.30 in the bootloader and kernel support
which ended up requiring a more recent toolchain and uclinux-dist tree. 

> Where should I be able to locate those commit numbers? Sorry for asking... the
> information about which repository is currently tracked by whom and where is a
> little complicated to trace, at least for a newbie in regarding bfin+xenomai.

You will find the kernel commit mentioned in that tree:
git://git.kernel.org/pub/scm/linux/kernel/git/vapier/blackfin.git

This tree is maintained by Mike Frysinger; this is the source of what is
submitted upstream for inclusion blackfin-wise.

I pull the uclinux-dist code from a git tree mirroring the project's SVN
repo, the related commit number applies there:
git://sources.blackfin.uclinux.org/git/readonly-mirrors/uclinux-dist.git

> 
> Kolja
> 
-- 
Philippe.



