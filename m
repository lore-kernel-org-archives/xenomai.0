Message-ID: <4C6D4C01.2010402@domain.hid>
Date: Thu, 19 Aug 2010 17:21:37 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid> <4C6AA99D.3010907@domain.hid>
	<4C6B870C.7090600@domain.hid>
	<201008181003.09206.paul_c@domain.hid>
	<4C6BA2A1.4030005@domain.hid>
In-Reply-To: <4C6BA2A1.4030005@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCDAD3E95D48DEED35B2D00A1"
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
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDAD3E95D48DEED35B2D00A1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 18.08.2010 11:06, Gilles Chanteperdrix wrote:
> Paul wrote:
>  =20
>> On Wednesday 18 August 2010, Gilles Chanteperdrix wrote:
>>    =20
>>> Stefan Kisdaroczi wrote:
>>>      =20
>>>> On 17.08.2010 15:51, Hemal C.Bavishi wrote:
>>>>        =20
>>>>> When I tried to compile it with the latest version of kernel with
>>>>> xenomai 2.5.4, I am getting following errors in Xenomai (disable
>>>>> CONFIG_SMP, enable CONFIG_X86_UP_APIC and CONFIG_X86_UP_IOAPIC
>>>>> (*).)
>>>>>          =20
>>>> Just tested, got the same build error with 2.6.34.
>>>> If I patch 2.6.34 with prepare-kernel [1] it compiles,
>>>> if I use the debian packaged patch generated with prepare-patch [2]
>>>> it fails.
>>>>
>>>> I guess a fix is needed in prepare-patch for 2.6.34, but no time to
>>>> look closer now.
>>>>
>>>> Stefan
>>>>
>>>> [1] xenomai-2.5.4/scripts/prepare-kernel.sh
>>>> [2] xenomai-2.5.4/debian/prepare-patch.sh
>>>>        =20
>>> prepare-kernel.sh has a "--outpatch" option, which seems to be able
>>> to generate patches, so, would not it be possible to modify
>>> prepare-patch to simply call prepare-kernel.sh with the --outpatch
>>> option?
>>>
>>> This way, we will not have to duplicate into prepare-patch.sh the
>>> modifications we make to prepare-kernel.sh.
>>>      =20
>> The debian/prepare-patch.sh does not require a kernel source tree and =

>> generates patches for multiple kernels & arches - It is a fudge, but i=
t=20
>> works for the most part and does not impose dependencies of multiple=20
>> kernel source trees on package build systems.
>>    =20
> Ok. Understood. The thing is that prepare-patch.sh is broken, so now ma=
y
> be a good occasion to merge its functionality in prepare-kernel.sh, so
> that we do not duplicate the code in these two really non-trivial scrip=
ts.
>  =20

Hi Gilles,

There is another copy. The debian/ directory from the xenomai tree is
not used for debian packages at debian.org. The Debian Maintainer Roland
Stigge has his own debian/ directory.
I submitted a bugreport including the patch for this bug to debian [1].
If we move the prepare-patch.sh out of the debian/ dir (suggested by
Roland), that would not be necessary.

I suggest to move debian/prepare-patch.sh to
scripts/prepare-debian-patch.sh.
I'll create a patch if you agree.

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D593585

Stefan



--------------enigCDAD3E95D48DEED35B2D00A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxtTAsACgkQIPTw9rIdn6rD+QCfadCqcaiREYW49w6frfz7I/Ao
M0sAn09ZTTRHP4MyYZUsqrzBVoUYTSNc
=UY/E
-----END PGP SIGNATURE-----

--------------enigCDAD3E95D48DEED35B2D00A1--

