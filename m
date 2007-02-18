Subject: Re: [Xenomai-core] buildbot: how to setup for ppc with 2.6.19 kernel?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45D868C5.3000307@domain.hid>
References: <200702181351.53069.niklaus.giger@domain.hid>
	<45D868C5.3000307@domain.hid>
Content-Type: text/plain
Date: Sun, 18 Feb 2007 16:15:16 +0100
Message-Id: <1171811716.13484.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2007-02-18 at 15:55 +0100, Wolfgang Grandegger wrote:
> Niklaus Giger wrote:
> > Hi
> > 
> > Compiling ppc fails for me with 2.6.19 kernels. 
> > ( I compile on a Pegasos PPC 601 Debian Linux).
> > 
> > If I use ARCH=ppc then I get the following error:
> >>   CHK     include/linux/version.h
> >>   CHK     include/linux/utsrelease.h
> >>   CHK     include/linux/compile.h
> >> gcc: include/asm/byteorder.h: No such file or directory
> 
> Hmm, strange.
> 
> >> gcc: no input files
> >>   CC      arch/ppc/xenomai/hal.o
> >> arch/ppc/xenomai/hal.c: In function 'rthal_arch_init':
> >> arch/ppc/xenomai/hal.c:353: error: invalid type argument of '->'
> >> make[1]: *** [arch/ppc/xenomai/hal.o] Fehler 1
> 
> That looks like an altivec problem. Does the attached patch for Xenomai 
> help?
> 

It does, but we also need to remain compatible with older kernels
(namely 2.6.14 since the ppc64 port is still based on it), so I fixed
this by using cpu_has_feature() instead.

-- 
Philippe.



