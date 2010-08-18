From: Paul <paul_c@domain.hid>
Date: Wed, 18 Aug 2010 10:03:09 +0100
References: <4C45539B.70204@domain.hid> <4C6AA99D.3010907@domain.hid>
	<4C6B870C.7090600@domain.hid>
In-Reply-To: <4C6B870C.7090600@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201008181003.09206.paul_c@domain.hid>
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
	boot on ubuntu lucid system
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

On Wednesday 18 August 2010, Gilles Chanteperdrix wrote:
> Stefan Kisdaroczi wrote:
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
> >
> > Stefan
> >
> > [1] xenomai-2.5.4/scripts/prepare-kernel.sh
> > [2] xenomai-2.5.4/debian/prepare-patch.sh
>
> prepare-kernel.sh has a "--outpatch" option, which seems to be able
> to generate patches, so, would not it be possible to modify
> prepare-patch to simply call prepare-kernel.sh with the --outpatch
> option?
>
> This way, we will not have to duplicate into prepare-patch.sh the
> modifications we make to prepare-kernel.sh.

The debian/prepare-patch.sh does not require a kernel source tree and 
generates patches for multiple kernels & arches - It is a fudge, but it 
works for the most part and does not impose dependencies of multiple 
kernel source trees on package build systems.


Regards, Paul.


Regards, Paul.




