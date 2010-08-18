From: Paul <paul_c@domain.hid>
Date: Wed, 18 Aug 2010 22:08:06 +0100
References: <4C45539B.70204@domain.hid> <4C6AA99D.3010907@domain.hid>
	<4C6C2A4D.70503@domain.hid>
In-Reply-To: <4C6C2A4D.70503@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201008182208.06802.paul_c@domain.hid>
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
	boot on ubuntu lucid system [PATCH]
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

On Wednesday 18 August 2010, Stefan Kisdaroczi wrote:
> On 17.08.2010 17:24, Stefan Kisdaroczi wrote:
> > On 17.08.2010 15:51, Hemal C.Bavishi wrote:
> >> When I tried to compile it with the latest version of kernel with
> >> xenomai 2.5.4, I am getting following errors in Xenomai (disable
> >> CONFIG_SMP, enable CONFIG_X86_UP_APIC and CONFIG_X86_UP_IOAPIC
> >> (*).)
> >
> > Just tested, got the same build error with 2.6.34.
> > If I patch 2.6.34 with prepare-kernel [1] it compiles,
> > if I use the debian packaged patch generated with prepare-patch [2]
> > it fails.
> >
> > I guess a fix is needed in prepare-patch for 2.6.34, but no time to
> > look closer now.
>
> patch for prepare-patch.sh attached.
> prepare-kernel.sh try's to find ipipe.h and uses the old or new tree
> structure. Is it ok to change this unconditionally in
> prepare-patch.sh? All adeos-patches in xenomai-2.5.git have ipipe.h
> in
> arch/$linux_arch/include/asm/, so i think yes.

As long as no one tries to include a patch for anything prior to 2.6.28 
(I think that is when everything moved to arch/*/include/asm) - There 
is only one ipipe patch in head currently for 2.6.25-ppc, but I doubt 
if anyone would be using it on a Debian build.

For that one case, I don't think it worth adding any additional 
complexity to generate a patch with a limited life span.


Regards, Paul.



