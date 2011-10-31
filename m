MIME-Version: 1.0
In-Reply-To: <4EAE9EDE.5030501@domain.hid>
References: <CAAeYjM=7aZPLifemq7v2QUzr9HxkU=GxDNFbxH6G+R6z2kQMUA@mail.gmail.com>
	<CAAeYjMkmDOLgEdGYPBmyWSPOCaOqWhnC+exeAg6ERzhp8uWkdg@domain.hid>
	<CAAeYjMn83FgbqTZRB7E_S4FHP11V-tzdP1eNcY6+n2DJ2SmrGw@domain.hid>
	<4EAE9EDE.5030501@domain.hid>
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Mon, 31 Oct 2011 14:23:13 +0100
Message-ID: <CAAeYjMnGFw8GZEkb_qUoa_wxoCzmNLa=+E_bfZESuQ9TPS8_nw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] configuring user-space xenomai 2.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I used the toolchain from codesourcery
(http://www.codesourcery.com/sgpp/lite/arm/portal/package3696/public/arm-no=
ne-linux-gnueabi/arm-2008q3-72-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar=
.bz2).
The one downloaded from the ubuntu repos behaves the same way.
--
=C5=81ukasz Dragilla Sacha



On Mon, Oct 31, 2011 at 14:13, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 10/31/2011 01:52 PM, =C5=81ukasz Sacha wrote:
>> This is the line configure generated to test whether compiler works:
>> arm-none-linux-gnueabi-gcc =E2=80=93march=3Darmv4t =E2=80=93mtune=3Darm9=
20t -o conftest
>> -march=3Darmv4t -march=3Darmv4t conftest.c
>> (notice tripple =C2=A0-march=3Darmv4t)
>>
>> when I execute it it gives me:
>> arm-none-linux-gnueabi-gcc: =E2=80=93march=3Darmv4t: No such file or dir=
ectory
>> arm-none-linux-gnueabi-gcc: =E2=80=93mtune=3Darm920t: No such file or di=
rectory
>> arm-none-linux-gnueabi-gcc: conftest.c: No such file or directory
>> arm-none-linux-gnueabi-gcc: no input files
>>
>> However with a single =C2=A0-march=3Darmv4t it doesn't work either.
>> luke@domain.hid$
>> arm-none-linux-gnueabi-gcc -march=3Darmv4t =E2=80=93mtune=3Darm920t -o c=
onftest
>> conftest.c
>> arm-none-linux-gnueabi-gcc: =E2=80=93mtune=3Darm920t: No such file or di=
rectory
>> arm-none-linux-gnueabi-gcc: conftest.c: No such file or directory
>> arm-none-linux-gnueabi-gcc: no input files
>>
>> .. which is strange, because arm-none-linux-gnueabi-gcc --help tells
>> me all the options are ok:
>> "Options starting with -g, -f, -m, -O, -W, or --param are automatically
>> =C2=A0passed on to the various sub-processes invoked by arm-none-linux-g=
nueabi-gcc."
>>
>> Seems -mtune is not recognized by some subprocess, but which and why?
>>
>> cheers :)
>
> Strange toolchain. I use codesourcery toolchain and never observed such
> behaviour. You should make sure the toolchain you use works before
> trying and compiling xenomai.
>
> --
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Gilles.
>
>

