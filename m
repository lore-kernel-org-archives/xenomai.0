Date: Thu, 25 Jun 2015 16:06:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150625140641.GI26099@hermes.click-hack.org>
References: <2634889.oyRnRNCYxl@soho> <3101296.KSktGWlV1q@soho>
 <20150625125414.GE26099@hermes.click-hack.org>
 <5297525.euQ38TDxur@soho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5297525.euQ38TDxur@soho>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian package of Xenomai 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Thu, Jun 25, 2015 at 03:56:49PM +0200, Leopold Palomo-Avellaneda wrote:
> El Dijous, 25 de juny de 2015, a les 14:54:14, Gilles Chanteperdrix va 
> escriure:
> > > > > 
> > > > > - Drop /dev from libxenomai1.
> > > > > The /dev directory is created by udev. All debian systems have udev.
> > > > > However, I'm thinking to have another package with this stuff. What do
> > > > > you think?
> > > 
> > > You didn't answer this ..
> Gilles,
> 
> I have dropped /dev from libxenomai. Could be problematic?

How should I know, I never did that. I would think not since the
udev rules should create the nodes, but you have to check.

> 
> [...]
> 
> 
> > > 
> > > > > W: xenomai-system-tools: hardening-no-relro usr/bin/cmd_bits
> > > > > N:
> > > > > N:    This package provides an ELF binary that lacks the "read-only
> > > > > N:    relocation" link flag. This package was likely not built with
> > > > > the
> > > > > N:    default Debian compiler flags defined by dpkg-buildflags. If
> > > > > built
> > > > > using N:    dpkg-buildflags directly, be sure to import LDFLAGS.
> > > > > N:
> > > > > N:    Refer to https://wiki.debian.org/Hardening for details.
> > > > > N:
> > > > > N:    Severity: normal, Certainty: certain
> > > > > N:
> > > > > N:    Check: binaries, Type: binary, udeb
> > > > > N:
> > > > > W: xenomai-system-tools: hardening-no-relro usr/bin/cmd_read
> > > > > W: xenomai-system-tools: hardening-no-relro usr/bin/cmd_write
> > > > > W: xenomai-system-tools: hardening-no-relro usr/bin/insn_bits
> > > > > W: xenomai-system-tools: hardening-no-relro usr/bin/insn_read
> > > > > W: xenomai-system-tools: hardening-no-relro usr/bin/insn_write
> > > > > W: xenomai-system-tools: hardening-no-relro usr/bin/rtcanrecv
> > > > > W: xenomai-system-tools: hardening-no-relro usr/bin/rtcansend
> > > > > W: xenomai-system-tools: hardening-no-relro usr/bin/wf_generate
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/native+posix/mq_select
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/native/heap
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/native/leaks
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/native/sigdebug
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/native/tsc
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/posix/leaks
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/posix/mprotect
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/posix/nano_test
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/posix/shm
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/posix/test_pip_exit
> > > > > W: xenomai-system-tools: hardening-no-relro usr/lib/x86_64-linux-
> > > > > gnu/xenomai/regression/posix/xddp_test
> > > > > W: xenomai-system-tools: hardening-no-relro usr/sbin/analogy_config
> > > > > W: xenomai-system-tools: hardening-no-relro usr/sbin/rtcanconfig
> > > > 
> > > > Please provide the patch to the debian/rules to apply this change. I
> > > > do not think we did anything special to avoid using the default flags.
> > > 
> > > my configure line says:
> > > 
> > > CONFIG_OPTS += --prefix=/usr \
> > > 
> > >                     --includedir=/usr/include/xenomai \
> > >                     --mandir=/usr/share/man \
> > >                     --with-testdir=/usr/lib/$(DEB_HOST_MULTIARCH)/xenomai
> > >                     \
> > >                     --enable-fortify \
> > >                     --libdir='$${prefix}/lib/$(DEB_HOST_MULTIARCH)/'
> > > 
> > > plus some specific arch params.
> > 
> > What specific arch params? Last time I checked in the in-tree
> > debian/rules, these arch params were obsolete, so, I removed them
> > all.
> 
> ifeq ($(DEB_HOST_ARCH), i386)
>         CONFIG_OPTS = \
>                     --enable-x86-tsc
> endif
> ifeq ($(DEB_HOST_ARCH), amd64)
>         CONFIG_OPTS = \
>                     --enable-x86-tsc \
>                     --enable-x86-sep  
> endif
> ifeq ($(DEB_HOST_ARCH), powerpc)
>         CONFIG_OPTS =
> endif
> ifeq ($(DEB_HOST_ARCH), armeb)
>         CONFIG_OPTS = --enable-arm-mach=generic --enable-arm-eabi
> endif
> ifeq ($(DEB_HOST_ARCH), armel)
>         CONFIG_OPTS = --enable-arm-mach=generic --enable-arm-eabi
> endif
> ifeq ($(DEB_HOST_ARCH), arm)
>         CONFIG_OPTS = --enable-arm-mach=generic
> endif

ARM options are obsolete (and cause configure to emit a warning
BTW), x86 are not, but are useless since these options have been the
default for a long time.

> 
> 
> > > I have tested it with --enable-fortify and
> > > without.
> > 
> > --enable-fortify, as documented, allows applications built for the
> > POSIX skin with the fortify define (_FORTIFY_SOURCE), to correctly
> > link with Xenomai libraries (IOW, it provides implementation of
> > __wrap_printf_chk and the like). It has no influence on building
> > Xenomai with that flag.
> > 
> > > I have also:
> > > DEB_BUILD_MAINT_OPTIONS=hardening=+all,-pie
> > > 
> > > following
> > > 
> > > https://wiki.debian.org/Hardening
> > > 
> > > any help in this stuff will help.
> > 
> > The in-tree debian/rules exports the variable DEB_BUILD_HARDENING=1
> > to build the package with hardening. At the time I read the wiki,
> > this was one recommended way, supposing that the wiki was up to date
> > when I read it. I am afraid I can you help more on this, this looks
> > like a debian specific problem.
> 
> Ok,
> 
> the other people have the same issue?

What debian defines as "hardening" is debian-specific, so, I do not
know whether all of these options work. Someone has to check, and
you are the best person for the job.

-- 
					    Gilles.
https://click-hack.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150625/b8548b52/attachment.sig>
