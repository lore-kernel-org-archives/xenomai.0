MIME-Version: 1.0
In-Reply-To: <b4e4e9f0-7ea7-632a-8c76-fde0876bb819@xenomai.org>
References: <CALC3Xwp-pSsQ+hF6bZFyT7BCrTOE2o0G4A3_hgD7o4i=9hdO7Q@mail.gmail.com>
 <8ddcffac-78ab-3933-f5bf-1352f1af6a1d@xenomai.org>
 <CALC3Xwp0soSABRS12_3V8OEfNY_18eR5mB_qZqR9MTsdfq5WMA@mail.gmail.com>
 <CALC3XwoXJ2f6btgkOt2nJ4z1KGf=bB4g=0bE6w7jZfQD42jkRA@mail.gmail.com>
 <CALC3XwoytMPBagjtb8eHd7HxVmbqPE4ck1woX8sWNwR_rXfz5A@mail.gmail.com>
 <da41a276-60bc-7672-947d-2aa931c79606@xenomai.org>
 <CALC3XwrU04LeWBCWnuaHhEfgwakMeXAJ2OkRi+LgmUEdP5zPqQ@mail.gmail.com>
 <b4e4e9f0-7ea7-632a-8c76-fde0876bb819@xenomai.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Le_Floc=27h?= <le.floch.aurelien94@gmail.com>
Date: Mon, 15 May 2017 14:12:25 +0200
Message-ID: <CALC3Xwqnw1BzNZFyR8QEu02sfN64bejkRWeq5PyVu1+Ly7nGbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Fwd: Problem with the priority of the task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is the output of xeno-config --info

Xenomai version: 3.0.4
Cobalt core is NOT present on this system
Compiler: gcc version 5.4.0 (Buildroot 2017.05-rc1)
Build args: --target=3Darm-buildroot-linux-uclibcgnueabihf
--host=3Darm-buildroot-linux-uclibcgnueabihf --build=3Dx86_64-pc-linux-gnu
--prefix=3D/usr --exec-prefix=3D/usr --sysconfdir=3D/etc
--localstatedir=3D/var --program-prefix=3D --disable-gtk-doc
--disable-gtk-doc-html --disable-doc --disable-docs
--disable-documentation --with-xmlto=3Dno --with-fop=3Dno
--disable-dependency-tracking --enable-ipv6 --disable-nls
--disable-static --enable-shared --includedir=3D/usr/include/xenomai/
--disable-doc-install --with-core=3Dcobalt --enable-smp
--disable-registry build_alias=3Dx86_64-pc-linux-gnu
host_alias=3Darm-buildroot-linux-uclibcgnueabihf
target_alias=3Darm-buildroot-linux-uclibcgnueabihf
CC=3D/home/aulef/Documents/Xenomai3/buildroot-2017.05-rc1/output/host/usr/b=
in/arm-buildroot-linux-uclibcgnueabihf-gcc
CFLAGS=3D-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
-D_FILE_OFFSET_BITS=3D64  -Os  LDFLAGS=3D CPPFLAGS=3D-D_LARGEFILE_SOURCE
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64
CPP=3D/home/aulef/Documents/Xenomai3/buildroot-2017.05-rc1/output/host/usr/=
bin/arm-buildroot-linux-uclibcgnueabihf-cpp
PKG_CONFIG=3D/home/aulef/Documents/Xenomai3/buildroot-2017.05-rc1/output/ho=
st/usr/bin/pkg-config

This is a Xenomai 3 version create with Buildroot on my Raspberry Pi B+.
Do you have any suggestions ?

I try another package to build Xenomai 3 for Raspberry Pi but this
package gives me the same output.

Xenomai version: 3.0.3
Cobalt core is NOT present on this system
Compiler: gcc version 4.9.4 (Buildroot 2016.08)
Build args: --target=3Darm-buildroot-linux-uclibcgnueabihf
--host=3Darm-buildroot-linux-uclibcgnueabihf --build=3Dx86_64-pc-linux-gnu
--prefix=3D/usr --exec-prefix=3D/usr --sysconfdir=3D/etc
--localstatedir=3D/var --program-prefix=3D --disable-gtk-doc
--disable-gtk-doc-html --disable-doc --disable-docs
--disable-documentation --with-xmlto=3Dno --with-fop=3Dno
--disable-dependency-tracking --enable-ipv6 --disable-nls
--disable-static --enable-shared --with-core=3Dcobalt
--includedir=3D/usr/include/xenomai/ --disable-doc-install
--enable-lores-clock build_alias=3Dx86_64-pc-linux-gnu
host_alias=3Darm-buildroot-linux-uclibcgnueabihf
target_alias=3Darm-buildroot-linux-uclibcgnueabihf
CC=3D/home/aulef/Documents/Xenomai_BR_3/buildroot-2016.08/output/host/usr/b=
in/arm-buildroot-linux-uclibcgnueabihf-gcc
CFLAGS=3D-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
-D_FILE_OFFSET_BITS=3D64  -Os  LDFLAGS=3D CPPFLAGS=3D-D_LARGEFILE_SOURCE
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64
CPP=3D/home/aulef/Documents/Xenomai_BR_3/buildroot-2016.08/output/host/usr/=
bin/arm-buildroot-linux-uclibcgnueabihf-cpp
PKG_CONFIG=3D/home/aulef/Documents/Xenomai_BR_3/buildroot-2016.08/output/ho=
st/usr/bin/pkg-config

2017-05-15 12:29 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:
> On 05/15/2017 11:37 AM, Aur=C3=A9lien Le Floc'h wrote:
>> Thanks for your answer.
>> I stock the output result in a string but the results are exactly the
>> same. I attached my code.
>> Do you have an idea to solve this problem ?
>>
>
> xeno-config --info would help.
>
> --
> Philippe.

