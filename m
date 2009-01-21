Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jan 2009 09:43:57 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D534056@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<49757B25.8020500@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
	<4975E491.1040506@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB6@domain.hid>
	<4975E612.9040708@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534028@domain.hid>
	<4976EABD.3060505@domain.hid> 
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Oh, and I never see __xnpod_fault_init_fpu() called either. It looks
like Linux is trapping this and initializing the FPU in i387.c

> -----Original Message-----
> From: Steven Seeger
> Sent: Wednesday, January 21, 2009 9:42 AM
> To: 'Gilles Chanteperdrix'
> Cc: xenomai@xenomai.org
> Subject: RE: [Xenomai-help] fpu issue
>=20
> In pod.c:
>=20
> __xnpod_init_fpu() is not called ever. However, init_fpu is called
once
> in i387.c
>=20
> After the program runs, __xnpod_giveup_fpu is called twice (remember,
I
> have two threads)
>=20
> __xnpod_release_fpu() never called
>=20
> I can't put a printk in __xnpod_switch_fpu() because it freezes
> (continues to print forever)
>=20
> Steven


