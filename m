From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-reply-to: <49FF08C4.40908@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A018D48CC@ARVMAIL1.mra.roland-man.biz>
	<49FDFCC7.6000009@domain.hid>
	<20090504072304.A7E2483420E8@domain.hid>
	<49FF08C4.40908@domain.hid>
Date: Mon, 04 May 2009 20:01:34 +0200
Message-Id: <20090504180134.D9D5283420E8@domain.hid>
Subject: Re: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Lockhart <Thomas.Lockhart@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Thomas,

In message <49FF08C4.40908@domain.hid> you wrote:
>
> > >> 1.) If I don=B4t page align the size of shared memory (multiple of
> > >> 4096)...
> >  The restrictions for page allignments affect the addr and offset
> >  paraemters only. To me it seems clear that mmap() in plain Linux and
> >  Xenomai behave differently.
>=20
> Sorry for not having the start of the thread. I'm not sure if it is=20
> helpful to note that when I implemented memory mapped "device drivers"=20
> for our system I had to align the address and offset to the page size=20
> before the call to mmap would succeed. That was with plain Linux and the =

> driver also works with Xenomai.

This is correct, and documented behaviour. And if one thinks about
possible implementations, it just makes sense.

But the problem that the origonal poster reported was  a  restriction
of  the "length" parameter - his test seems to demonstrate that under
Xenomai the legth must be a multiple of the page sise, while in plain
Linux no such restriction exists (I can provide test  code  for  that
case, if wanted).

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
What can it profit a man to gain the whole world and to come  to  his
property with a gastric ulcer, a blown prostate, and bifocals?
                                     -- John Steinbeck, _Cannery Row_

