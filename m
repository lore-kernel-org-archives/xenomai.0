From: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Date: Mon, 22 Jun 2009 15:15:49 +0200
Message-ID: <D39BC4B7B612C6428144D37C54379A2F01A24CC99631@domain.hid>
References: <634c78ce0906120240t694ded8cpfa7fcd9dfb2c3b8@domain.hid>
	<200906121148.37732.smolorz@domain.hid>
	<4A3235BF.5090201@domain.hid> <4A324D3D.9060505@domain.hid>
	<4A325189.5060905@domain.hid> <4A3253DB.5040109@domain.hid>
	<4A32674C.7060007@domain.hid>
In-Reply-To: <4A32674C.7060007@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Running Xenomai in a virtual machine
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Visser <johan.visser@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Just going through this interesting thread, I though it might be of interes=
t - probably not fully related to the topic, but... - to know
that we are currently working on some integration efforts of Xenomai on top=
 of the XEN hypervisor in the context of the
embeddedXEN project. For the time being, it is purely devoted to ARM-based =
processors.

In case of interest, please visit: https://sourceforge.net/projects/embedde=
dxen. Xenomai will appear as a natural subtree of embeddedXEN, like xen or =
minios,
but currently it is not present yet. The hypervisor and miniOS boots up in =
Mainstone/QEMU and soon on a Colibri/PXA270 board. EmbeddedXEN is mainly de=
voted to integrate multiple kernels into a single binary image for embedded=
 systems with the support of hard realtime (domainU-RT, a new kind of Xen d=
omain).

If you're interested to contribute, simply tell us through the mailing list=
 (embeddedxen-devel@domain.hid)

Daniel

> -----Original Message-----
> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-
> bounces@domain.hid] On Behalf Of Johan Visser
> Sent: vendredi, 12. juin 2009 16:34
> To: Jan Kiszka
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Running Xenomai in a virtual machine
>=20
> Jan Kiszka schreef:
> > Jan Kiszka wrote:
> >
> >> ... You could still use qemu in
> >> emulation mode, but that is 10..40 times slower than native (but
> still
> >> better than nothing if you have to debug the guest kernel - I've
> done
> >> this before kvm arrived).
> >>
> >
> > BTW, another advantage of qemu is that you could write a model of
> your
> > possibly non-standard I/O hardware and even run your drivers in qemu
> > against this model. That works both with and without kvm support.
> >
> The IO is driven by ethernet :-)        so if it were real time....
> We are now simulating real time ( on a live system ) on  a functional
> basis,
> My guest system programs the int0 to go at 1000 Hz, that is why I
> wonder
> if the used host system config matters.
>=20
> > And as we are at it: qemu (in emulation mode) is also capable of
> > providing a host for ARM, PPC, MIPS, etc. targets. An example: I'm
> able
> > to run the unmodified Linux firmware of my ARM-based webradio inside
> > qemu, and it works as in real life (it just boots faster in qemu than
> on
> > real silicon ;)).
> >
> by real-life system nowadays is an ATOM based cpu board...
> > Jan
> >
> >
>=20
> --
> Ing. Johan Visser
> Stork Plastics Machinery B.V.
> Tel. : +31 742405113
> Mob. : +31 653731518
>=20
> ----------------------------------------------------
> Stork Plastics Machinery B.V. Alfred Marshallstraat 2, 7559 SE Hengelo,
> the Netherlands.
> Supplies and executions to the conditions and stipulations filed with
> the Chamber of Commerce (Trade register Enschede nr. 06041991) except
> as otherwise provided in writing.
> DISCLAIMER:
> The information contained in this communication is confidential and may
> be legally privileged. It is intended solely for the use of the
> individual or entity to whom it is addressed and others authorized to
> receive it. If you are not the intended recipient, you are hereby
> notified that any disclosure, copying, distribution, or taking any
> action in reliance of the contents of this information is strictly
> prohibited and may be unlawful. Stork Plastics Machinery is neither
> liable for the proper and complete transmission of the information
> contained in this communication nor for any delay in its receipt.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

