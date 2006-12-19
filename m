Message-ID: <4587F9CE.3060403@domain.hid>
Date: Tue, 19 Dec 2006 15:40:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [RFC] git workflow
References: <4582E67C.70108@domain.hid>
	<4587E99D.9070404@domain.hid>	<4587ECF0.4000907@domain.hid>
	<4587EFE2.8040302@domain.hid> <4587F5F9.7050906@domain.hid>
In-Reply-To: <4587F5F9.7050906@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig530421E927DCE20EC425E896"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig530421E927DCE20EC425E896
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Jan Kiszka wrote:
>>>>
>>>>
>>>>> ...
>>>>> [Keeping up-to-date]
>>>>> 1. The original kernel tree may have been updated, and the ipipe pa=
tch
>>>>>   needs to be rebased
>>>>>
>>>>>   # git fetch
>>>>>   # git rebase origin
>>>> I meanwhile learned that rebasing doesn't work well with public git
>>>> tree. Once you pushed some tree, say, linux-2.6.19 + ipipe-patch1..n=

>>>> out, you cannot rebase to 2.6.20 + ipipe-patch1..n without breaking =
the
>>>> linear history.
>>>>
>>>> Either we only push out final trees (but that would lock-out early
>>>> testers that may want to pull from devel-head), or we need to evolve=

>>>> with ipipe patches deeply merged. That means when we have 2.6.19 + i=
pipe
>>>> cleanly on top of it, pulling 2.6.20 origin may cause conflicts (lik=
e
>>>> the paravirt stuff does on i386 ATM). We would then have to merge th=
e
>>>> upstream patches into the I-pipe tree, effectively adopting them to
>>>> I-pipe. An extraction of a potential I-pipe patch stack would be mor=
e
>>>> complicated that way, but not infeasible.
>>>>
>>>> Comments?
>>> I am a complete git newbie myself. But the simpler way I would imagin=
e
>>
>> Then I'm at least not alone. :)
>>
>>
>>> to develop the I-pipe would be to create one branch for each version =
of
>>> the kernel. We would then use a script to generate all architectures
>>> specific patches.
>>>
>>> Porting from one version to the next means merging the difference
>>> between the ipipe branch for linux 2.x.y and the linux 2.x.y sources
>>> with the linux-2.x.y+1 sources.
>>
>> Of course, we could branch per major release and rebase on top of new
>> kernel versions. But that would mean we have to wait until the officia=
l
>> release to publish our trees. Otherwise, the risk would be the later
>> fixes require a rebase.
>=20
> Is it a big deal ?

Once there is a public tree with 2.6.20-rc1 + ipipe + -rc2, you cannot
simply turn that tree into 2.6.20-rc1 + -rc2 + ipipe. The order of
patches is practically frozen once published. In your private tree you
are, of course, free to do this and then extract some patch to post
upstream.

>=20
>> The point is likely how to extract ipipe stuff from a fully merged git=

>> tree. I think this should not be that tricky - as long as every patch =
in
>> some series only touches existing files exclusively (i.e. no two patch=
es
>> modify the same source file). Then we could simply apply some diff mas=
k
>> (git diff origin..master file1 file2 file3...) to generate those
>> individual patches for reference to anyone willing to port stuff to a
>> new arch or board.
>=20
> Yes, what we need is something similar to "svn merge" functionality.
>=20

That's integrated in git-pull.

Jan


--------------enig530421E927DCE20EC425E896
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFh/nOniDOoMHTA+kRAkFGAJ9UJHzhDe1tR39ElQJwCpgNVdEwUQCggagW
W/8Vy+CI2RAUHNBK8qmDv3o=
=YKgg
-----END PGP SIGNATURE-----

--------------enig530421E927DCE20EC425E896--

