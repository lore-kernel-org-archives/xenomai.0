MIME-Version: 1.0
In-Reply-To: <1139048827.8910394.1519833759993.JavaMail.zimbra@triolcorp.com.ua>
References: <500456767.8825156.1519827180703.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8SHXBKVFyzgkpxS-ecpzPVtEDwGqbzdxXwnwUG+Fn0pRA@mail.gmail.com>
 <429130936.8886425.1519831182179.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8Qa8y1idWvPfA2PBuG_urrgjDuYYX8B7_65yyEQswUvdg@mail.gmail.com>
 <1139048827.8910394.1519833759993.JavaMail.zimbra@triolcorp.com.ua>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 28 Feb 2018 11:37:49 -0500
Message-ID: <CALLqZ8S6_-dWvze2+MsBxNBvhS3UCtERLZ=VwqmkN3C9Rw6s1A@mail.gmail.com>
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
To: =?UTF-8?B?0KjQtdCy0YfQtdC90LrQviDQotCw0YDQsNGBINCT0YDQuNCz0L7RgNGM0LXQstC40Yc=?= <shevchenko.taras@triolcorp.com.ua>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Please use reply all when responding or the rest of the list won't get
the benefit of the question or have the chance to help answer.

Have you built Xenomai from source?  It looks like you are pointing to
the modules only, I believe it needs the patched kernel source.

-Greg

On Wed, Feb 28, 2018 at 11:02 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=
=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=
=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<shevchenko.taras@triolcorp.com.ua> wrote:
> Thank for your reply
>
> I try  follow instruction  https://xenomai.org//rtnet-installation/
>
>
> after make menuconfig and set options
>
>     Variant=E2=86=92Xenomai 2.1
>     Add-ons=E2=86=92Real-time Capturing Support=E2=86=92ON
>     Examples=E2=86=92RTnet Application Examples=E2=86=92ON
> I  get
>
> .....
>
> checking for RTnet Kconfig file... .rtnet_config (supplied)
> checking for RT-extension... configure: error: *** RT-extended kernel not=
 found in /lib/modules/4.9.38-xenomai-3.0.5/build
> makefile:51: recipe for target 'config.status' failed
> make: *** [config.status] Error 1
>
>
> this folder and path exist
>
> [*] RTnet Application Examples       =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82()    Real-time Extension Config-Tool Path (NEW)    =
which path  should I write here ?
>
>
>
>
>
>
>
>
>
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=B8 =D0=
=BD=D0=B0=D0=B4=D0=B5=D0=B6=D0=B4=D0=BE=D0=B9 =D0=BD=D0=B0 =D1=81=D0=BE=D1=
=82=D1=80=D1=83=D0=B4=D0=BD=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=BE,
> =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2.=D0=93.
>
> ----- Original Message -----
> From: "Greg Gallagher" <greg@embeddedgreg.com>
> To: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2=D0=B0=D1=80=
=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=
=D1=87" <shevchenko.taras@triolcorp.com.ua>, "xenomai" <xenomai@xenomai.org=
>
> Sent: Wednesday, February 28, 2018 5:33:25 PM
> Subject: Re: [Xenomai] RTnet
>
> Posting back to the list.  RtNet can be used with Xenomai-3, there's
> been some recent discussion on how to do this.  You should look back
> through the archive and see if those messages help and then if they
> don't post back with a specific question.
>
> On Wed, Feb 28, 2018 at 10:19 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=
=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=
=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
> <shevchenko.taras@triolcorp.com.ua> wrote:
>> But  is it possible to use  Xenomai 3  with RTnet ?
>> Could you point me right way to do it ?
>>
>> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=B8 =D0=
=BD=D0=B0=D0=B4=D0=B5=D0=B6=D0=B4=D0=BE=D0=B9 =D0=BD=D0=B0 =D1=81=D0=BE=D1=
=82=D1=80=D1=83=D0=B4=D0=BD=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=BE,
>> =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2.=D0=93.
>>
>> ----- Original Message -----
>> From: "Greg Gallagher" <greg@embeddedgreg.com>
>> To: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2=D0=B0=D1=80=
=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=
=D1=87" <shevchenko.taras@triolcorp.com.ua>
>> Cc: "xenomai" <xenomai@xenomai.org>
>> Sent: Wednesday, February 28, 2018 5:01:23 PM
>> Subject: Re: [Xenomai] RTnet
>>
>> It looks like Xenomai 3.05 is not supported with the instructions you
>> are following.
>>
>> -Greg
>>
>> On Wed, Feb 28, 2018 at 9:13 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=
=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=
=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
>> <shevchenko.taras@triolcorp.com.ua> wrote:
>>>
>>> Hi!
>>>
>>> I do it first time and followed http://rtt-lwr.readthedocs.io/en/latest=
/rtpc/rtnet.html
>>>
>>> I tried to install rtnet and get some error
>>> taras@prog-pc12:~/RTnet$ sudo make menuconfig
>>> make[1]: Entering directory '/home/taras/RTnet/scripts/kconfig'
>>> #
>>> # using defaults found in ../../.rtnet_config
>>> #
>>>
>>>
>>> *** End of RTnet configuration.
>>> *** Execute 'make' to build RTnet or try 'make help'.
>>>
>>> make[1]: Leaving directory '/home/taras/RTnet/scripts/kconfig'
>>> /bin/sh: 3: /home/taras/RTnet/configure: not found
>>> makefile:51: recipe for target 'config.status' failed
>>> make: *** [config.status] Error 1
>>>
>>>
>>>
>>> or if i do  ./configure    a get
>>> checking for main in -lncurses... yes
>>> checking for RTnet Kconfig file... ./defconfig (default)
>>>
>>> checking for RT-extension... /usr/xenomai (Xenomai 2.0.x)
>>> checking for Xenomai version... configure: error: *** Unsupported Xenom=
ai version 3.0.5 in /usr/xenomai
>>> taras@prog-pc12:~/RTnet$
>>>
>>> What s wrong ? Please help/
>>>
>>> some outputs
>>>
>>> taras@prog-pc12:/usr/xenomai/bin$ ./xeno-config --info|grep -i build
>>> Build args: --with-pic --with-core=3Dcobalt --enable-smp --disable-tls =
--enable-dlopen-libs --disable-clock-monotonic-raw
>>>
>>> taras@prog-pc12:/usr/xenomai/bin$ cd /usr/xenomai/sbin/
>>> taras@prog-pc12:/usr/xenomai/sbin$ ./version
>>> Xenomai/cobalt v3.0.5
>>>
>>> taras@prog-pc12:/usr/xenomai/sbin$ uname -r
>>> 4.9.38-xenomai-3.0.5
>>>
>>>
>>>
>>> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=B8 =
=D0=BD=D0=B0=D0=B4=D0=B5=D0=B6=D0=B4=D0=BE=D0=B9 =D0=BD=D0=B0 =D1=81=D0=BE=
=D1=82=D1=80=D1=83=D0=B4=D0=BD=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=BE,
>>> =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2.=D0=93.
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> https://xenomai.org/mailman/listinfo/xenomai

