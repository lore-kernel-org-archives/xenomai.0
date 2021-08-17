MIME-Version: 1.0
References: <3ea6dbbecbdf44ceab12d6ffed5d0eba@debo1svwi003091.corp.mooginc.com>
 <38113fb102834811a76f4dfb99d94ac2@debo1svwi003091.corp.mooginc.com>
In-Reply-To: <38113fb102834811a76f4dfb99d94ac2@debo1svwi003091.corp.mooginc.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Date: Tue, 17 Aug 2021 22:01:03 +0200
Message-ID: <CAPRPZsBneN19U93PVT=WqWyUqwS9MJd+Yk4KBQJpi5Lh4hMBvw@mail.gmail.com>
Subject: Re: Question regarding RTnet Ethernet Driver with PCIe MSI interrupts
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reed, Scott" <sreed@moog.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

FWIW, in the past I have worked with e1000 NICs in RTnet that registered
their MSI interrupt with the kernel.

I do not recall that I had to do anything out of the ordinary.


Op di 17 aug. 2021 om 15:37 schreef Reed, Scott via Xenomai <
xenomai@xenomai.org>:

>
>
> Scott Reed
> Senior Software Engineer
> direct +497031622263
>
> Moog Industrial Group
> Moog GmbH
> Hanns-Klemm-Strasse 28
> 71034 B=C3=B6blingen
> Deutschland
> www.moog.com/industrial
>
>
> _________________________________________________________________________=
______
>
>
>
> Moog GmbH, Hanns-Klemm-Strasse 28, 71034 B=C3=B6blingen, Deutschland,
> Handelsregister: Amtsgericht Stuttgart HRB 240301,
> Gesch=C3=A4ftsf=C3=BChrer: Thomas Czeppel, Johannes (Pim) van den Dijssel
>
>
>
> > -----Original Message-----
> > From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Reed, Scott
> > via Xenomai
> > Sent: Thursday, August 5, 2021 19:09
> > To: xenomai@xenomai.org
> > Subject: [EXTERNAL] Question regarding RTnet Ethernet Driver with PCIe
> MSI
> > interrupts
> >
> > Hello,
> >
> > About a year ago, I ported an Ethernet driver we use to be an RTnet
> > driver. In general everything is working, but we have run into a
> > recent problem which looks like it might be being caused by high
> > Ethernet receive interrupt latencies.
> >
> > The Ethernet interrupts come in as PCIe MSI interrupts and I
> > implemented the potentially creative but bad solution of
> > modifying the PCIe driver to distribute the MSI interrupts
> > to i-ipipe be replacing the call to "generic_handle_irq" with
> > a call to "ipipe_handle_demuxed_irq".
> >
> > I am thinking that this was maybe not the best approach and the
> > correct solution would be to modify the PCIe driver so that the
> > original MSI interrupt is an RTDM interrupt as if it is not
> > this could be causing the high interrupt latencies.
> >
> > Is my thinking in the right direction or completely off?
>
> I did not receive any feedback from the forum (maybe I made
> a mistake in my post as it was my first post), but in case someone
> else runs across this thread and has a similar issue...
>
> I modified the PCIe driver so that the MSI interrupt is an
> RTDM interrupt (i.e. registered interrupt with rtdm_irq_request()
> as opposed to with devm_request_irq()) and this solved my problem
> of seeing latencies (i.e. delays) in the handling of the Ethernet receive
> interrupts (which are packaged in the PCIe MSI interrupt).
>
> Since my Ethernet receive interrupts (and transmit interrupts) are also
> registered as RTDM Interrupts, I needed to keep my original PCIe driver
> modification that MSI interrupts are distributed in dw_handle_msi_irq()
> using "ipipe_handle_demuxed_irq" instead of "generic_handle_irq".
>
> I assume it would probably also work to register the Ethernet interrupts
> as "normal Linux" interrupts and then the this modification would not
> be necessary, but I did not verify this and prefer to have the Ethernet
> interrupts as RTDM interrupts so the driver is correct whether or not
> it is "behind" an PCIe MSI interrupt or not.
>
> If anyone would like more details, I can gladly provide them.
>
> Regards,
>
> Scott
>
> >
> > Background information
> > --------------------------------
> > Processor: iMx6 Quad
> > Linux 4.14.62
> > Xenomai 3.0.7
> >
> > Thanks in advance for any advice.
> >
> > Regards,
> >
> > Scott
>
> Hinweis auf Vertraulichkeit: Diese elektronisch =C3=BCbermittelte Nachric=
ht ist
> nur f=C3=BCr die nat=C3=BCrliche oder juristische Person bestimmt, die al=
s Empf=C3=A4nger
> genannt ist; sie kann vertrauliche Informationen oder Betriebsgeheimnisse
> enthalten, die Eigentum des Absenders sind. F=C3=BCr den Fall, dass Sie n=
icht
> der genannte Empf=C3=A4nger sind, ist Ihnen jede Offenlegung, Verwendung,
> Vervielf=C3=A4ltigung oder Weiterleitung des Inhalts dieser Informationen=
 streng
> untersagt. Dasselbe gilt f=C3=BCr alle Handlungen, die sich auf den Inhal=
t
> dieser Informationen gr=C3=BCnden. Falls Sie diese Nachricht irrt=C3=BCml=
icherweise
> erhalten haben, bitten wir Sie, den Absender umgehend per E-Mail dar=C3=
=BCber in
> Kenntnis zu setzen und die urspr=C3=BCngliche Nachricht zu l=C3=B6schen. =
Wir danken
> Ihnen f=C3=BCr Ihre Kooperation.
>
> Confidentiality Notice: This electronic mail transmission is intended for
> the use of the individual or entity to which it is addressed and may
> contain confidential and/or proprietary information belonging to the
> sender. If you are not the intended recipient, you are hereby notified th=
at
> any disclosure, use, copying, distribution, or the taking of any action i=
n
> reliance on the contents of this information is strictly prohibited. If y=
ou
> have received this transmission in error, please notify the sender
> immediately by e-mail and delete the original message. Thank you for your
> cooperation.
>
