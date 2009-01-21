Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jan 2009 14:27:45 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D534096@domain.hid>
In-Reply-To: <49779319.5040500@domain.hid>
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
	<51CAD0CE1504444DBE77CBBE51A0135D534064@domain.hid>
	<49776313.2090403@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53407D@slcmail.slc.mew.int>
	<49777C1F.4040805@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53408C@slcmail.slc.mew.int>
	<49779002.5080704@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534095@domain.hid>
	<49779319.5040500@domain.hid>
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

Yes I can. Let me also point out that with my trace, the if below "r7"
in if(tcb->usedfpu) never enters.

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Wednesday, January 21, 2009 2:27 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] fpu issue
>=20
> Steven Seeger wrote:
> > After I see init_fpu() called, this is what I see:
> >
> >
>
s4r6s4r6s4r6s4r7s4r7s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r
> 6
> > s4r6s4r6
> >
> > "s4" is printed in xnarch_save_fpu() right after
> > if(!wrap_test_fpu_used(task)) where it is false and causes the save
> > function to quit
> >
> > "r6" is printed in xnarch_restore_fpu() right after if(tcb->cr0_ts)
> > evaluates to 1
> >
> > "r7" is printed in xnarch_restore_fpu() right after if(tcb->cr0_ts)
> > evalutes to 0
> >
> > These calls are made from __xnpod_switch_fpu()
> >
> > There are no calls to xnarch_enable_fpu()
> >
> > It seems to me that we are missing an fpu init, and it seems that
> > xnarch_save_fpu() never actually saves because fpu used is never
set.
>=20
> Ok. Please let me some time to try and understand. In the meantime,
> could you put a printk in the kernel_fpu_begin function to see if it
is
> ever called?
>=20
> --
> 					    Gilles.

