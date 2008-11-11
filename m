Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Nov 2008 10:43:41 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D53344A@slcmail.slc.mew.int>
In-Reply-To: <1c74c6152ff1b52eaa3dd84f4b912b29.squirrel@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid><490ECE11.208@domain.hid><51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int><490F2F23.2080307@domain.hid><67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid><49100825.9000502@domain.hid>
	<4915C4D3.8030304@domain.hid><67b6b3430811101607k75eaa084ga387c453096d2710@domain.hid>
	<1c74c6152ff1b52eaa3dd84f4b912b29.squirrel@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] fpu context switch issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai@xenomai.org

The problem was you declared x86_fpu_state instead of x86_fpustate. No
big deal.

Steven

> -----Original Message-----
> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-
> bounces@domain.hid] On Behalf Of Gilles Chanteperdrix
> Sent: Tuesday, November 11, 2008 4:21 AM
> To: Mark Saiia
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] fpu context switch issue
>=20
>=20
> Mark Saiia wrote:
> > Hello,
> >
> > The patch would not apply cleanly(rejected Hunk) against 2.4.5
> > w/linux2.6.26.3 or svn 4368 w/linux2.6.26.7.
> > (...)
> > Please let me know, if I did anything incorrectly, or if the patch
> was not
> > completely posted.
>=20
> No, I probably made the patch against 2.6.27, I did not test it. Could
> you
> try the patch you made ?
>=20
> --
>                     Gilles.
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

