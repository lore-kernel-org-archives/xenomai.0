Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jan 2009 14:20:20 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D534095@domain.hid>
In-Reply-To: <49779002.5080704@domain.hid>
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

After I see init_fpu() called, this is what I see:

s4r6s4r6s4r6s4r7s4r7s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6
s4r6s4r6

"s4" is printed in xnarch_save_fpu() right after
if(!wrap_test_fpu_used(task)) where it is false and causes the save
function to quit

"r6" is printed in xnarch_restore_fpu() right after if(tcb->cr0_ts)
evaluates to 1

"r7" is printed in xnarch_restore_fpu() right after if(tcb->cr0_ts)
evalutes to 0

These calls are made from __xnpod_switch_fpu()

There are no calls to xnarch_enable_fpu()

It seems to me that we are missing an fpu init, and it seems that
xnarch_save_fpu() never actually saves because fpu used is never set.

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Wednesday, January 21, 2009 2:14 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] fpu issue
>=20
> Steven Seeger wrote:
> > I spoke too soon. I managed to make it fail by removing the break in
> > func() in my test, so that it does its comparison over and over
again.
> >
> > The failure case starts off like the normal case where
> xnarch_save_fpu
> > always exists early due to wrap_test_fpu_used always returning
false.
> > However, when it fails, as I pointed out earlier it seems that the
> > cr0_ts is not set so stts() is not called in restore. I never see
> this
> > case when things work properly. When it fails, I see two restores in
> a
> > row where the task switch bit is not set in the FPU.
> >
> > Where would I want to look into this?
>=20
> Please send me traces, so that I can understand what goes wrong.
>=20
> --
> 					    Gilles.

