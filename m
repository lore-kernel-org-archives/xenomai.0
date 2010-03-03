Message-ID: <4B8E9439.1080700@domain.hid>
Date: Wed, 03 Mar 2010 17:54:17 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid> <4B76B7F2.2050303@domain.hid>	
	<4B76C045.2070602@domain.hid>	
	<1266140329.27019.17.camel@domain.hid>	
	<4B8407B5.10109@domain.hid>	
	<1266947163.26785.300.camel@domain.hid>	
	<4B85246A.2020907@domain.hid>	
	<1267017080.26785.324.camel@domain.hid>	
	<1267017203.26785.325.camel@domain.hid>	
	<4B87C8FA.6020802@domain.hid>	
	<1267190937.3405.10.camel@domain.hid>	
	<4B87D121.6020103@domain.hid>
	<1267193228.3405.24.camel@domain.hid>
In-Reply-To: <1267193228.3405.24.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2A82031784EC942C25A9C3B8"
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
--------------enig2A82031784EC942C25A9C3B8
Content-Type: multipart/mixed;
 boundary="------------020209060204040507090604"

This is a multi-part message in MIME format.
--------------020209060204040507090604
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 26.02.2010 15:07, schrieb Philippe Gerum:
> On Fri, 2010-02-26 at 14:48 +0100, Stefan Kisdaroczi wrote:
>> Am 26.02.2010 14:28, schrieb Philippe Gerum:
>>> On Fri, 2010-02-26 at 14:13 +0100, Stefan Kisdaroczi wrote:
>>>> Am 24.02.2010 14:13, schrieb Philippe Gerum:
>>>>> On Wed, 2010-02-24 at 14:11 +0100, Philippe Gerum wrote:
>>>>>> On Wed, 2010-02-24 at 14:06 +0100, Stefan Kisdaroczi wrote:
>>>>>>> Hi Philippe,
>>>>>>>
>>>>>>> Am 23.02.2010 18:46, schrieb Philippe Gerum:
>>>>>>>> On Tue, 2010-02-23 at 17:52 +0100, Stefan Kisdaroczi wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Am 14.02.2010 10:38, schrieb Philippe Gerum:
>>>>>>>>>>
>>>>>>>>>> <snip>
>>>>>>>>>> In the future, maybe we could simply provide a wrapper script =
accepting
>>>>>>>>>> sub-commands, such as "xeno latency, xeno sigtest" etc, to be =
put
>>>>>>>>>> into /usr/bin by distros, which would hide the actual location=
 of those
>>>>>>>>>> binaries?
>>>>>>>>>>
>>>>>>>>>> In any case, thanks for your work so far. We probably need to =
discuss
>>>>>>>>>> the packaging issues on this list, so that we get both consist=
ency and
>>>>>>>>>> usability in the future.
>>>>>>>>>>
>>>>>>>>>> Gilles and Roland, if this is fine with you, I'll handle the l=
iaison
>>>>>>>>>> role with upstream packagers, so please CC me explicitly on th=
ose mails.
>>>>>>>>>> We'll sort out this issue, it doesn't look that bad anyway.
>>>>>>>>>
>>>>>>>>> Roland added a xeno wrapper to the debian.org xenomai package 2=
=2E5.1-3.
>>>>>>>>>
>>>>>>>>> I synced now the debian/ directories from debian.org and xenoma=
i.org:
>>>>>>>>>  - For debian.org I sent patches to the Debian bugtracker [1] [=
2].
>>>>>>>>>    Another patch for dpkg-cross support [3] I sent to Roland pr=
ivately.
>>>>>>>>>  - For xenomai.org I attached patches to this mail (against -2.=
5.git).
>>>>>>>>>
>>>>>>>>> If both parties apply the patches the debian directories are in=
 sync,
