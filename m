Message-ID: <48022A14.4050802@domain.hid>
Date: Sun, 13 Apr 2008 17:43:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <001f01c89cc6$f269b250$0202a8c0@domain.hid>	<18433.65.910459.873472@domain.hid>	<000701c89d68$8857e380$0202a8c0@domain.hid>	<48020FEA.20309@domain.hid>
	<003401c89d78$d187bf70$0202a8c0@domain.hid>
In-Reply-To: <003401c89d78$d187bf70$0202a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB50B1753E0BB4EE1B1F92D4C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Communication between Xenomai and Linux domains
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: van der Linden <ejvanderlinden@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB50B1753E0BB4EE1B1F92D4C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

van der Linden wrote:
> Jan,
>=20
> I have two real-time requirements:
>=20
> 1.  I have to get audio from ALSA and deliver it to a custom FPGA drive=
r and=20
> vice versa each 5 miliseconds.
>      So, I will set the chunk size for ALSA in such a way I get 5 ms au=
dio=20
> samples. From the FPGA I also get chunks of 5ms.
>=20
>      There may be some jitter in delivering between ALSA and FPGA but t=
hink=20
> of one or two miliseconds.

That sounds more than feasible.

>=20
> 2. I want to receive 5ms audio from ALSA and after filtering and proces=
sing=20
> it I have to sent it back to ALSA.
>     This must be done within 10ms.
>=20
> We tested the real-time patches but the interrupt latency was not good =

> enough on our Blackfin 537 DSP (measured with a latency measuring tool)=
=2E
> With Xenomai installed the latency tool showed very good response. So I=
 want=20
> to go the Xenomai way.

Yeah, there is no -rt in sight for Blackfin, thus going this way makes
sense. But you won't get around porting basic ALSA support into the
Xenomai domain. However, this can be fairly simply, provided a straight
audio controller design.

>=20
> So therefor I like to know more about the Xenomai / Linux interaction a=
nd=20
> the performance measuring method (see original mailing).

Regarding Xenomai/Linux interaction, there are basically two patterns:

 - Lock-less queues in shared memory between both sides.

 - A Xenomai "borderline" thread at low priority that interacts with
   other Xenomai threads in primary mode (e.g. via message queues or
   using shared memory and Xenomai mutexes, semaphores, etc.), then
   switches to secondary mode for its Linux tasks (like socket access)
   but without holding any lock at this point(!), and finally starts the
   loop all over again. Note that domain switching takes place
   automatically, you only have to take care of a clean design
   (RT/non-RT separation).

One warning regarding I-pipe/Xenomai on Blackfin, though: the last time
I checked we still had some issue in the patch that can cause scheduling
artifacts on the Linux side (but not for Xenomai!). This may not bite
you in your scenario, and I know of quite a few Blackfin applications
based on Xenomai which are fine as well, but one should be aware of this.=


HTH,
Jan


--------------enigB50B1753E0BB4EE1B1F92D4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIAioYniDOoMHTA+kRAlYSAJ9g1kbT4B199gyWXinQG5uwNroBVACeIRyE
cggTQ0rbm/Iu1aFNE2XmYBI=
=1VzW
-----END PGP SIGNATURE-----

--------------enigB50B1753E0BB4EE1B1F92D4C--

