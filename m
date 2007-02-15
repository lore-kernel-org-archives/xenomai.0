Message-ID: <45D42130.80609@domain.hid>
Date: Thu, 15 Feb 2007 10:00:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] pthread_make_periodic_np and clock_gettime
References: <5D63919D95F87E4D9D34FF7748CE2C2A82C5D7@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A82C5D7@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0E68A7F327B43D02C4BFBDE6"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0E68A7F327B43D02C4BFBDE6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Sorry for the stupid question but: what is tick_arg ? Do  I have to con=
figure it within Xenomai or is it a kernel parameter ?=20

tick_arg is a nucleus module parameter, overloading
CONFIG_XENO_OPT_TIMING_PERIOD which requires XENO_OPT_TIMING_PERIODIC.
What setup do you have?

My problem was that I accidentally started the kernel at tick_arg=3D1000
(1 us), which didn't caused a locked up system because I ran it in qemu.
Just the tick conversion routines got confused. On a real target, you
will not be able to use such a system at all.

> The timing of my target in principal is fine. When I set=20
>    tstart.tv_sec=3D0;
>    tstart.tv_nsec=3D0;=20
> both to zero, my task gets peiodic (task runs every second). Just when =
using clock_gettime(CLOCK_REALTIME,&tstart) I get into trouble.
>=20
> Roderik
>=20
>=20
>> -----Urspr=FCngliche Nachricht-----
>> Von: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
>> Gesendet: Mittwoch, 14. Februar 2007 18:44
>> An: Gilles Chanteperdrix
>> Cc: Wildenburg, Roderik RAEK3 MRA; Xenomai-help@domain.hid
>> Betreff: Re: [Xenomai-help] pthread_make_periodic_np and clock_gettime=

>>
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>  > Roderik_Wildenburg@domain.hid wrote:
>>>  > > Can anybody tell me, how I have to set the 2.=20
>> parameter (starttp)=20
>>> of  > > pthread_make_periodic_np ?
>>>  > > When I use clock_gettime to fill startp I get a giant timeout=20
>>> value in  > > the /proc/xenomai/sched list and my task=20
>> never gets periodic.
>>>  > >
>>>  > > Is this just a problem of my hardware(PPC)/xenomai(2.3)=20
>>> combination or  > > does anybody else have the same problem.
>>>  > >
>>>  > > See attached code example for easier testing.
>>>  > >
>>>  >
>>>  > Confirmed over v2.3.x in periodic mode, aperiodic is=20
>> fine. Gilles?
>>> Ok. I will have a look at it.
>>>
>> Hmm, something went wrong here. I think I passed a too fast=20
>> tick_arg to the kernel yesterday which smashed the timing.=20
>> I'm now running the pperiodic demo at tick_arg=3D1000000 successfully.=

>>
>> So, Roderik, either you did some similar mistake, or it's a PPC issue.=

>>
>> Jan
>>
>>
>=20
> MAN Roland Druckmaschinen AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Ral=
l, Paul Steidle
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933



--------------enig0E68A7F327B43D02C4BFBDE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1CExniDOoMHTA+kRAotAAJ9YuGAfjJAi6l6QTfbux0QpDVJOTgCgg/B4
3Z/5Ci+1lP8UMM9JNwXy3eY=
=nPwX
-----END PGP SIGNATURE-----

--------------enig0E68A7F327B43D02C4BFBDE6--

