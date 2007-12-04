Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 4 Dec 2007 06:57:36 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D375F43@domain.hid>
In-Reply-To: <18260.29573.817255.968962@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int><2ff1a98a0711270657y63482de1ref80ba849f172918@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375D71@domain.hid><18259.5205.292521.503167@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int><2ff1a98a0712030235vfc316b8nff4b1e422db82c96@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375EEC@slcmail.slc.mew.int><2ff1a98a0712030552y1c9b10b8p54730d45f6245906@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375EEE@slcmail.slc.mew.int><18260.25837.479943.881970@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375F08@domain.hid>
	<18260.29573.817255.968962@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] wathcdog
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

It seems that I am missing something. I see that you limit the signal to
be sent to a thread with a matching mm, however doesn't this send a
signal that can only be captured by a kernel space thread with
rt_task_catch()? If so, that wouldn't be part of the application. I
don't really know what "mm" means, but if it's a virtual address space,
then usually that's shared among all modules.=20

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Monday, December 03, 2007 2:22 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: RE: [Xenomai-help] wathcdog
>=20
> Steven Seeger wrote:
>  > > Ok. We can send the signal only to threads which are part of the
same
>  > > application as the faulting thread.
>  >
>  > That would be a big help! At least then we can report which
application
>  > had the fault. We have a few applications that work together.
>=20
> Here it comes.


