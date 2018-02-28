MIME-Version: 1.0
In-Reply-To: <500456767.8825156.1519827180703.JavaMail.zimbra@triolcorp.com.ua>
References: <500456767.8825156.1519827180703.JavaMail.zimbra@triolcorp.com.ua>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 28 Feb 2018 10:01:23 -0500
Message-ID: <CALLqZ8SHXBKVFyzgkpxS-ecpzPVtEDwGqbzdxXwnwUG+Fn0pRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?0KjQtdCy0YfQtdC90LrQviDQotCw0YDQsNGBINCT0YDQuNCz0L7RgNGM0LXQstC40Yc=?= <shevchenko.taras@triolcorp.com.ua>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

It looks like Xenomai 3.05 is not supported with the instructions you
are following.

-Greg

On Wed, Feb 28, 2018 at 9:13 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=
=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=
=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<shevchenko.taras@triolcorp.com.ua> wrote:
>
> Hi!
>
> I do it first time and followed http://rtt-lwr.readthedocs.io/en/latest/r=
tpc/rtnet.html
>
> I tried to install rtnet and get some error
> taras@prog-pc12:~/RTnet$ sudo make menuconfig
> make[1]: Entering directory '/home/taras/RTnet/scripts/kconfig'
> #
> # using defaults found in ../../.rtnet_config
> #
>
>
> *** End of RTnet configuration.
> *** Execute 'make' to build RTnet or try 'make help'.
>
> make[1]: Leaving directory '/home/taras/RTnet/scripts/kconfig'
> /bin/sh: 3: /home/taras/RTnet/configure: not found
> makefile:51: recipe for target 'config.status' failed
> make: *** [config.status] Error 1
>
>
>
> or if i do  ./configure    a get
> checking for main in -lncurses... yes
> checking for RTnet Kconfig file... ./defconfig (default)
>
> checking for RT-extension... /usr/xenomai (Xenomai 2.0.x)
> checking for Xenomai version... configure: error: *** Unsupported Xenomai=
 version 3.0.5 in /usr/xenomai
> taras@prog-pc12:~/RTnet$
>
> What s wrong ? Please help/
>
> some outputs
>
> taras@prog-pc12:/usr/xenomai/bin$ ./xeno-config --info|grep -i build
> Build args: --with-pic --with-core=3Dcobalt --enable-smp --disable-tls --=
enable-dlopen-libs --disable-clock-monotonic-raw
>
> taras@prog-pc12:/usr/xenomai/bin$ cd /usr/xenomai/sbin/
> taras@prog-pc12:/usr/xenomai/sbin$ ./version
> Xenomai/cobalt v3.0.5
>
> taras@prog-pc12:/usr/xenomai/sbin$ uname -r
> 4.9.38-xenomai-3.0.5
>
>
>
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=B8 =D0=
=BD=D0=B0=D0=B4=D0=B5=D0=B6=D0=B4=D0=BE=D0=B9 =D0=BD=D0=B0 =D1=81=D0=BE=D1=
=82=D1=80=D1=83=D0=B4=D0=BD=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=BE,
> =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2.=D0=93.
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

