Message-ID: <4B85246A.2020907@domain.hid>
Date: Wed, 24 Feb 2010 14:06:50 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid> <4B76B7F2.2050303@domain.hid>	
	<4B76C045.2070602@domain.hid>	
	<1266140329.27019.17.camel@domain.hid>	
	<4B8407B5.10109@domain.hid>
	<1266947163.26785.300.camel@domain.hid>
In-Reply-To: <1266947163.26785.300.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig46E70A3EB83A53DAC0C8F64A"
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46E70A3EB83A53DAC0C8F64A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Am 23.02.2010 18:46, schrieb Philippe Gerum:
> On Tue, 2010-02-23 at 17:52 +0100, Stefan Kisdaroczi wrote:
>> Hi,
>>
>> Am 14.02.2010 10:38, schrieb Philippe Gerum:
>>>
>>> <snip>
>>> In the future, maybe we could simply provide a wrapper script accepti=
ng
>>> sub-commands, such as "xeno latency, xeno sigtest" etc, to be put
>>> into /usr/bin by distros, which would hide the actual location of tho=
se
>>> binaries?
>>>
>>> In any case, thanks for your work so far. We probably need to discuss=

>>> the packaging issues on this list, so that we get both consistency an=
d
>>> usability in the future.
>>>
>>> Gilles and Roland, if this is fine with you, I'll handle the liaison
>>> role with upstream packagers, so please CC me explicitly on those mai=
ls.
>>> We'll sort out this issue, it doesn't look that bad anyway.
>>
>> Roland added a xeno wrapper to the debian.org xenomai package 2.5.1-3.=

>>
>> I synced now the debian/ directories from debian.org and xenomai.org:
>>  - For debian.org I sent patches to the Debian bugtracker [1] [2].
>>    Another patch for dpkg-cross support [3] I sent to Roland privately=
=2E
>>  - For xenomai.org I attached patches to this mail (against -2.5.git).=

>>
>> If both parties apply the patches the debian directories are in sync,
>> except some minor differences in the debian/control file, see patch
>> do-not-commit-please.patch. I would like to keep these changes out so
>> that the xenomai.org packages are compatible with Debian 5.0 Lenny.
>> The debian.org packages are for Debian 6.0 Squeeze.
>>
>=20
> Merged into my queue (except the last one as mentioned). This will be
> pushed upstream to Gilles for 2.5.2. Thanks.

I took a look at your branch for-upstream. Your commit
  scripts: add wrapper script to run standard Xenomai commands
  6e0574791f48cbf8b3421a68c5789254e7d084b7
adds the same wrapper as my patch 0005-debian-wrapper-script-usr-bin-xeno=
-to-call-executa.patch
  debian: wrapper script /usr/bin/xeno to call executables in /usr/lib/xe=
nomai/
  fbe86cc50d3a65cd23e93d43adba4ed369fe70b1
Please revert the commit of my patch, we need another fix for debian/rule=
s for "your" wrapper.

How do I call configure to install the wrapper in /usr/bin and
the programs like latency, switchtest etc. to /usr/lib/xenomai ?

Stefan

>=20
>> Thanks
>> kisda
>>
>> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D571099
>> [2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D571104
>> [3] http://git.xenomai.org/?p=3Dxenomai-2.5.git;a=3Dcommitdiff;h=3D5bc=
d18f714f4cbeaaac0cc4a08e6c9f375aa3b77
>=20
>=20



--------------enig46E70A3EB83A53DAC0C8F64A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLhSRvIPTw9rIdn6oRAoC/AJ9zu0C8Zg0sK6x8Dg6cmyRGzPiR2QCeMy/6
4nO+7zWqOLEZJT2h7+cjOzc=
=59n2
-----END PGP SIGNATURE-----

--------------enig46E70A3EB83A53DAC0C8F64A--

