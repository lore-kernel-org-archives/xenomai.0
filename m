MIME-Version: 1.0
In-Reply-To: <440568911.1056302.1524311475119.JavaMail.zimbra@triolcorp.com.ua>
References: <1374825470.13406245.1523973370099.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8Rs-3ux4rCxmXkRbRjQ_5c2MhkXFSLMCr3nfdkNYJKHpg@mail.gmail.com>
 <440568911.1056302.1524311475119.JavaMail.zimbra@triolcorp.com.ua>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 21 Apr 2018 21:19:30 -0400
Message-ID: <CALLqZ8S1EP-_KEaAC4+4pnd=q_5ymFg8uEretz08-hia6tESmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Unknown symbol in module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?0KjQtdCy0YfQtdC90LrQviDQotCw0YDQsNGBINCT0YDQuNCz0L7RgNGM0LXQstC40Yc=?= <shevchenko.taras@triolcorp.com.ua>
Cc: xenomai <xenomai@xenomai.org>

Can you show the output of uname -r and possibly show your boot messages.

On Sat, Apr 21, 2018 at 7:51 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=
=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=
=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<shevchenko.taras@triolcorp.com.ua> wrote:
> Hi, Greg
> I try to compile modified RTnet driver , and include "rtnet_port.h"
> I succesfully get module  r8169_2015_1.ko file but if i try to load it in=
 a system by sudo insmod r8169_2015_1.ko
>
> I get following errors
>
> yeti@yeti-UDOO-x86:~/eth$ sudo insmod r8169_2015_1.ko
> insmod: ERROR: could not insert module r8169_2015_1.ko: Unknown symbol in=
 module
>
>
> logs  dmesg
>
> [101391.334742] r8169_2015: Unknown symbol __rt_alloc_etherdev (err 0)
> [101391.334791] r8169_2015: Unknown symbol rtnetdev_alloc_rtskb (err 0)
> [101391.334858] r8169_2015: Unknown symbol kfree_rtskb (err 0)
> [101391.334918] r8169_2015: Unknown symbol rtdev_free (err 0)
> [101391.334982] r8169_2015: Unknown symbol rt_register_rtnetdev (err 0)
> [101391.335028] r8169_2015: Unknown symbol STACK_manager (err 0)
> [101391.335528] r8169_2015: Unknown symbol RTDEV_manager (err 0)
> [101391.335566] r8169_2015: Unknown symbol rt_stack_connect (err 0)
> [101391.335609] r8169_2015: Unknown symbol rt_stack_disconnect (err 0)
> [101391.335651] r8169_2015: Unknown symbol rt_rtdev_connect (err 0)
> [101391.335683] r8169_2015: Unknown symbol rtskb_pool_release (err 0)
> [101391.335720] r8169_2015: Unknown symbol rtnetif_rx (err 0)
> [101391.335766] r8169_2015: Unknown symbol rt_eth_type_trans (err 0)
> [101391.335802] r8169_2015: Unknown symbol rt_unregister_rtnetdev (err 0)
> [101391.335849] r8169_2015: Unknown symbol rtdev_alloc_name (err 0)
> [101391.335882] r8169_2015: Unknown symbol rt_rtdev_disconnect (err 0)
>
> How i can fix this ?
>
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC =D0=B8 =D0=
=BD=D0=B0=D0=B4=D0=B5=D0=B6=D0=B4=D0=BE=D0=B9 =D0=BD=D0=B0 =D1=81=D0=BE=D1=
=82=D1=80=D1=83=D0=B4=D0=BD=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=BE,
> =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2.=D0=93.
>
> ----- =D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D0=BE=
=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 -----
> =D0=9E=D1=82: "Greg Gallagher" <greg@embeddedgreg.com>
> =D0=9A=D0=BE=D0=BC=D1=83: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=
=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=
=8C=D0=B5=D0=B2=D0=B8=D1=87" <shevchenko.taras@triolcorp.com.ua>
> =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: "xenomai" <xenomai@xenomai.org>
> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5:=
 =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA, 17 =D0=90=D0=BF=D1=80=D0=B5=D0=
=BB=D1=8C 2018 =D0=B3 19:40:47
> =D0=A2=D0=B5=D0=BC=D0=B0: Re: [Xenomai] PCIe driver to communicate
>
> There no official documentation for doing this but if you google
> 'Xenomai PCI driver', you should find some third party example on how
> to do this.
>
> -Greg
>
> On Tue, Apr 17, 2018 at 9:56 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=
=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=
=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
> <shevchenko.taras@triolcorp.com.ua> wrote:
>> Hi!
>> I have to write PCIe driver to interchange with FPGA
>> Posiible someone do it before ? pls share with me or point me where to s=
tart ?
>> Thanks
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

