Date: Wed, 30 May 2012 13:23:41 +0200 (CEST)
From: aubin.rebillat@free.fr
Message-ID: <783140695.199540661.1338377021968.JavaMail.root@spooler3-g27.priv.proxad.net>
In-Reply-To: <4FC5F13C.7030201@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Feature synchronisation with FASTSYNCH on TS-7553
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> > Hello,
> > 
> > I made a Xenomai 2.6 port on the TS-7553 SBC based on the
> > cns2132/str8132
> > SoC (armv4 CPU) with a kernel 2.6.24. I wanted to test the port
> > using the
> > Xenomai tests binaries (switchtest, clocktest, latency,...) but I'm
> > having
> > configuration issues in the feature synchronisation between
> > user-space
> > and kernel-space:
> > $ /usr/xenomai/bin/switchtest
> > Xenomai : incompatible feature set
> > (userland requires "fastsynch nosmp", kernel provides "sa1100 eabi
> > tsc
> > nofastsynch", missing="fastsynch").
> 
> By the way, if you want user-space tsc emulation, you should add
> support
> for your processor to configure.in, so that you can enable tsc in
> user-space with --enable-arm-tsc=str8132.
> 

I applied the fixes and I have now all the features synced.

Than you very much for your help,

-- 
REBILLAT Aubin

