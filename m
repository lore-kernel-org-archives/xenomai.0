Message-ID: <4B86710C.1010607@domain.hid>
Date: Thu, 25 Feb 2010 13:46:04 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>
	<4B76B7F2.2050303@domain.hid>		<4B76C045.2070602@domain.hid>		<1266140329.27019.17.camel@domain.hid>		<4B8407B5.10109@domain.hid>	<1266947163.26785.300.camel@domain.hid>
	<4B85246A.2020907@domain.hid>
In-Reply-To: <4B85246A.2020907@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8AE1A53272A812E2BC00B05C"
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8AE1A53272A812E2BC00B05C
Content-Type: multipart/mixed;
 boundary="------------050804040309020605000708"

This is a multi-part message in MIME format.
--------------050804040309020605000708
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 24.02.2010 14:06, schrieb Stefan Kisdaroczi:
> Hi Philippe,
>=20
> Am 23.02.2010 18:46, schrieb Philippe Gerum:
>> On Tue, 2010-02-23 at 17:52 +0100, Stefan Kisdaroczi wrote:
>>> Hi,
>>>
>>> Am 14.02.2010 10:38, schrieb Philippe Gerum:
>>>>
>>>> <snip>
>>>> In the future, maybe we could simply provide a wrapper script accept=
ing
>>>> sub-commands, such as "xeno latency, xeno sigtest" etc, to be put
>>>> into /usr/bin by distros, which would hide the actual location of th=
ose
>>>> binaries?
>>>>
>>>> In any case, thanks for your work so far. We probably need to discus=
s
>>>> the packaging issues on this list, so that we get both consistency a=
nd
>>>> usability in the future.
>>>>
>>>> Gilles and Roland, if this is fine with you, I'll handle the liaison=

>>>> role with upstream packagers, so please CC me explicitly on those ma=
ils.
>>>> We'll sort out this issue, it doesn't look that bad anyway.
>>>
>>> Roland added a xeno wrapper to the debian.org xenomai package 2.5.1-3=
=2E
>>>
>>> I synced now the debian/ directories from debian.org and xenomai.org:=

>>>  - For debian.org I sent patches to the Debian bugtracker [1] [2].
>>>    Another patch for dpkg-cross support [3] I sent to Roland privatel=
y.
>>>  - For xenomai.org I attached patches to this mail (against -2.5.git)=
=2E
>>>
>>> If both parties apply the patches the debian directories are in sync,=

>>> except some minor differences in the debian/control file, see patch
>>> do-not-commit-please.patch. I would like to keep these changes out so=

>>> that the xenomai.org packages are compatible with Debian 5.0 Lenny.
>>> The debian.org packages are for Debian 6.0 Squeeze.
>>>
>>
>> Merged into my queue (except the last one as mentioned). This will be
>> pushed upstream to Gilles for 2.5.2. Thanks.
>=20
> I took a look at your branch for-upstream. Your commit
>   scripts: add wrapper script to run standard Xenomai commands
>   6e0574791f48cbf8b3421a68c5789254e7d084b7
> adds the same wrapper as my patch 0005-debian-wrapper-script-usr-bin-xe=
no-to-call-executa.patch
>   debian: wrapper script /usr/bin/xeno to call executables in /usr/lib/=
xenomai/
>   fbe86cc50d3a65cd23e93d43adba4ed369fe70b1
> Please revert the commit of my patch, we need another fix for debian/ru=
les for "your" wrapper.

Thanks for reverting. Roland has uploaded 2.5.1-4 yesterday.
Attached a patch to stay in sync. Based on your for-upstream branch this =
time.

kisda

