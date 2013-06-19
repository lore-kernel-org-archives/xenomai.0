From: HAUTBOIS Flavian <Flavian.HAUTBOIS@cea.fr>
Date: Wed, 19 Jun 2013 09:00:13 +0000
Message-ID: <49E736B33FAAA645BCAB9FFEC26712E6FD1676@EXDAG0-B0.intra.cea.fr>
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
	<b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
	<201306191051.50947.leo@alaxarxa.net>
In-Reply-To: <201306191051.50947.leo@alaxarxa.net>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] CPU time limit exceeded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Yes I did.

What kind of bug?

-----Message d'origine-----
De=A0: Leopold Palomo-Avellaneda [mailto:leo@alaxarxa.net]=20
Envoy=E9=A0: mercredi 19 juin 2013 10:52
=C0=A0: xenomai@xenomai.org
Cc=A0: HAUTBOIS Flavian; Gilles Chanteperdrix
Objet=A0: Re: [Xenomai] CPU time limit exceeded

Flavian,

did you use 2.6.2.1?

I'm asking because there's a bug in 2.6.2 that maybe could be it.

Leo

A Dimecres, 19 de juny de 2013, HAUTBOIS Flavian va escriure:
> Thanks a lot for this complete and short answer.
>=20
> - I didn't find any mention of PTHREAD_WARNSWS throughout the entire=20
> code
via a grep command. However, I found a T_WARNSW mention in the Orocos files=
, which according to sigdebug.c apparently does the same thing.
> - This __wrap_send problem might be a key to solving this issue. I=20
> enclosed
the "ldd" and "nm" traces of the some_core library (you can find mentions o=
f __wrap_send in the nm.txt file, as well as the core_dump.txt file which c=
ontains a backtrace of the core dump when the program crashes).
> - I included the handler of sigdebug.c in my own file. I'm also=20
> enclosing
what it returned in sigcpu.txt. I didn't find anything new or unexpected in=
 it, but I have to admit that I don't know how to read 95% of the file.
>=20
> Do you have any ideas why RTNet does not seem to be used? How to fix it?
>=20


--
--
Linux User 152692
Catalonia

