Message-ID: <4B87C8FA.6020802@domain.hid>
Date: Fri, 26 Feb 2010 14:13:30 +0100
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
In-Reply-To: <1267017203.26785.325.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig66894882A34406C5A6154339"
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
--------------enig66894882A34406C5A6154339
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 24.02.2010 14:13, schrieb Philippe Gerum:
> On Wed, 2010-02-24 at 14:11 +0100, Philippe Gerum wrote:
>> On Wed, 2010-02-24 at 14:06 +0100, Stefan Kisdaroczi wrote:
>>> Hi Philippe,
>>>
>>> Am 23.02.2010 18:46, schrieb Philippe Gerum:
>>>> On Tue, 2010-02-23 at 17:52 +0100, Stefan Kisdaroczi wrote:
>>>>> Hi,
>>>>>
>>>>> Am 14.02.2010 10:38, schrieb Philippe Gerum:
>>>>>>
>>>>>> <snip>
>>>>>> In the future, maybe we could simply provide a wrapper script acce=
pting
>>>>>> sub-commands, such as "xeno latency, xeno sigtest" etc, to be put
>>>>>> into /usr/bin by distros, which would hide the actual location of =
those
>>>>>> binaries?
>>>>>>
>>>>>> In any case, thanks for your work so far. We probably need to disc=
uss
>>>>>> the packaging issues on this list, so that we get both consistency=
 and
>>>>>> usability in the future.
>>>>>>
>>>>>> Gilles and Roland, if this is fine with you, I'll handle the liais=
on
>>>>>> role with upstream packagers, so please CC me explicitly on those =
mails.
>>>>>> We'll sort out this issue, it doesn't look that bad anyway.
>>>>>
>>>>> Roland added a xeno wrapper to the debian.org xenomai package 2.5.1=
-3.
>>>>>
>>>>> I synced now the debian/ directories from debian.org and xenomai.or=
g:
>>>>>  - For debian.org I sent patches to the Debian bugtracker [1] [2].
>>>>>    Another patch for dpkg-cross support [3] I sent to Roland privat=
ely.
>>>>>  - For xenomai.org I attached patches to this mail (against -2.5.gi=
t).
>>>>>
>>>>> If both parties apply the patches the debian directories are in syn=
c,
>>>>> except some minor differences in the debian/control file, see patch=

>>>>> do-not-commit-please.patch. I would like to keep these changes out =
so
>>>>> that the xenomai.org packages are compatible with Debian 5.0 Lenny.=

>>>>> The debian.org packages are for Debian 6.0 Squeeze.
>>>>>
>>>>
>>>> Merged into my queue (except the last one as mentioned). This will b=
e
>>>> pushed upstream to Gilles for 2.5.2. Thanks.
>>>
>>> I took a look at your branch for-upstream. Your commit
>>>   scripts: add wrapper script to run standard Xenomai commands
>>>   6e0574791f48cbf8b3421a68c5789254e7d084b7
>>> adds the same wrapper as my patch 0005-debian-wrapper-script-usr-bin-=
xeno-to-call-executa.patch
>>>   debian: wrapper script /usr/bin/xeno to call executables in /usr/li=
b/xenomai/
>>>   fbe86cc50d3a65cd23e93d43adba4ed369fe70b1
>>> Please revert the commit of my patch, we need another fix for debian/=
rules for "your" wrapper.
>>>
>>
>> Ok, I thought your patch set was based on my tree, so I did not check
>> thoroughly. I did not send any pull request to Gilles, so no harm done=
=2E
>>
>>> How do I call configure to install the wrapper in /usr/bin and
>>> the programs like latency, switchtest etc. to /usr/lib/xenomai ?
>>>
>>
>> We need some fixage in scripts/wrappers/Makefile.am to do that. I'll
>> prepare this asap.
>=20
> scripts/Makefile.am...

Hi Philippe,

I just tried the --with-testdir switch. It worked, but i'm not really sur=
e if
this is the right track.

Roland's packages install all binaries to /usr/lib/xenomai, except xeno a=
nd
xeno-config. You state in your commit message more or less the same goal:=

"At some point, all remaining executables or scripts left under $prefix/b=
in should match
xeno*, to further reduce the odds of causing name collisions."

Using --with-testdir all tests (latency,switchtest,...) are now in /usr/l=
ib/xenomai.
To install the "utils" (rtcansend,insn_write,insn_write,cmd_read,...) to =
the same
directory using --with-testdir sounds not obviously. You could add a seco=
nd switch
--with-utildir, but a second dir will not work for the xeno-wrapper-scrip=
t.

I think something like using --bindir=3D/usr/lib/xenomai and --wrapperdir=
=3D/usr/bin
is probably better, as there are less exceptions.

For the test I patched xeno.in: exec @XENO_TEST_DIR@/$@

Stefan

>>
>>> Stefan
>>>
>>>>
>>>>> Thanks
>>>>> kisda
>>>>>
>>>>> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D571099
>>>>> [2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D571104
>>>>> [3] http://git.xenomai.org/?p=3Dxenomai-2.5.git;a=3Dcommitdiff;h=3D=
5bcd18f714f4cbeaaac0cc4a08e6c9f375aa3b77
>>>>
>>>>
>>>
>>>
>>
>>
>=20
>=20



--------------enig66894882A34406C5A6154339
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLh8j/IPTw9rIdn6oRAsGhAJ0WzJInRPRPS+QWsWNRv1OVzgY0cwCfS1wG
3FDtBVAnj/RejP0L6KNzc4Y=
=FYJu
-----END PGP SIGNATURE-----

--------------enig66894882A34406C5A6154339--

