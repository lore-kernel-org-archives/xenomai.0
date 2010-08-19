Message-ID: <4C6D663C.9010709@domain.hid>
Date: Thu, 19 Aug 2010 19:13:32 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid> <4C6AA99D.3010907@domain.hid>
	<4C6B870C.7090600@domain.hid>
	<201008181003.09206.paul_c@domain.hid>
	<4C6BA2A1.4030005@domain.hid> <4C6D4C01.2010402@domain.hid>
	<4C6D4D9F.2060200@domain.hid>
In-Reply-To: <4C6D4D9F.2060200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF3FB12747712DD7BBE97C8B0"
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF3FB12747712DD7BBE97C8B0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 19.08.2010 17:28, Gilles Chanteperdrix wrote:
> Stefan Kisdaroczi wrote:
>  =20
>> On 18.08.2010 11:06, Gilles Chanteperdrix wrote:
>>    =20
>>> Paul wrote:
>>>  =20
>>>      =20
>>>> On Wednesday 18 August 2010, Gilles Chanteperdrix wrote:
>>>>    =20
>>>>        =20
>>>>> Stefan Kisdaroczi wrote:
>>>>>      =20
>>>>>          =20
>>>>>> On 17.08.2010 15:51, Hemal C.Bavishi wrote:
>>>>>>        =20
>>>>>>            =20
>>>>>>> When I tried to compile it with the latest version of kernel with=

>>>>>>> xenomai 2.5.4, I am getting following errors in Xenomai (disable
>>>>>>> CONFIG_SMP, enable CONFIG_X86_UP_APIC and CONFIG_X86_UP_IOAPIC
>>>>>>> (*).)
>>>>>>>          =20
>>>>>>>              =20
>>>>>> Just tested, got the same build error with 2.6.34.
>>>>>> If I patch 2.6.34 with prepare-kernel [1] it compiles,
>>>>>> if I use the debian packaged patch generated with prepare-patch [2=
]
>>>>>> it fails.
>>>>>>
>>>>>> I guess a fix is needed in prepare-patch for 2.6.34, but no time t=
o
>>>>>> look closer now.
>>>>>>
>>>>>> Stefan
>>>>>>
>>>>>> [1] xenomai-2.5.4/scripts/prepare-kernel.sh
>>>>>> [2] xenomai-2.5.4/debian/prepare-patch.sh
>>>>>>        =20
>>>>>>            =20
>>>>> prepare-kernel.sh has a "--outpatch" option, which seems to be able=

>>>>> to generate patches, so, would not it be possible to modify
>>>>> prepare-patch to simply call prepare-kernel.sh with the --outpatch
>>>>> option?
>>>>>
>>>>> This way, we will not have to duplicate into prepare-patch.sh the
>>>>> modifications we make to prepare-kernel.sh.
>>>>>      =20
>>>>>          =20
>>>> The debian/prepare-patch.sh does not require a kernel source tree an=
d=20
>>>> generates patches for multiple kernels & arches - It is a fudge, but=
 it=20
>>>> works for the most part and does not impose dependencies of multiple=
=20
>>>> kernel source trees on package build systems.
>>>>    =20
>>>>        =20
>>> Ok. Understood. The thing is that prepare-patch.sh is broken, so now =
may
>>> be a good occasion to merge its functionality in prepare-kernel.sh, s=
o
>>> that we do not duplicate the code in these two really non-trivial scr=
ipts.
>>>  =20
>>>      =20
>> Hi Gilles,
>>
>> There is another copy. The debian/ directory from the xenomai tree is
>> not used for debian packages at debian.org. The Debian Maintainer Rola=
nd
>> Stigge has his own debian/ directory.
>>    =20
> Yes, I know that. And this makes me wonder how Roland generated the
> patches for 2.5.4, since his script is identical to ours.
>  =20

The patch generating worked without obvious problems and the patches
apply cleanly. But the patched kernels are failing to build if
CONFIG_XENOMAI is set on kernels 2.6.33+. As debian squeeze will ship
with a 2.6.32 kernel he probably just tested 2.6.32 and this worked.

There is also a chance that he didn't test to build a xenomai patched
kernel at all, as the important thing was to have 2.5.4 uploaded before
the squeeze-freeze and that no release-critical bugs are filed until the
package migration from unstable to testing. You released 2.5.4 the 2.8.,
he uploaded 4.8., freeze was 6.8. and the package migrated to testing
the 15.8. He already has a upload permission from the
debian-release-team for a bugfix-upload of xenomai. He really is doing a
very good job. Yes, I remember the discussion you had last winter about
2.4.x, but for debian the most important is to have the latest possible
upstream version uploaded just before freeze, and he succeeded.

For a bad maintaining example look at Ubuntu. I filed a bugreport the
22.3.2010:
https://bugs.launchpad.net/ubuntu/+source/xenomai/+bug/544284
No response, no upload, nothing, still xenomai 2.4.8... And Ubuntu is
debian unstable based, so they only have to sync.
This is probably the reason for all those 'building packages for Ubuntu
10.04'-questions on this list. If Ubuntu would ship a newer version the
beginners could directly introduce themselves with the 'Why do i get
negative latency values?'-question :-)

>> If we move the prepare-patch.sh out of the debian/ dir (suggested by
>> Roland), that would not be necessary.
>>
>> I suggest to move debian/prepare-patch.sh to
>> scripts/prepare-debian-patch.sh.
>> I'll create a patch if you agree.
>>    =20
> I do not understand how changing the script location or name remove the=

> duplication between this script and prepare-kernel.sh. We fixed the
> issue with the location of ipipe.h in prepare-kernel.sh ages ago, so, a=
s
> far as I understand, the bug comes from this duplication.
>
> I really think the good idea is to implement the functionality of
> prepare-patch.sh (i.e. being able to generate a patch without the kerne=
l
> sources) into prepare-kernel.sh --outpatch command, and simply make
> prepare-patch.sh call prepare-kernel, this would end all the duplicatio=
n
> between the two scripts.
>  =20

ok, as you said above it's 'non-trivial' but on the other side we are
not in a hurry.

Stefan



--------------enigF3FB12747712DD7BBE97C8B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxtZkMACgkQIPTw9rIdn6pigwCfWnesbNoydMx95lTLRnylhYuX
btoAniHykXlkndfAzv3LNu89p8wv9xXk
=nsO9
-----END PGP SIGNATURE-----

--------------enigF3FB12747712DD7BBE97C8B0--