>>>>>>>>> except some minor differences in the debian/control file, see p=
atch
>>>>>>>>> do-not-commit-please.patch. I would like to keep these changes =
out so
>>>>>>>>> that the xenomai.org packages are compatible with Debian 5.0 Le=
nny.
>>>>>>>>> The debian.org packages are for Debian 6.0 Squeeze.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Merged into my queue (except the last one as mentioned). This wi=
ll be
>>>>>>>> pushed upstream to Gilles for 2.5.2. Thanks.
>>>>>>>
>>>>>>> I took a look at your branch for-upstream. Your commit
>>>>>>>   scripts: add wrapper script to run standard Xenomai commands
>>>>>>>   6e0574791f48cbf8b3421a68c5789254e7d084b7
>>>>>>> adds the same wrapper as my patch 0005-debian-wrapper-script-usr-=
bin-xeno-to-call-executa.patch
>>>>>>>   debian: wrapper script /usr/bin/xeno to call executables in /us=
r/lib/xenomai/
>>>>>>>   fbe86cc50d3a65cd23e93d43adba4ed369fe70b1
>>>>>>> Please revert the commit of my patch, we need another fix for deb=
ian/rules for "your" wrapper.
>>>>>>>
>>>>>>
>>>>>> Ok, I thought your patch set was based on my tree, so I did not ch=
eck
>>>>>> thoroughly. I did not send any pull request to Gilles, so no harm =
done.
>>>>>>
>>>>>>> How do I call configure to install the wrapper in /usr/bin and
>>>>>>> the programs like latency, switchtest etc. to /usr/lib/xenomai ?
>>>>>>>
>>>>>>
>>>>>> We need some fixage in scripts/wrappers/Makefile.am to do that. I'=
ll
>>>>>> prepare this asap.
>>>>>
>>>>> scripts/Makefile.am...
>>>>
>>>> Hi Philippe,
>>>>
>>>> I just tried the --with-testdir switch. It worked, but i'm not reall=
y sure if
>>>> this is the right track.
>>>>
>>>> Roland's packages install all binaries to /usr/lib/xenomai, except x=
eno and
>>>> xeno-config. You state in your commit message more or less the same =
goal:
>>>> "At some point, all remaining executables or scripts left under $pre=
fix/bin should match
>>>> xeno*, to further reduce the odds of causing name collisions."
>>>>
>>>> Using --with-testdir all tests (latency,switchtest,...) are now in /=
usr/lib/xenomai.
>>>> To install the "utils" (rtcansend,insn_write,insn_write,cmd_read,...=
) to the same
>>>> directory using --with-testdir sounds not obviously. You could add a=
 second switch
>>>> --with-utildir, but a second dir will not work for the xeno-wrapper-=
script.
>>>>
>>>
>>> CAN and other utilities should definitely remain in $bindir. The fact=

>>> that they are not prefixed by xeno* is another thing; CAN utilities a=
re
>>> already prefixed, maybe Analogy ones should be named in a bit less
>>> generic way, although they are not raising any conflict today. I wrot=
e
>>> that what's under $bindir "should" match xeno* when a risk of collisi=
on
>>> exists, but there is no point in enforcing a stricter rule at this
>>> point. In any case, I don't want to enforce a never-in-bindir rule fo=
r
>>> all Xenomai binaries, we can still pick their names in a way that avo=
ids
>>> obvious issues.
>>>
>>> The real problem was about tests, for which using rather generic name=
s
>>> made sense. This is what that patch is for.
>>
>> ok, got the goal now, thanks for the explanation.
>> But "xeno.in" needs a fix to use @XENO_TEST_DIR@, no?
>>
>=20
> Yes, I overlooked that. In fact, I think we may not even need the new
> xeno wrapper at all, but we probably want to rewrite xeno-test to wrap
> to what is in XENO_TEST_DIR now.
>=20
> I would suggest to hold the changes to the debian/ area for now, until

Agree with holding back wrapper-changes, but please consider the attached=
 patch
with small fixes, thanks. (against rpm/for-upstream)

> the dust has settled a bit. We are trying to fix long-standing problems=

