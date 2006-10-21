Message-ID: <453A4C48.9000008@domain.hid>
Date: Sat, 21 Oct 2006 18:35:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 0/2] Selectable heap allocators
References: <453911D4.8060901@domain.hid> <1161388618.4988.198.camel@domain.hid>
In-Reply-To: <1161388618.4988.198.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC2AC01A62E3D1C2C3EDB53B5"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Miguel Angel Masmano Tello <mimastel@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2AC01A62E3D1C2C3EDB53B5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2006-10-20 at 20:13 +0200, Jan Kiszka wrote:
>> Hi,
>>
>> here comes a patch series for an idea I have in mind for quite some
>> time: break up the nucleus heap layer so that it can support different=

>> allocation schemes. Motivated was this idea by the great TLSF allocato=
r
>> by Miguel Masmano et al.
>>
>> I once played with TLSF in userspace as a malloc replacement for RT
>> apps, and I wondered if we shouldn't make use of it as well in the
>> nucleus. It's most beautiful property is its strict O(1) complexity in=

>> my eyes, but it seems to provide even more qualities: less
>> fragmentation, less overhead, maybe even better performance.
>>
>> I haven't done any thorough analysis on those advantages (I'm counting=

>> on Miguel and others to prove them ;) ), only stability tests over the=

>> last weeks and a simple comparisons of the overhead. With 8 user-space=

>> tasks, a few mutexes, 8 RTDM sockets, and likely some other stuff
>> allocated I get e.g. these usage numbers:
>=20
>> bsdalloc:
>> size=3D524288:used=3D17720:pagesz=3D512
>>
>> tlsfalloc:
>> size=3D524288:used=3D14036:pagesz=3D512
>>
>=20
> I'm ok to merge different allocators - and the needed infrastructure to=

> support that - provided having several of them actually buys us
> something significant, maybe depending on some usage patterns. Actually=
,
> I once made the basic assumption that the BSDish heap could fulfill any=

> kind of allocation requirements for all the use cases we should care
> about; maybe I was wrong, in which case, we should discuss of the
> particular issue of introducing an abstract layer to support several
> allocators. If the assumption remains unchallenged, then we don't need
> to abstract this, and the issue boils down to whether we should switch
> to TLSF or keep BSD.
>=20
> This also means that we first need real figures for practical use cases=

> comparing BSD and TLSF, before going any step further (at least interna=
l
> and external fragmentation values, allocation and deallocation
> worst-case for bulks of contiguous and discontiguous blocks from variou=
s
> sizes, and anything else you may find relevant). At that point, we coul=
d
> decide whether we should provide both over the abstract infrastructure,=

> simply replace BSD with TLSF, or keep the status quo.

I agree that we definitely need numbers. And I could imagine that TLSF
turns out to be the better choice in most, if not all categories.

But given the situation that a) TLSF is not yet a full BSD replacement
due to the known shortcomings (missing 64 bit, no extensible heaps)
while b) we want to test it against real Xenomai load, I think that
having such switching infrastructure even just for one or two versions
is the most effective way. Maintaining a patch just to allow testing
would be a pain and would not attract further users beyond the core team.=


Jan


--------------enigC2AC01A62E3D1C2C3EDB53B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFOkxIniDOoMHTA+kRArebAJ9+1QcOnHM0jbqLBmkWmoK3oJkhkgCgg78i
Wy9xdXBNvDinms3TwFKloks=
=zxai
-----END PGP SIGNATURE-----

--------------enigC2AC01A62E3D1C2C3EDB53B5--

