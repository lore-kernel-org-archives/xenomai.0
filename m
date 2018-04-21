Date: Sat, 21 Apr 2018 14:51:15 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <440568911.1056302.1524311475119.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <CALLqZ8Rs-3ux4rCxmXkRbRjQ_5c2MhkXFSLMCr3nfdkNYJKHpg@mail.gmail.com>
References: <1374825470.13406245.1523973370099.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8Rs-3ux4rCxmXkRbRjQ_5c2MhkXFSLMCr3nfdkNYJKHpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Unknown symbol in module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai <xenomai@xenomai.org>

Hi, Greg
I try to compile modified RTnet driver , and include "rtnet_port.h"=20
I succesfully get module  r8169_2015_1.ko file but if i try to load it in a=
 system by sudo insmod r8169_2015_1.ko

I get following errors

yeti@yeti-UDOO-x86:~/eth$ sudo insmod r8169_2015_1.ko
insmod: ERROR: could not insert module r8169_2015_1.ko: Unknown symbol in m=
odule


logs  dmesg

[101391.334742] r8169_2015: Unknown symbol __rt_alloc_etherdev (err 0)
[101391.334791] r8169_2015: Unknown symbol rtnetdev_alloc_rtskb (err 0)
[101391.334858] r8169_2015: Unknown symbol kfree_rtskb (err 0)
[101391.334918] r8169_2015: Unknown symbol rtdev_free (err 0)
[101391.334982] r8169_2015: Unknown symbol rt_register_rtnetdev (err 0)
[101391.335028] r8169_2015: Unknown symbol STACK_manager (err 0)
[101391.335528] r8169_2015: Unknown symbol RTDEV_manager (err 0)
[101391.335566] r8169_2015: Unknown symbol rt_stack_connect (err 0)
[101391.335609] r8169_2015: Unknown symbol rt_stack_disconnect (err 0)
[101391.335651] r8169_2015: Unknown symbol rt_rtdev_connect (err 0)
[101391.335683] r8169_2015: Unknown symbol rtskb_pool_release (err 0)
[101391.335720] r8169_2015: Unknown symbol rtnetif_rx (err 0)
[101391.335766] r8169_2015: Unknown symbol rt_eth_type_trans (err 0)
[101391.335802] r8169_2015: Unknown symbol rt_unregister_rtnetdev (err 0)
[101391.335849] r8169_2015: Unknown symbol rtdev_alloc_name (err 0)
[101391.335882] r8169_2015: Unknown symbol rt_rtdev_disconnect (err 0)

How i can fix this ?

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- =C8=F1=F5=EE=E4=ED=EE=E5 =F1=EE=EE=E1=F9=E5=ED=E8=E5 -----
=CE=F2: "Greg Gallagher" <greg@embeddedgreg.com>
=CA=EE=EC=F3: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=
=FC=E5=E2=E8=F7" <shevchenko.taras@triolcorp.com.ua>
=CA=EE=EF=E8=FF: "xenomai" <xenomai@xenomai.org>
=CE=F2=EF=F0=E0=E2=EB=E5=ED=ED=FB=E5: =C2=F2=EE=F0=ED=E8=EA, 17 =C0=EF=F0=
=E5=EB=FC 2018 =E3 19:40:47
=D2=E5=EC=E0: Re: [Xenomai] PCIe driver to communicate

There no official documentation for doing this but if you google
'Xenomai PCI driver', you should find some third party example on how
to do this.

-Greg

On Tue, Apr 17, 2018 at 9:56 AM, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =
=C3=F0=E8=E3=EE=F0=FC=E5=E2=E8=F7
<shevchenko.taras@triolcorp.com.ua> wrote:
> Hi!
> I have to write PCIe driver to interchange with FPGA
> Posiible someone do it before ? pls share with me or point me where to st=
art ?
> Thanks
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

