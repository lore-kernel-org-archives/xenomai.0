Message-ID: <16965344.1179297419368.JavaMail.ngmail@domain.hid>
Date: Wed, 16 May 2007 08:36:59 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <cbe23c50705151054x779cccb0v2128d3b8ca1bfa87@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <cbe23c50705151054x779cccb0v2128d3b8ca1bfa87@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB2004@domain.hid>
	<4649A485.5010102@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB20E6@domain.hid>
	<4649C8B6.2050304@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB2122@domain.hid>
Subject: Re: [Xenomai-help] memcpy performance on Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: eric.noulard@domain.hid, daniel.schnell@domain.hid
Cc: xenomai@xenomai.org

Hi!

I am not an memory expert.
However, I think that a zero-only page is handled specially by the MMU
(it actually does not use physical memory).
This is the reason why a malloc for a huge amount of memory is typically su=
ccessful even if there
is not that much physical memory available.
With malloc and a memset to zero only this will typically not lead to a phy=
sical RAM usage (I thinks this
is the "copy-on-write" (COW) stuff)
Thus, I recommend to do a memset with a non-zero value after allocating the=
 memory.

memset(buf1,123,msgsize); =20
memset(buf2,123,msgsize);

This should lead to a fair comparison.=20

Regards

Mathias
> > Some interesting insights about my last tests.
> >
> > 1.) The culprit is mlockall(MCL_FUTURE|MCL_CURRENT);
> >
> > As soon I leave this away, I get much better results:
> >
> > Without mlockall():
> > Test (10) memcpy of sizes (10485760)
> > 10 memcpy. Time per memcpy: 78147209 [nsec] (134 MB/sec)
> >  finished.
> >
> > With mlockall():
> > Test (10) memcpy of sizes (10485760) ....
> > 10 memcpy. Time per memcpy: 124194618 [nsec] (84 MB/sec)
> >  finished.
>=20
>=20
> I think you are not measuring the same thing in both case.
> I did some test on 2.6.20 (precompiled debian etch kernel)
> on a 1.6 GHz Pentium M.
>=20
> I think the fact that you malloced your buffer and then
> immediatly memcpy the buffers does a non repeatable measure
> (at least on my side)
> depending on something I do not understand .
>=20
> Could you try my modified version of your code which
> adds:
>=20
> memset(buf1,'\0',msgsize);
> memset(buf2,'\0',msgsize);
>=20
> just after malloc (you may try calloc too).
>=20
> With this modification
> I get similar figure for the mlockall version on my (quasi)-vanilla kerne=
l.
>=20
> that is:
>=20
> ./memcpy_perf_mlockall
> Test (10) memcpy of sizes (10485760) ....
> 10 memcpy. Time per memcpy: 35716568 [nsec] (293 MB/sec)
>  finished.
>=20
> ./memcpy_perf_memset
> Test (10) memcpy of sizes (10485760) ....
> 10 memcpy. Time per memcpy: 36004454 [nsec] (291 MB/sec)
>  finished.
>=20
> ./memcpy_perf
> Test (10) memcpy of sizes (10485760) ....
> 10 memcpy. Time per memcpy: 23881352 [nsec] (439 MB/sec)
>  finished.
>=20
>=20
> I think that without mlockall or no memset the memory pages you
> requested with malloc and did not --really-- get are brought to
> physical memory only when memcpy comes.
>=20
> What puzzles me is WHY it is faster WITHOUT touching the page
> BEFORE memcpy???
>=20
> Any memory handling expert is welcomed to answer.
>=20
> > Then again I cannot use Xenomai without mlockall()
> > :(
>=20
> And you cannot design a realtime application without
> ensuring you really have the memory you requested,
> this is not a xenomai issue (my opinion though).
>=20
> PS: on line compilation used:
>=20
> gcc memcpy_perf-erk.c -o memcpy_perf -lrt
> gcc -DMLOCK memcpy_perf-erk.c -o memcpy_perf_mlockall -lrt
> gcc -DMEMSET memcpy_perf-erk.c -o memcpy_perf_memset -lrt
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

