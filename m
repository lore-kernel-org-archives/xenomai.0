MIME-Version: 1.0
In-Reply-To: <CAAeYjMkmDOLgEdGYPBmyWSPOCaOqWhnC+exeAg6ERzhp8uWkdg@domain.hid>
References: <CAAeYjM=7aZPLifemq7v2QUzr9HxkU=GxDNFbxH6G+R6z2kQMUA@mail.gmail.com>
	<CAAeYjMkmDOLgEdGYPBmyWSPOCaOqWhnC+exeAg6ERzhp8uWkdg@domain.hid>
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Mon, 31 Oct 2011 13:52:38 +0100
Message-ID: <CAAeYjMn83FgbqTZRB7E_S4FHP11V-tzdP1eNcY6+n2DJ2SmrGw@domain.hid>
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

This is the line configure generated to test whether compiler works:
arm-none-linux-gnueabi-gcc =E2=80=93march=3Darmv4t =E2=80=93mtune=3Darm920t=
 -o conftest
-march=3Darmv4t -march=3Darmv4t conftest.c
(notice tripple  -march=3Darmv4t)

when I execute it it gives me:
arm-none-linux-gnueabi-gcc: =E2=80=93march=3Darmv4t: No such file or direct=
ory
arm-none-linux-gnueabi-gcc: =E2=80=93mtune=3Darm920t: No such file or direc=
tory
arm-none-linux-gnueabi-gcc: conftest.c: No such file or directory
arm-none-linux-gnueabi-gcc: no input files

However with a single  -march=3Darmv4t it doesn't work either.
luke@domain.hid$
arm-none-linux-gnueabi-gcc -march=3Darmv4t =E2=80=93mtune=3Darm920t -o conf=
test
conftest.c
arm-none-linux-gnueabi-gcc: =E2=80=93mtune=3Darm920t: No such file or direc=
tory
arm-none-linux-gnueabi-gcc: conftest.c: No such file or directory
arm-none-linux-gnueabi-gcc: no input files

.. which is strange, because arm-none-linux-gnueabi-gcc --help tells
me all the options are ok:
"Options starting with -g, -f, -m, -O, -W, or --param are automatically
 passed on to the various sub-processes invoked by arm-none-linux-gnueabi-g=
cc."

Seems -mtune is not recognized by some subprocess, but which and why?

cheers :)

--
=C5=81ukasz Dragilla Sacha



On Mon, Oct 31, 2011 at 13:35, =C5=81ukasz Sacha <dragilla@domain.hid> wrote=
:
> I think I've identified the problem.
> There might be inconsistency in the script. In the README_INSTALL you
> write to give --host without the ending "-" whereas in the example it
> states to give --host=3Darm-none-linux-gnueabi-
> This is what happens when I write the host without the ending "-".
>
> luke@domain.hid$ ./configure
> CFLAGS=3D"-march=3Darmv4t" LDFLAGS=3D"-march=3Darmv4t"
> --host=3Darm-none-linux-gnueabi --build=3Di686-pc-linux-gnu
> checking build system type... i686-pc-linux-gnu
> checking host system type... arm-none-linux-gnueabi
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for arm-none-linux-gnueabi-gcc... arm-none-linux-gnueabi-gcc
> =E2=80=93march=3Darmv4t =E2=80=93mtune=3Darm920t
> checking whether the C compiler works... no
> configure: error: in `/home/luke/Desktop/moje/mini2440/xenomai-2.6.0-rc5'=
:
> configure: error: C compiler cannot create executables
> See `config.log' for more details
>
> Any ideas?
> --
> =C5=81ukasz Dragilla Sacha
>
>
>
> On Mon, Oct 31, 2011 at 13:14, =C5=81ukasz Sacha <dragilla@domain.hid> wro=
te:
>> Hey,
>>
>> I'm following README_INSTALL from the xenoami 2.6 tree. I successfully
>> patched and built the kernel 2.6.38.8 and modules. Now I'm trying to
>> configure the user-space.
>> I'm running the configure command as given in the example:
>> ./configure CFLAGS=3D"-march=3Darmv4t" LDFLAGS=3D"-march=3Darmv4t"
>> --host=3Darm-none-linux-gnueabi- --build=3Di686-pc-linux-gnu
>> I get the following error:
>> checking build system type... i686-pc-linux-gnu
>> checking host system type... Invalid configuration
>> `arm-none-linux-gnueabi-': machine `arm-none-linux-gnueabi' not
>> recognized
>> configure: error: /bin/bash config/config.sub arm-none-linux-gnueabi- fa=
iled
>>
>> This is how my environment is setup:
>> luke@domain.hid$ which
>> arm-none-linux-gnueabi-gcc
>> /home/luke/Desktop/moje/mini2440/arm-2008q3/bin/arm-none-linux-gnueabi-g=
cc
>> luke@domain.hid$ echo $PATH
>> /home/luke/Desktop/moje/mini2440/arm-2008q3/bin:/usr/lib/lightdm/lightdm=
:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
>>
>> No adequate info in the TROUBLESHOOTING.
>>
>> Am doing something wrong? Help me out please.
>>
>> regards,
>> --
>> =C5=81ukasz Dragilla Sacha
>>
>