> How do I call configure to install the wrapper in /usr/bin and
> the programs like latency, switchtest etc. to /usr/lib/xenomai ?
>=20
> Stefan
>=20
>>
>>> Thanks
>>> kisda
>>>
>>> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D571099
>>> [2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D571104
>>> [3] http://git.xenomai.org/?p=3Dxenomai-2.5.git;a=3Dcommitdiff;h=3D5b=
cd18f714f4cbeaaac0cc4a08e6c9f375aa3b77
>>
>>
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--------------050804040309020605000708
Content-Type: text/plain;
 name="0001-debian-sync-2.5.1-4-from-debian.org.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-debian-sync-2.5.1-4-from-debian.org.patch"

RnJvbSBmNmI3YTAxMTVmM2Y3ODVmMDhmOGQwODVlNjZjOGJmOGQ3MDU3Zjg4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gS2lzZGFyb2N6aSA8a2lzZGFAaGlzcGVl
ZC5jaD4KRGF0ZTogVGh1LCAyNSBGZWIgMjAxMCAxMzoyNzozMSArMDEwMApTdWJqZWN0OiBb
UEFUQ0hdIGRlYmlhbjogc3luYyAyLjUuMS00IGZyb20gZGViaWFuLm9yZwoKLS0tCiBkZWJp
YW4vY2hhbmdlbG9nICAgICAgICB8ICAgIDkgKysrKysrKysrCiBkZWJpYW4vbGlieGVub21h
aTEuZGlycyB8ICAgIDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kZWJpYW4vY2hhbmdlbG9nIGIvZGViaWFu
L2NoYW5nZWxvZwppbmRleCA0NTczNmE0Li42ZDJkM2NmIDEwMDY0NAotLS0gYS9kZWJpYW4v
Y2hhbmdlbG9nCisrKyBiL2RlYmlhbi9jaGFuZ2Vsb2cKQEAgLTEsMyArMSwxMiBAQAoreGVu
b21haSAoMi41LjEtNCkgdW5zdGFibGU7IHVyZ2VuY3k9bG93CisKKyAgKiBBZGRlZCBwYXRj
aGVzIGJ5IFN0ZWZhbiBLaXNkYXJvY3ppIDxraXNkYUBoaXNwZWVkLmNoPjoKKyAgICAtIGRl
Ymlhbi9jb3B5cmlnaHQ6IFR5cG8gYW5kIGVtYWlsIGFkZHJlc3MgKENsb3NlczogIzU3MTA5
OSkKKyAgICAtIGRlYmlhbi9jb250cm9sOiBpYTY0IHN1cHBvcnQgcmVtb3ZlZCAoQ2xvc2Vz
OiAjNTcxMTA0KQorICAgIC0gZGViaWFuL3J1bGVzOiBBZGRlZCBkcGtnLWNyb3NzIHN1cHBv
cnQKKworIC0tIFJvbGFuZCBTdGlnZ2UgPHN0aWdnZUBhbnRjb20uZGU+ICBXZWQsIDI0IEZl
YiAyMDEwIDIyOjIwOjEwICswMTAwCisKIHhlbm9tYWkgKDIuNS4xLTMpIHVuc3RhYmxlOyB1
cmdlbmN5PWxvdwogCiAgICogeGVub21haS1ydW50aW1lOiBSZXBsYWNlZCAieGVub21haS0i
IHByZWZpeGVkIGV4ZWN1dGFibGVzIHdpdGgKZGlmZiAtLWdpdCBhL2RlYmlhbi9saWJ4ZW5v
bWFpMS5kaXJzIGIvZGViaWFuL2xpYnhlbm9tYWkxLmRpcnMKaW5kZXggZDViYjM0Zi4uMTcz
N2VhMSAxMDA2NDQKLS0tIGEvZGViaWFuL2xpYnhlbm9tYWkxLmRpcnMKKysrIGIvZGViaWFu
L2xpYnhlbm9tYWkxLmRpcnMKQEAgLTEsMiArMSwyIEBACi1ldGMvdWRldgorZXRjL3VkZXYv
cnVsZXMuZAogdXNyL3NoYXJlL2xpbnRpYW4vb3ZlcnJpZGVzCi0tIAoxLjUuNi41Cgo=
--------------050804040309020605000708--

--------------enig8AE1A53272A812E2BC00B05C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLhnESIPTw9rIdn6oRAju/AJ9qy2YJiPn+KnFKFzsHMaOnZ6VRjwCfe0vY
h8yUoc4wxtmrEGhEw0hFgNU=
=WMk3
-----END PGP SIGNATURE-----

--------------enig8AE1A53272A812E2BC00B05C--

