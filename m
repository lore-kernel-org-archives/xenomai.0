Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 2 Dec 2007 16:55:38 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int>
In-Reply-To: <18259.5205.292521.503167@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int><2ff1a98a0711270657y63482de1ref80ba849f172918@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D375D71@domain.hid>
	<18259.5205.292521.503167@domain.hid>
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

Hi Gilles. I wonder if it might be possible for a userspace program to
register its own handler with the watchdog for a thread? If so, then it
would be beneficial to have this handler also pass an argument that was
included with the register so that the user program's handler can
identify the thread and handle things appropriately. This method handles
the notification problem, but doesn't handle the problem of knowing
which thread it was that was killed. As a result, it will be impossible
to recover from this error or simply log the offending thread and shut
down gracefully.

What do you think?

Thanks,
Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Sunday, December 02, 2007 1:24 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: RE: [Xenomai-help] wathcdog
>=20
> Steven Seeger wrote:
>  > > What is wrong with Xenomai watchdog and Linux soft lockup
detector ?
>  >
>  > The problem is that there doesn't seem to be a way for my
application
> to
>  > be notified that one of its thread was killed by the watchdog
handler.
>  > If there is a way for me to know this, then it would work fine.
Please
>  > let me know if there is a way for me to know.
>=20
> Hi,
>=20
> here is, for review, testing, and commenting, an attempt of
implementing
> a mechanism for notifying user-space threads when the watchdog kills a
> thread.
>=20
> --
>=20
>=20
> 					    Gilles Chanteperdrix.

