Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jan 2009 10:16:27 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D534061@domain.hid>
In-Reply-To: <49775759.2090505@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<49757B25.8020500@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
	<4975E491.1040506@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB6@domain.hid>
	<4975E612.9040708@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534028@domain.hid>
	<4976EABD.3060505@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534053@domain.hid>
	<497751E3.3020301@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53405D@slcmail.slc.mew.int>
	<49775759.2090505@domain.hid>
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

Well, is what I said correct that a new userspace thread created with
rt_task_spawn() should start in primary mode instead of secondary mode?

Also, there is no need to stop my test when it detects an issue because
all it does now is print something out and then quit. The issue is there
if the printout shows me the memory holding the double is corrupt. So
that makes it easier that I've further redcuded the complexity.

I will have you results in a few minutes. Thank you for helping me with
your suggestions.

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Wednesday, January 21, 2009 10:12 AM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] fpu issue
>=20
> Steven Seeger wrote:
> >> __xnpod_init_fpu is for kernel-space thread. For user-space
threads,
> >> the
> >> FPU initialization happens either in Linux code if the fault
happens
> > in
> >> secondary mode, or in the fault handler if it happens in primary
> mode.
> >
> > Interesting. Shouldn't rt_task_spawn() start up in primary mode even
> if
> > it's called in user space? Is it normal to start in secondary mode?
I
> > know std::cout will migrate to secondary, but I do my fpu stuff
> before
> > that.
>=20
> When you first use fpu in primary mode, a fault happen, is trapped in
> ksrc/nucleus/pod.c and directly calls xnarch_init_fpu, not
> __xnpod_init_fpu. Now, the fact that xnarch_init_fpu is not called may
> indeed be your problem, but we have to know exactly what happens
before
> to understand why this happens.
>=20
> --
>                                                  Gilles.

