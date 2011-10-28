Message-ID: <4EAA8610.1080304@domain.hid>
Date: Fri, 28 Oct 2011 12:38:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <ba98230140e2190e763c418428e3198d.squirrel@domain.hid>
	<4EA9B774.1020401@domain.hid>
	<40ce31e8.8bebe60.4eaa7e05.4437d@domain.hid>
In-Reply-To: <40ce31e8.8bebe60.4eaa7e05.4437d@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] installing xenomai on pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert <robert-km@domain.hid>
Cc: xenomai@xenomai.org

On 10/28/2011 12:03 PM, Robert wrote:
> Dnia 27 pa=C5=BAdziernika 2011 21:56 Gilles Chanteperdrix <gilles.chant=
eperdrix@domain.hid> napisa=C5=82(a):
>=20
>> On 10/27/2011 11:05 AM, Gilles Chanteperdrix wrote:
>>>
>>>
>>> Robert wrote:
>>>> Ok, so now latency test looks good, but board still hangs up on xeno=
-test.
>>>>
>>>
>>> Please try, as I suggested in a previous mail, to get the kernel cons=
ole
>>> output on the serial port, and see if the hang is not due to a kernel=

>>> oops.
>>>
>>> And I am also asking again: are you compiling user-space support for =
thumb?
>>>
>>
>> Hi Robert,
>>
>> I tried the same configuration as you. As expected, the bug is a oops,=

>> and the serial console helped. The problem is CONFIG_CC_STACKPROTECTOR=
,
>> it is currently not implemented for xenomai on ARM.
>>
>> This configuration will cause a compilation error in the next release.=

>>
>> Regards.
>=20
> This is part of my config.log:
> =20
> Configured with: ../src/configure -v --with-pkgversion=3D'Ubuntu/Linaro=
 4.5.2-8ubu
> ntu4' --with-bugurl=3Dfile:///usr/share/doc/gcc-4.5/README.Bugs --enabl=
e-languages
> =3Dc,c++,fortran,objc,obj-c++ --prefix=3D/usr --program-suffix=3D-4.5 -=
-enable-shared
> --enable-multiarch --with-multiarch-defaults=3Darm-linux-gnueabi --enab=
le-linker-b
> uild-id --with-system-zlib --libexecdir=3D/usr/lib/arm-linux-gnueabi --=
without-inc
> luded-gettext --enable-threads=3Dposix --with-gxx-include-dir=3D/usr/in=
clude/c++/4.5
>  --libdir=3D/usr/lib/arm-linux-gnueabi --enable-nls --with-sysroot=3D/ =
--enable-cloc
> ale=3Dgnu --enable-libstdcxx-debug --enable-libstdcxx-time=3Dyes --enab=
le-plugin --e
> nable-gold --enable-ld=3Ddefault --with-plugin-ld=3Dld.gold --enable-ob=
jc-gc --disab
> le-sjlj-exceptions --with-arch=3Darmv7-a --with-float=3Dsoftfp --with-f=
pu=3Dvfpv3-d16
> --with-mode=3Dthumb --disable-werror --enable-checking=3Drelease --buil=
d=3Darm-linux-g
> nueabi --host=3Darm-linux-gnueabi --target=3Darm-linux-gnueabi
>=20
>=20
> So should I disable CONFIG_CC_STACKPROTECTOR in my .config file?

Yes.

>=20
> On console I didn't get anything.

Even on serial console?


--=20
                                                                Gilles.


