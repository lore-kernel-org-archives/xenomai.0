Date: Fri, 6 Apr 2018 10:47:29 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180406104729.0a46cb24@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <99BAB48E90E86D42AD41F0BCE3225AEB019FC066DF@GRZSMS582.andritz.com>
References: <99BAB48E90E86D42AD41F0BCE3225AEB019FC0631A@GRZSMS582.andritz.com>
 <bbb33d4c-e8d0-b383-0424-d99592486988@siemens.com>
 <99BAB48E90E86D42AD41F0BCE3225AEB019FC066DF@GRZSMS582.andritz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] building Xenomai Apps with CMake (RFC)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Am Thu, 5 Apr 2018 15:54:34 +0000
schrieb Lange Norbert <norbert.lange@andritz.com>:

> Hello,
>=20
>  >-----Original Message-----
>  >From: Jan Kiszka [mailto:jan.kiszka@siemens.com]
>  >Sent: Donnerstag, 05. April 2018 16:55
>  >To: Lange Norbert; Xenomai (xenomai@xenomai.org); Henning Schild
>  >Subject: Re: building Xenomai Apps with CMake (RFC)
>  >
>  >E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>  >EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>  >ATTACHMENTS.
>  >
>  >
>  >On 2018-04-03 16:10, Lange Norbert wrote: =20
>  >> Hello,
>  >>
>  >> I went ahead and created a script to add support for Xenomai (3+)
>  >> to CMake. =20
>  >Its currently sufficient for me, =20
>  >> but I would like to get this in a shape that it is useful and
>  >> robust enough for =20
>  >most people. =20
>  >> Ultimately it should end up up streamed to CMake (I hope the
>  >> binutils-specific =20
>  >wrappers aren't a knock-out against adoption). =20
>  >>
>  >> Mostly this should interest people that want to use CMake, but a
>  >> few things =20
>  >might need support from the Xenomai distribution. =20
>  >> To be more specific: using precompiled object-files like the
>  >> boostrap code =20
>  >and its linker wraps and redirections are something I would =20
>  >> like to avoid, or atleast offer an alternative that does not need
>  >> that much =20
>  >work outside of a "regular build". =20
>  >> For that, having the bootstrap code (configurable or a few
>  >> variants) installed =20
>  >as sourcecode would help. =20
>  >>
>  >> Code is uploaded to Github :
>  >> https://github.com/nolange/cmake_xenomai =20
>  >
>  >Thanks for sharing this. IIRC, we have some Xeommai user in-house as
>  >well who looked into cmake, need to check the status and scope again
>  >(maybe Henning knows more). Could be interesting, indeed. =20
>=20
> If I may ask, are you using the "boostraps" from Xenomai or some own
> init-code? (that=E2=80=99s currently the biggest headache remaining)

No, i do not know anyone using CMake with Xenomai, so i would not know
how to deal with bootstrap there.

>  >
>  >For my understanding: You need cmake upstream changes to make things
>  >work? Or is this project something that could eventually be carried
>  >in Xenomai upstream, just requiring some cmake version >=3D X? =20
>=20
> No strict need to upstream the scripts in either Xenomai or CMake,
> the files just need to be in the search-path of CMake to be usable
> (likely doesnt need anything newer than CMake 3.0 but would need to
> test this). I value the feedback from both communities, particularly
> because I don=E2=80=99t use anything but the Posix/Cobalt Skin and gettin=
g it
> into CMake would be the best thing for maintenance.

It would probably be a good idea to try and mainline it in one of the
two projects. And my guess is that CMake would not really fit and they
might not want such code.

> Nevertheless it could be really helpful to add a headerfile in the
> Xenomai distribution, replicating the steps that
> 'boilerplate/init/bootstrap.c' does, and allowing to disable parts of
> the functionality like the main wrapper. That glue code would ideally
> be built together with libraries/executables using it (identical
> flags and such). Right now the code is mostly duplicated and placed
> with the CMake Scripts, which is not ideal.

I did not fully understand the bootstrap with regard to cmake yet. But
the magic wrapping is not pretty, also in other regards. So patches
that improve that, while actually targeting something like CMake, would
be welcome.

Now regarding CMake itself. Is not one of its main purposes to be
platform independant, that does not seem to be too useful for Xenomai.
And there is a zoo of such build systems out there, what about bazel,
scons, rake ... ? So i guess i am against adding support for any such
thing to xenomai, especially if its OS abstractions do not match --
like it seems to be the case for CMake.

Henning

> Norbert
> ________________________________
>=20
> This message and any attachments are solely for the use of the
> intended recipients. They may contain privileged and/or confidential
> information or other information protected from disclosure. If you
> are not an intended recipient, you are hereby notified that you
> received this email in error and that any review, dissemination,
> distribution or copying of this email and any attachment is strictly
> prohibited. If you have received this email in error, please contact
> the sender and delete the message and any attachment from your system.
>=20
> ANDRITZ HYDRO GmbH
>=20
>=20
> Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung /
> Corporation
>=20
> Firmensitz/ Registered seat: Wien
>=20
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
>=20
> Firmenbuchnummer/ Company registration: FN 61833 g
>=20
> DVR: 0605077
>=20
> UID-Nr.: ATU14756806
>=20
>=20
> Thank You
> ________________________________


