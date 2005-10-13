Message-ID: <434E6E89.8060904@domain.hid>
Date: Thu, 13 Oct 2005 16:26:17 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] A couple of questions
References: <18969.193.52.24.125.1129211788.squirrel@domain.hid>
In-Reply-To: <18969.193.52.24.125.1129211788.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig92FA6CC888FA0189077DB4F5"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smannori <smannori@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92FA6CC888FA0189077DB4F5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

smannori wrote:
> Hi everybody:
> 
> I think that this fork is a very good opportunity to "start with the
> right foot". I believe also that a document like
> 
> https://mail.rtai.org/pipermail/rtai/2005-June/011949.html
> 
> but with Fusion/Xenomai it would be a very good starting point for a
> relatively inexperienced user. What I do until now:
> - I dowloaded, adeos-patched, configured & compiled kernel 2.6.13.4
> - I downloaded, configured, installed fusion 0.9.1
> - I run sucessfull all the [testsuite] examples
> - I dowloaded all the pdf(s)
> 
> Now the questions:
> 1) it is important dowload and install fusion OR xenomai ?

Fusion-0.9.1 is, so to say, the current release of Xenomai. Xenomai 2.0
will be the next one soon.

> 2) why the xenomai files are so old (2002) ?

That version are pre-fusion actually. Latest Xenomai is only available
via subversion checkout, see https://gna.org/projects/xenomai

> 3) I think that a very important PDF file - already present in the past
> in www.rtai.org - is missed: the Fusion tutorial with examples.

Some are already there (http://download.gna.org/xenomai/documentation).
Please report precisely what you are lacking.

> 4) where I can find some Fusion/Xenomai examples, complete of instruction
> to compile and link to create standalone applications ?

For which skin, i.e. for which user API (native, POSIX, classic RTAI)?
Also check the /doc folders in the skins source code directories.

> 5) how is it possible to use Comedi driver ?

Maybe with some (or more) adaptions in combination with the RTAI
compatibility skin. Out ouf the box: not yet.

On the long term, it would be good to port Comedi over the RTDM layer,
thus also enabling a reuse under other real-time Linux variants. This
would reduce the burden for Comedi to adapt itself to differen APIs.
That's a kind of discussion for xenomai-core BTW. ;)

> 6) how port xrtailab under Xenomai/Fusion ?

Don't know details about it, but the first step could again be the RTAI
skin.

> 7) it is possible use USB device (eg. camera) realtime ?

USB4RT is a (currently dormant) project to provide low-level USB access.
We have a special camera driver for the stack here. Other devices would
require a port (Do you have a native Linux driver for the desired
camera?). Moreover, USB4RT will first require a cleanup adaption to the
latest developement around Fusion/Xenomai, e.g. a port over the RTDM
layer. Scheduled, but I cannot give any dates for this.

Jan

--------------enig92FA6CC888FA0189077DB4F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDTm6JncNeS9Q0k+IRAmKGAKCQ9Bi/RS1M55YsGikAB5g1C1etywCgreAa
EcMTr9l0FPCsLuvS33wW/PI=
=OHuw
-----END PGP SIGNATURE-----

--------------enig92FA6CC888FA0189077DB4F5--