> in the way we allow people to test their setup.=20
>=20
>>>> I think something like using --bindir=3D/usr/lib/xenomai and --wrapp=
erdir=3D/usr/bin
>>>> is probably better, as there are less exceptions.
>>>>
>>>> For the test I patched xeno.in: exec @XENO_TEST_DIR@/$@
>>
>>
>>>>
>>>> Stefan
>>>>
>>>>>>
>>>>>>> Stefan
>>>>>>>
>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>> kisda
>>>>>>>>>
>>>>>>>>> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D571099
>>>>>>>>> [2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D571104
>>>>>>>>> [3] http://git.xenomai.org/?p=3Dxenomai-2.5.git;a=3Dcommitdiff;=
h=3D5bcd18f714f4cbeaaac0cc4a08e6c9f375aa3b77
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>
>>
>=20
>=20


--------------020209060204040507090604
Content-Type: text/plain;
 name="0001-debian-fix-package-libxenomai1.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-debian-fix-package-libxenomai1.patch"

RnJvbSBhNzMwZTk1ZWNhMTQ2ZTk0NGUzNzZlMGQyOGJjZmE1MzZkZDZhMDYyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmYW4gS2lzZGFyb2N6aSA8a2lzZGFAaGlzcGVl
ZC5jaD4KRGF0ZTogV2VkLCAzIE1hciAyMDEwIDE3OjE3OjM1ICswMTAwClN1YmplY3Q6IFtQ
QVRDSF0gZGViaWFuOiBmaXggcGFja2FnZSBsaWJ4ZW5vbWFpMQoKLS0tCiBkZWJpYW4vY2hh
bmdlbG9nICAgICAgICAgICB8ICAgIDkgKysrKysrKysrCiBkZWJpYW4vbGlieGVub21haTEu
ZGlycyAgICB8ICAgIDIgKy0KIGRlYmlhbi9saWJ4ZW5vbWFpMS5saW50aWFuIHwgICAgMiAr
LQogZGViaWFuL3J1bGVzICAgICAgICAgICAgICAgfCAgICA2ICsrKy0tLQogNCBmaWxlcyBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RlYmlhbi9jaGFuZ2Vsb2cgYi9kZWJpYW4vY2hhbmdlbG9nCmluZGV4IDQ1NzM2YTQuLjZk
MmQzY2YgMTAwNjQ0Ci0tLSBhL2RlYmlhbi9jaGFuZ2Vsb2cKKysrIGIvZGViaWFuL2NoYW5n
ZWxvZwpAQCAtMSwzICsxLDEyIEBACit4ZW5vbWFpICgyLjUuMS00KSB1bnN0YWJsZTsgdXJn
ZW5jeT1sb3cKKworICAqIEFkZGVkIHBhdGNoZXMgYnkgU3RlZmFuIEtpc2Rhcm9jemkgPGtp
c2RhQGhpc3BlZWQuY2g+OgorICAgIC0gZGViaWFuL2NvcHlyaWdodDogVHlwbyBhbmQgZW1h
aWwgYWRkcmVzcyAoQ2xvc2VzOiAjNTcxMDk5KQorICAgIC0gZGViaWFuL2NvbnRyb2w6IGlh
NjQgc3VwcG9ydCByZW1vdmVkIChDbG9zZXM6ICM1NzExMDQpCisgICAgLSBkZWJpYW4vcnVs
ZXM6IEFkZGVkIGRwa2ctY3Jvc3Mgc3VwcG9ydAorCisgLS0gUm9sYW5kIFN0aWdnZSA8c3Rp
Z2dlQGFudGNvbS5kZT4gIFdlZCwgMjQgRmViIDIwMTAgMjI6MjA6MTAgKzAxMDAKKwogeGVu
b21haSAoMi41LjEtMykgdW5zdGFibGU7IHVyZ2VuY3k9bG93CiAKICAgKiB4ZW5vbWFpLXJ1
bnRpbWU6IFJlcGxhY2VkICJ4ZW5vbWFpLSIgcHJlZml4ZWQgZXhlY3V0YWJsZXMgd2l0aApk
aWZmIC0tZ2l0IGEvZGViaWFuL2xpYnhlbm9tYWkxLmRpcnMgYi9kZWJpYW4vbGlieGVub21h
aTEuZGlycwppbmRleCBkNWJiMzRmLi4xNzM3ZWExIDEwMDY0NAotLS0gYS9kZWJpYW4vbGli
eGVub21haTEuZGlycworKysgYi9kZWJpYW4vbGlieGVub21haTEuZGlycwpAQCAtMSwyICsx
LDIgQEAKLWV0Yy91ZGV2CitldGMvdWRldi9ydWxlcy5kCiB1c3Ivc2hhcmUvbGludGlhbi9v
dmVycmlkZXMKZGlmZiAtLWdpdCBhL2RlYmlhbi9saWJ4ZW5vbWFpMS5saW50aWFuIGIvZGVi
aWFuL2xpYnhlbm9tYWkxLmxpbnRpYW4KaW5kZXggMGY2YTUxNC4uZmUwZGE0NiAxMDA2NDQK
LS0tIGEvZGViaWFuL2xpYnhlbm9tYWkxLmxpbnRpYW4KKysrIGIvZGViaWFuL2xpYnhlbm9t
YWkxLmxpbnRpYW4KQEAgLTEsMiArMSwyIEBACiAjIG5vIGNvbnRhaW5lZCBzaGFyZWQgbGli
cmFyeSBuYW1lcyByZWZlciB0byAieGVub21haSIsIHRoZXJlZm9yZSBvd24gbmFtZQotbGli
eGVub21haTE6IHBhY2thZ2UtbmFtZS1kb2VzbnQtbWF0Y2gtc29uYW1lcyBsaWJhbmFsb2d5
MSBsaWJuYXRpdmUzIGxpYnBzb3MwIGxpYnB0aHJlYWQtcnQxIGxpYnJ0YWkwIGxpYnJ0ZGsw
IGxpYnJ0ZG0xIGxpYnVpdHJvbjAgbGlidnJ0eDAgbGlidnh3b3JrczEKK2xpYnhlbm9tYWkx
OiBwYWNrYWdlLW5hbWUtZG9lc250LW1hdGNoLXNvbmFtZXMgbGliYW5hbG9neTEgbGlibmF0
aXZlMyBsaWJwc29zMCBsaWJwdGhyZWFkLXJ0MSBsaWJydGFpMCBsaWJydGRrMCBsaWJydGRt
MSBsaWJ1aXRyb24wIGxpYnZydHgwIGxpYnZ4d29ya3MxIGxpYnhlbm9tYWkwCmRpZmYgLS1n
aXQgYS9kZWJpYW4vcnVsZXMgYi9kZWJpYW4vcnVsZXMKaW5kZXggZmE5M2Y2Mi4uYTUzODgw
MCAxMDA3NTUKLS0tIGEvZGViaWFuL3J1bGVzCisrKyBiL2RlYmlhbi9ydWxlcwpAQCAtODcs
NyArODcsNyBAQCBjbGVhbjoKIGluc3RhbGw6IGJ1aWxkCiAJZGhfdGVzdGRpcgogCWRoX3Rl
c3Ryb290Ci0JZGhfY2xlYW4gLWsKKwlkaF9wcmVwCiAJZGhfaW5zdGFsbGRpcnMKIAkkKE1B
S0UpIGluc3RhbGwgREVTVERJUj0kKENVUkRJUikvZGViaWFuL3RtcC8KIAlkaF9pbnN0YWxs
IC0tc291cmNlZGlyPSQoQ1VSRElSKS9kZWJpYW4vdG1wCkBAIC0xMDgsOCArMTA4LDggQEAg
YmluYXJ5LWluZGVwOiBidWlsZCBpbnN0YWxsCiAJZGhfdGVzdGRpciAtaQogCWRoX3Rlc3Ry
b290IC1pCiAJZGhfaW5zdGFsbGRvY3MgLWkgLUEgQ1JFRElUUyBSRUFETUUuSU5TVEFMTCBU
Uk9VQkxFU0hPT1RJTkcKLQlkaF9pbnN0YWxsY2hhbmdlbG9ncyAtaQogCWRoX2xpbmsgLWkK
KwlkaF9pbnN0YWxsY2hhbmdlbG9ncyAtaQogCWRoX3N0cmlwIC1pCiAJZGhfY29tcHJlc3Mg
LWkgLVgucGRmCiAJZGhfZml4cGVybXMgLWkKQEAgLTEzMSw4ICsxMzEsOCBAQCBiaW5hcnkt
YXJjaDogYnVpbGQgaW5zdGFsbAogCWRoX3Rlc3Ryb290IC1zCiAJZGhfaW5zdGFsbG1hbiAt
cwogCWRoX2luc3RhbGxkb2NzIC1zIC1BIENSRURJVFMgUkVBRE1FLklOU1RBTEwgVFJPVUJM
RVNIT09USU5HCi0JZGhfaW5zdGFsbGNoYW5nZWxvZ3MgLXMKIAlkaF9saW5rIC1zCisJZGhf
aW5zdGFsbGNoYW5nZWxvZ3MgLXMKIAlkaF9zdHJpcCAtcwogCWRoX2NvbXByZXNzIC1zCiAJ
ZGhfZml4cGVybXMgLXMKLS0gCjEuNS42LjUKCg==
--------------020209060204040507090604--

--------------enig2A82031784EC942C25A9C3B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLjpQ9IPTw9rIdn6oRAgtnAJ9zx5T48/tS2rTHAjVr7TEOV6GrhQCfVPeA
f4d0Fc1w6T9XiCbpTJqlK10=
=R/+i
-----END PGP SIGNATURE-----

--------------enig2A82031784EC942C25A9C3B8--

