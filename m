Message-ID: <2ff1a98a0710010610l7c32f6d8j5264ae8b133166e6@domain.hid>
Date: Mon, 1 Oct 2007 15:10:47 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710011255.l91CtkvR000470@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0710010525kc7b368ex735a34ee76fcd93f@domain.hid>
	<200710011255.l91CtkvR000470@domain.hid>
Subject: Re: [Xenomai-core] ARM compiling error
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 10/1/07, Patrick <kpa_info@domain.hid> wrote:
> > On 10/1/07, Patrick <kpa_info@domain.hid> wrote:
> > >
> > > I install Xenomai 2.3.4 for ARM on 2.6.20 kernel. The prepare-kernel
> > > script
> > > work well.
> >
> > Which ARM machine ?
> > Which version of the ARM patch ?
> > From your compilation log, I would say that you are using an I-pipe
> > patch which is older than Xenomai v2.3.4, so the general advice is to
> > use the I-pipe patch which comes with the version of Xenomai you use.
>
> I use an ARM PXA270 and adeos-ipipe-2.6.20-arm-1.7-05.
>
> I use the latest stable version of Xenomai (2.3.4) and the latest version of
> ipipe for ARM (1.7).

The I-pipe patch which comes with Xenomai (2.3.4) is
adeos-ipipe-2.6.20-arm-1.7-06, you will find it in the
ksrc/arch/arm/patches subdirectory of Xenomai sources. If you call
prepare-kernel without any argument it will pick the right patch.

Please do send your replies to the mailing list.

-- 
                                               Gilles Chanteperdrix

