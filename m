Message-ID: <4548126.1177688516220.JavaMail.ngmail@domain.hid>
Date: Fri, 27 Apr 2007 17:41:56 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1177688176.5010.135.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1177688176.5010.135.camel@domain.hid>
	<1177686318.5010.106.camel@domain.hid>
	<1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>
	<784082.1177682909759.JavaMail.ngmail@domain.hid>
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>
	<1177685762.5010.104.camel@domain.hid>
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Hi Philippe,

I have extracted that part. However this very address is not available.
I have placed a couple of lines before and after that address.

Regards

Mathias
PS: I will continue on Monday with the tests....



c0333593 <__kprobes_text_end>:
c0333593:=096a 00                =09push   $0x0
c0333595:=090f a1                =09pop    %fs
c0333597:=09e9 ba e6 dc ff       =09jmp    c0101c56 <__switch_to+0x11a>
c033359c:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03335a1:=09e9 a6 e7 dc ff       =09jmp    c0101d4c <setup_sigcontext+0x14>
c03335a6:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03335ab:=09e9 a7 e7 dc ff       =09jmp    c0101d57 <setup_sigcontext+0x1f>
c03335b0:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03335b5:=09e9 a9 e7 dc ff       =09jmp    c0101d63 <setup_sigcontext+0x2b>
c03335ba:=09bd f2 ff ff ff       =09mov    $0xfffffff2,%ebp
c03335bf:=09e9 ab e7 dc ff       =09jmp    c0101d6f <setup_sigcontext+0x37>
c03335c4:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03335c9:=09e9 a9 e7 dc ff       =09jmp    c0101d77 <setup_sigcontext+0x3f>
c03335ce:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03335d3:=09e9 ab e7 dc ff       =09jmp    c0101d83 <setup_sigcontext+0x4b>
c03335d8:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03335dd:=09e9 ad e7 dc ff       =09jmp    c0101d8f <setup_sigcontext+0x57>
c03335e2:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c03335e7:=09e9 af e7 dc ff       =09jmp    c0101d9b <setup_sigcontext+0x63>
c03335ec:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03335f1:=09e9 b0 e7 dc ff       =09jmp    c0101da6 <setup_sigcontext+0x6e>
c03335f6:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03335fb:=09e9 b2 e7 dc ff       =09jmp    c0101db2 <setup_sigcontext+0x7a>
c0333600:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333605:=09e9 b4 e7 dc ff       =09jmp    c0101dbe <setup_sigcontext+0x86>
c033360a:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c033360f:=09e9 b6 e7 dc ff       =09jmp    c0101dca <setup_sigcontext+0x92>
c0333614:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333619:=09e9 c5 e7 dc ff       =09jmp    c0101de3 <setup_sigcontext+0xab>
c033361e:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333623:=09e9 ce e7 dc ff       =09jmp    c0101df6 <setup_sigcontext+0xbe>
c0333628:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c033362d:=09e9 d0 e7 dc ff       =09jmp    c0101e02 <setup_sigcontext+0xca>
c0333632:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333637:=09e9 d2 e7 dc ff       =09jmp    c0101e0e <setup_sigcontext+0xd6>
c033363c:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333641:=09e9 d4 e7 dc ff       =09jmp    c0101e1a <setup_sigcontext+0xe2>
c0333646:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c033364b:=09e9 d6 e7 dc ff       =09jmp    c0101e26 <setup_sigcontext+0xee>
c0333650:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333655:=09e9 d8 e7 dc ff       =09jmp    c0101e32 <setup_sigcontext+0xfa>
c033365a:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c033365f:=09e9 e9 e7 dc ff       =09jmp    c0101e4d <setup_sigcontext+0x115=
>
c0333664:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333669:=09e9 36 e8 dc ff       =09jmp    c0101ea4 <setup_sigcontext+0x16c=
>
c033366e:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333673:=09e9 3d e8 dc ff       =09jmp    c0101eb5 <setup_sigcontext+0x17d=
>
c0333678:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c033367d:=0966 31 c9             =09xor    %cx,%cx
c0333680:=09e9 70 e8 dc ff       =09jmp    c0101ef5 <restore_sigcontext+0x2=
2>
c0333685:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c033368a:=0966 31 db             =09xor    %bx,%bx
c033368d:=09e9 6f e8 dc ff       =09jmp    c0101f01 <restore_sigcontext+0x2=
e>
c0333692:=096a 00                =09push   $0x0
c0333694:=090f a1                =09pop    %fs
c0333696:=09e9 6c e8 dc ff       =09jmp    c0101f07 <restore_sigcontext+0x3=
4>
c033369b:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03336a0:=0966 31 c9             =09xor    %cx,%cx
c03336a3:=09e9 65 e8 dc ff       =09jmp    c0101f0d <restore_sigcontext+0x3=
a>
c03336a8:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c03336ad:=0966 31 c9             =09xor    %cx,%cx
c03336b0:=09e9 64 e8 dc ff       =09jmp    c0101f19 <restore_sigcontext+0x4=
6>
c03336b5:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03336ba:=0931 c9                =09xor    %ecx,%ecx
c03336bc:=09e9 65 e8 dc ff       =09jmp    c0101f26 <restore_sigcontext+0x5=
3>
c03336c1:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03336c6:=0931 c9                =09xor    %ecx,%ecx
c03336c8:=09e9 63 e8 dc ff       =09jmp    c0101f30 <restore_sigcontext+0x5=
d>
c03336cd:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03336d2:=0931 c9                =09xor    %ecx,%ecx
c03336d4:=09e9 61 e8 dc ff       =09jmp    c0101f3a <restore_sigcontext+0x6=
7>
c03336d9:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03336de:=0931 c9                =09xor    %ecx,%ecx
c03336e0:=09e9 5f e8 dc ff       =09jmp    c0101f44 <restore_sigcontext+0x7=
1>
c03336e5:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03336ea:=0931 c9                =09xor    %ecx,%ecx
c03336ec:=09e9 5d e8 dc ff       =09jmp    c0101f4e <restore_sigcontext+0x7=
b>
c03336f1:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03336f6:=0931 c9                =09xor    %ecx,%ecx
c03336f8:=09e9 5a e8 dc ff       =09jmp    c0101f57 <restore_sigcontext+0x8=
4>
c03336fd:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333702:=0931 c9                =09xor    %ecx,%ecx
c0333704:=09e9 58 e8 dc ff       =09jmp    c0101f61 <restore_sigcontext+0x8=
e>
c0333709:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c033370e:=0931 c9                =09xor    %ecx,%ecx
c0333710:=09e9 56 e8 dc ff       =09jmp    c0101f6b <restore_sigcontext+0x9=
8>
c0333715:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c033371a:=0966 31 c9             =09xor    %cx,%cx
c033371d:=09e9 54 e8 dc ff       =09jmp    c0101f76 <restore_sigcontext+0xa=
3>
c0333722:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333727:=0966 31 c9             =09xor    %cx,%cx
c033372a:=09e9 58 e8 dc ff       =09jmp    c0101f87 <restore_sigcontext+0xb=
4>
c033372f:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333734:=0931 db                =09xor    %ebx,%ebx
c0333736:=09e9 5c e8 dc ff       =09jmp    c0101f97 <restore_sigcontext+0xc=
4>
c033373b:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333740:=0931 c9                =09xor    %ecx,%ecx
c0333742:=09e9 70 e8 dc ff       =09jmp    c0101fb7 <restore_sigcontext+0xe=
4>
c0333747:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c033374c:=0931 d2                =09xor    %edx,%edx
c033374e:=09e9 d1 e8 dc ff       =09jmp    c0102024 <restore_sigcontext+0x1=
51>
c0333753:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333758:=0931 d2                =09xor    %edx,%edx
c033375a:=09e9 07 e9 dc ff       =09jmp    c0102066 <sys_sigaction+0x31>
c033375f:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333764:=0931 c0                =09xor    %eax,%eax
c0333766:=09e9 0c e9 dc ff       =09jmp    c0102077 <sys_sigaction+0x42>
c033376b:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333770:=0931 c0                =09xor    %eax,%eax
c0333772:=09e9 11 e9 dc ff       =09jmp    c0102088 <sys_sigaction+0x53>
c0333777:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c033377c:=0931 c0                =09xor    %eax,%eax
c033377e:=09e9 0c e9 dc ff       =09jmp    c010208f <sys_sigaction+0x5a>
c0333783:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333788:=09e9 52 e9 dc ff       =09jmp    c01020df <sys_sigaction+0xaa>
c033378d:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333792:=09e9 55 e9 dc ff       =09jmp    c01020ec <sys_sigaction+0xb7>
c0333797:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c033379c:=09e9 58 e9 dc ff       =09jmp    c01020f9 <sys_sigaction+0xc4>
c03337a1:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03337a6:=09e9 57 e9 dc ff       =09jmp    c0102102 <sys_sigaction+0xcd>
c03337ab:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c03337b0:=09e9 20 eb dc ff       =09jmp    c01022d5 <do_notify_resume+0x1c4=
>
c03337b5:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03337ba:=09e9 1e eb dc ff       =09jmp    c01022dd <do_notify_resume+0x1cc=
>
c03337bf:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03337c4:=09e9 1f eb dc ff       =09jmp    c01022e8 <do_notify_resume+0x1d7=
>
c03337c9:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c03337ce:=09e9 36 eb dc ff       =09jmp    c0102309 <do_notify_resume+0x1f8=
>
c03337d3:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c03337d8:=09e9 3c eb dc ff       =09jmp    c0102319 <do_notify_resume+0x208=
>
c03337dd:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03337e2:=09e9 44 eb dc ff       =09jmp    c010232b <do_notify_resume+0x21a=
>
c03337e7:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03337ec:=09e9 63 eb dc ff       =09jmp    c0102354 <do_notify_resume+0x243=
>
c03337f1:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03337f6:=09e9 71 eb dc ff       =09jmp    c010236c <do_notify_resume+0x25b=
>
c03337fb:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333800:=09e9 c3 eb dc ff       =09jmp    c01023c8 <do_notify_resume+0x2b7=
>
c0333805:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c033380a:=09e9 c2 eb dc ff       =09jmp    c01023d1 <do_notify_resume+0x2c0=
>
c033380f:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333814:=09e9 c6 eb dc ff       =09jmp    c01023df <do_notify_resume+0x2ce=
>
c0333819:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c033381e:=09e9 c5 eb dc ff       =09jmp    c01023e8 <do_notify_resume+0x2d7=
>
c0333823:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333828:=09e9 88 ec dc ff       =09jmp    c01024b5 <do_notify_resume+0x3a4=
>
c033382d:=09bb 04 00 00 00       =09mov    $0x4,%ebx
c0333832:=09e9 b3 ec dc ff       =09jmp    c01024ea <do_notify_resume+0x3d9=
>
c0333837:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c033383c:=09e9 e5 ec dc ff       =09jmp    c0102526 <do_notify_resume+0x415=
>
c0333841:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333846:=09e9 e6 ec dc ff       =09jmp    c0102531 <do_notify_resume+0x420=
>
c033384b:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333850:=09e9 ea ec dc ff       =09jmp    c010253f <do_notify_resume+0x42e=
>
c0333855:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c033385a:=09e9 e9 ec dc ff       =09jmp    c0102548 <do_notify_resume+0x437=
>
c033385f:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333864:=0931 c0                =09xor    %eax,%eax
c0333866:=09e9 1e f0 dc ff       =09jmp    c0102889 <sys_sigreturn+0x2d>
c033386b:=09ba 04 00 00 00       =09mov    $0x4,%edx
c0333870:=0931 c0                =09xor    %eax,%eax
c0333872:=09e9 1f f0 dc ff       =09jmp    c0102896 <sys_sigreturn+0x3a>
c0333877:=09c7 44 24 24 00 00 00 =09movl   $0x0,0x24(%esp)
c033387e:=0900=20
c033387f:=09e9 9a f1 dc ff       =09jmp    c0102a1e <sysenter_exit+0xe>
c0333884:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c033388b:=09e9 33 f2 dc ff       =09jmp    c0102ac3 <restore_nocheck_notrac=
e+0x7>
c0333890:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333897:=09e9 28 f2 dc ff       =09jmp    c0102ac4 <restore_nocheck_notrac=
e+0x8>
c033389c:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03338a3:=09e9 1d f2 dc ff       =09jmp    c0102ac5 <restore_nocheck_notrac=
e+0x9>

c03338a8 <iret_exc>:
c03338a8:=09fb                   =09sti   =20
c03338a9:=096a 00                =09push   $0x0
c03338ab:=096a 20                =09push   $0x20
c03338ad:=09e9 6a fa ff ff       =09jmp    c033331c <error_code>
c03338b2:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03338b9:=09e9 8a fb dc ff       =09jmp    c0103448 <common_interrupt+0x30>
c03338be:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03338c5:=09e9 7f fb dc ff       =09jmp    c0103449 <common_interrupt+0x31>
c03338ca:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03338d1:=09e9 74 fb dc ff       =09jmp    c010344a <common_interrupt+0x32>
c03338d6:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03338dd:=09e9 a3 fb dc ff       =09jmp    c0103485 <reschedule_interrupt+0=
x35>
c03338e2:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03338e9:=09e9 98 fb dc ff       =09jmp    c0103486 <reschedule_interrupt+0=
x36>
c03338ee:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03338f5:=09e9 8d fb dc ff       =09jmp    c0103487 <reschedule_interrupt+0=
x37>
c03338fa:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333901:=09e9 bf fb dc ff       =09jmp    c01034c5 <invalidate_interrupt+0=
x35>
c0333906:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c033390d:=09e9 b4 fb dc ff       =09jmp    c01034c6 <invalidate_interrupt+0=
x36>
c0333912:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333919:=09e9 a9 fb dc ff       =09jmp    c01034c7 <invalidate_interrupt+0=
x37>
c033391e:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333925:=09e9 db fb dc ff       =09jmp    c0103505 <call_function_interrup=
t+0x35>
c033392a:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333931:=09e9 d0 fb dc ff       =09jmp    c0103506 <call_function_interrup=
t+0x36>
c0333936:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c033393d:=09e9 c5 fb dc ff       =09jmp    c0103507 <call_function_interrup=
t+0x37>
c0333942:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333949:=09e9 f7 fb dc ff       =09jmp    c0103545 <apic_timer_interrupt+0=
x35>
c033394e:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333955:=09e9 ec fb dc ff       =09jmp    c0103546 <apic_timer_interrupt+0=
x36>
c033395a:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333961:=09e9 e1 fb dc ff       =09jmp    c0103547 <apic_timer_interrupt+0=
x37>
c0333966:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c033396d:=09e9 13 fc dc ff       =09jmp    c0103585 <error_interrupt+0x35>
c0333972:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333979:=09e9 08 fc dc ff       =09jmp    c0103586 <error_interrupt+0x36>
c033397e:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333985:=09e9 fd fb dc ff       =09jmp    c0103587 <error_interrupt+0x37>
c033398a:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c0333991:=09e9 2f fc dc ff       =09jmp    c01035c5 <spurious_interrupt+0x3=
5>
c0333996:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c033399d:=09e9 24 fc dc ff       =09jmp    c01035c6 <spurious_interrupt+0x3=
6>
c03339a2:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03339a9:=09e9 19 fc dc ff       =09jmp    c01035c7 <spurious_interrupt+0x3=
7>
c03339ae:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03339b5:=09e9 4b fc dc ff       =09jmp    c0103605 <thermal_interrupt+0x35=
>
c03339ba:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03339c1:=09e9 40 fc dc ff       =09jmp    c0103606 <thermal_interrupt+0x36=
>
c03339c6:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03339cd:=09e9 35 fc dc ff       =09jmp    c0103607 <thermal_interrupt+0x37=
>
c03339d2:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03339d9:=09e9 56 fb ff ff       =09jmp    c0333534 <nmi_espfix_stack+0x74>
c03339de:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03339e5:=09e9 4b fb ff ff       =09jmp    c0333535 <nmi_espfix_stack+0x75>
c03339ea:=09c7 04 24 00 00 00 00 =09movl   $0x0,(%esp)
c03339f1:=09e9 40 fb ff ff       =09jmp    c0333536 <nmi_espfix_stack+0x76>
c03339f6:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03339fb:=0930 db                =09xor    %bl,%bl
c03339fd:=09e9 e0 02 dd ff       =09jmp    c0103ce2 <show_registers+0x204>
c0333a02:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333a07:=0930 db                =09xor    %bl,%bl
c0333a09:=09e9 15 03 dd ff       =09jmp    c0103d23 <show_registers+0x245>
c0333a0e:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333a13:=0966 31 db             =09xor    %bx,%bx
c0333a16:=09e9 bb 06 dd ff       =09jmp    c01040d6 <is_valid_bugaddr+0x23>
c0333a1b:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333a20:=09e9 39 1c dd ff       =09jmp    c010565e <arch_ptrace+0x3b8>
c0333a25:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333a2a:=0931 c9                =09xor    %ecx,%ecx
c0333a2c:=09e9 64 1c dd ff       =09jmp    c0105695 <arch_ptrace+0x3ef>
c0333a31:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333a36:=09e9 88 37 dd ff       =09jmp    c01071c3 <sys_olduname+0x5c>
c0333a3b:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333a40:=09e9 a7 37 dd ff       =09jmp    c01071ec <sys_olduname+0x85>
c0333a45:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333a4a:=09e9 c9 37 dd ff       =09jmp    c0107218 <sys_olduname+0xb1>
c0333a4f:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333a54:=09e9 eb 37 dd ff       =09jmp    c0107244 <sys_olduname+0xdd>
c0333a59:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c0333a5e:=09e9 0b 38 dd ff       =09jmp    c010726e <sys_olduname+0x107>
c0333a63:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333a68:=0931 c0                =09xor    %eax,%eax
c0333a6a:=09e9 e9 3b dd ff       =09jmp    c0107658 <convert_fxsr_from_user=
+0x97>
c0333a6f:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333a74:=0931 c0                =09xor    %eax,%eax
c0333a76:=09e9 e7 3b dd ff       =09jmp    c0107662 <convert_fxsr_from_user=
+0xa1>
c0333a7b:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333a80:=0966 31 c0             =09xor    %ax,%ax
c0333a83:=09e9 e6 3b dd ff       =09jmp    c010766e <convert_fxsr_from_user=
+0xad>
c0333a88:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333a8d:=09e9 0a 3d dd ff       =09jmp    c010779c <convert_fxsr_to_user+0=
x106>
c0333a92:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333a97:=09e9 0b 3d dd ff       =09jmp    c01077a7 <convert_fxsr_to_user+0=
x111>
c0333a9c:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333aa1:=09e9 0e 3d dd ff       =09jmp    c01077b4 <convert_fxsr_to_user+0=
x11e>
c0333aa6:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333aab:=09e9 b7 3f dd ff       =09jmp    c0107a67 <save_i387+0x9c>
c0333ab0:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333ab5:=09e9 b5 3f dd ff       =09jmp    c0107a6f <save_i387+0xa4>
c0333aba:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333abf:=0966 31 f6             =09xor    %si,%si
c0333ac2:=09e9 61 42 dd ff       =09jmp    c0107d28 <romsignature+0x1c>
c0333ac7:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333acc:=09e9 b5 6d dd ff       =09jmp    c010a886 <mtrr_wrmsr+0x13>
c0333ad1:=096a 00                =09push   $0x0
c0333ad3:=090f a1                =09pop    %fs
c0333ad5:=09e9 13 c1 dd ff       =09jmp    c010fbed <save_v86_state+0x129>
c0333ada:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333adf:=0930 db                =09xor    %bl,%bl
c0333ae1:=09e9 40 d5 dd ff       =09jmp    c0111026 <__is_prefetch+0x156>
c0333ae6:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333aeb:=0930 c9                =09xor    %cl,%cl
c0333aed:=09e9 a5 d5 dd ff       =09jmp    c0111097 <__is_prefetch+0x1c7>
c0333af2:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c0333af7:=09e9 c8 55 de ff       =09jmp    c01190c4 <do_syslog+0x131>
c0333afc:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c0333b01:=09e9 b7 56 de ff       =09jmp    c01191bd <do_syslog+0x22a>
c0333b06:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333b0b:=0930 d2                =09xor    %dl,%dl
c0333b0d:=09e9 fd 56 de ff       =09jmp    c011920f <do_syslog+0x27c>
c0333b12:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333b17:=09e9 fd 56 de ff       =09jmp    c0119219 <do_syslog+0x286>
c0333b1c:=09bd f2 ff ff ff       =09mov    $0xfffffff2,%ebp
c0333b21:=09e9 92 d7 de ff       =09jmp    c01212b8 <copy_siginfo_to_user+0=
x4e>
c0333b26:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333b2b:=09e9 90 d7 de ff       =09jmp    c01212c0 <copy_siginfo_to_user+0=
x56>
c0333b30:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333b35:=09e9 90 d7 de ff       =09jmp    c01212ca <copy_siginfo_to_user+0=
x60>
c0333b3a:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333b3f:=09e9 dc d7 de ff       =09jmp    c0121320 <copy_siginfo_to_user+0=
xb6>
c0333b44:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333b49:=09e9 da d7 de ff       =09jmp    c0121328 <copy_siginfo_to_user+0=
xbe>
c0333b4e:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333b53:=09e9 da d7 de ff       =09jmp    c0121332 <copy_siginfo_to_user+0=
xc8>
c0333b58:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333b5d:=09e9 d8 d7 de ff       =09jmp    c012133a <copy_siginfo_to_user+0=
xd0>
c0333b62:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333b67:=09e9 d6 d7 de ff       =09jmp    c0121342 <copy_siginfo_to_user+0=
xd8>
c0333b6c:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333b71:=09e9 dd d7 de ff       =09jmp    c0121353 <copy_siginfo_to_user+0=
xe9>
c0333b76:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333b7b:=09e9 db d7 de ff       =09jmp    c012135b <copy_siginfo_to_user+0=
xf1>
c0333b80:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333b85:=09e9 dd d7 de ff       =09jmp    c0121367 <copy_siginfo_to_user+0=
xfd>
c0333b8a:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333b8f:=09e9 dd d7 de ff       =09jmp    c0121371 <copy_siginfo_to_user+0=
x107>
c0333b94:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333b99:=09e9 db d7 de ff       =09jmp    c0121379 <copy_siginfo_to_user+0=
x10f>
c0333b9e:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333ba3:=09e9 db d7 de ff       =09jmp    c0121383 <copy_siginfo_to_user+0=
x119>
c0333ba8:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333bad:=09e9 db d7 de ff       =09jmp    c012138d <copy_siginfo_to_user+0=
x123>
c0333bb2:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333bb7:=09e9 d9 d7 de ff       =09jmp    c0121395 <copy_siginfo_to_user+0=
x12b>
c0333bbc:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333bc1:=09e9 db d7 de ff       =09jmp    c01213a1 <copy_siginfo_to_user+0=
x137>
c0333bc6:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333bcb:=09e9 d9 d7 de ff       =09jmp    c01213a9 <copy_siginfo_to_user+0=
x13f>
c0333bd0:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333bd5:=09e9 d7 d7 de ff       =09jmp    c01213b1 <copy_siginfo_to_user+0=
x147>
c0333bda:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0333bdf:=09e9 db d7 de ff       =09jmp    c01213bf <copy_siginfo_to_user+0=
x155>
c0333be4:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333be9:=09e9 d9 d7 de ff       =09jmp    c01213c7 <copy_siginfo_to_user+0=
x15d>
c0333bee:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333bf3:=0931 ed                =09xor    %ebp,%ebp
c0333bf5:=09e9 9e e9 de ff       =09jmp    c0122598 <do_sigaltstack+0x6f>
c0333bfa:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333bff:=0931 f6                =09xor    %esi,%esi
c0333c01:=09e9 99 e9 de ff       =09jmp    c012259f <do_sigaltstack+0x76>
c0333c06:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333c0b:=0931 db                =09xor    %ebx,%ebx
c0333c0d:=09e9 94 e9 de ff       =09jmp    c01225a6 <do_sigaltstack+0x7d>
c0333c12:=09b8 04 00 00 00       =09mov    $0x4,%eax
c0333c17:=0931 c9                =09xor    %ecx,%ecx
c0333c19:=09e9 41 85 df ff       =09jmp    c012c15f <futex_requeue+0x9b>
c0333c1e:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333c23:=09e9 90 87 df ff       =09jmp    c012c3b8 <handle_futex_death+0x5=
2>
c0333c28:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333c2d:=09e9 8c 8a df ff       =09jmp    c012c6be <futex_lock_pi+0x164>
c0333c32:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333c37:=09e9 ea 8a df ff       =09jmp    c012c726 <futex_lock_pi+0x1cc>
c0333c3c:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333c41:=09e9 2e 8d df ff       =09jmp    c012c974 <futex_lock_pi+0x41a>
c0333c46:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333c4b:=09e9 8a 8f df ff       =09jmp    c012cbda <futex_lock_pi+0x680>
c0333c50:=09b8 04 00 00 00       =09mov    $0x4,%eax
c0333c55:=0931 c9                =09xor    %ecx,%ecx
c0333c57:=09e9 be 91 df ff       =09jmp    c012ce1a <do_futex+0xef>
c0333c5c:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333c61:=09e9 0b 96 df ff       =09jmp    c012d271 <do_futex+0x546>
c0333c66:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333c6b:=09e9 29 96 df ff       =09jmp    c012d299 <do_futex+0x56e>
c0333c70:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333c75:=09e9 33 96 df ff       =09jmp    c012d2ad <do_futex+0x582>
c0333c7a:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333c7f:=09e9 3b 96 df ff       =09jmp    c012d2bf <do_futex+0x594>
c0333c84:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333c89:=09e9 41 96 df ff       =09jmp    c012d2cf <do_futex+0x5a4>
c0333c8e:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333c93:=09e9 ce 98 df ff       =09jmp    c012d566 <do_futex+0x83b>
c0333c98:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333c9d:=09e9 b7 99 df ff       =09jmp    c012d659 <do_futex+0x92e>
c0333ca2:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333ca7:=09e9 e4 9a df ff       =09jmp    c012d790 <do_futex+0xa65>
c0333cac:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333cb1:=09e9 86 7d e0 ff       =09jmp    c013ba3c <file_read_actor+0x28>
c0333cb6:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333cbb:=09e9 99 7d e0 ff       =09jmp    c013ba59 <file_read_actor+0x45>
c0333cc0:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333cc5:=0930 c0                =09xor    %al,%al
c0333cc7:=09e9 fb 90 e0 ff       =09jmp    c013cdc7 <generic_file_buffered_=
write+0x122>
c0333ccc:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333cd1:=0930 c0                =09xor    %al,%al
c0333cd3:=09e9 17 91 e0 ff       =09jmp    c013cdef <generic_file_buffered_=
write+0x14a>
c0333cd8:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333cdd:=0930 c0                =09xor    %al,%al
c0333cdf:=09e9 d8 ef e1 ff       =09jmp    c0152cbc <kmem_cache_create+0x90=
>
c0333ce4:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333ce9:=0930 c0                =09xor    %al,%al
c0333ceb:=09e9 d5 55 e2 ff       =09jmp    c01592c5 <iov_fault_in_pages_rea=
d+0x29>
c0333cf0:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333cf5:=0930 c0                =09xor    %al,%al
c0333cf7:=09e9 e9 55 e2 ff       =09jmp    c01592e5 <iov_fault_in_pages_rea=
d+0x49>
c0333cfc:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333d01:=09e9 7d 62 e2 ff       =09jmp    c0159f83 <pipe_read+0xe7>
c0333d06:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333d0b:=09e9 99 62 e2 ff       =09jmp    c0159fa9 <pipe_read+0x10d>
c0333d10:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333d15:=09e9 d0 a7 e2 ff       =09jmp    c015e4ea <filldir64+0x46>
c0333d1a:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333d1f:=09e9 db a7 e2 ff       =09jmp    c015e4ff <filldir64+0x5b>
c0333d24:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333d29:=09e9 e1 a7 e2 ff       =09jmp    c015e50f <filldir64+0x6b>
c0333d2e:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333d33:=09e9 e1 a7 e2 ff       =09jmp    c015e519 <filldir64+0x75>
c0333d38:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333d3d:=09e9 e2 a7 e2 ff       =09jmp    c015e524 <filldir64+0x80>
c0333d42:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333d47:=09e9 f7 a7 e2 ff       =09jmp    c015e543 <filldir64+0x9f>
c0333d4c:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333d51:=09e9 67 a8 e2 ff       =09jmp    c015e5bd <filldir+0x54>
c0333d56:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333d5b:=09e9 67 a8 e2 ff       =09jmp    c015e5c7 <filldir+0x5e>
c0333d60:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333d65:=09e9 65 a8 e2 ff       =09jmp    c015e5cf <filldir+0x66>
c0333d6a:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333d6f:=09e9 7a a8 e2 ff       =09jmp    c015e5ee <filldir+0x85>
c0333d74:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333d79:=09e9 7c a8 e2 ff       =09jmp    c015e5fa <filldir+0x91>
c0333d7e:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c0333d83:=09e9 91 a9 e2 ff       =09jmp    c015e719 <sys_getdents64+0x83>
c0333d88:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333d8d:=09e9 6f aa e2 ff       =09jmp    c015e801 <fillonedir+0x78>
c0333d92:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333d97:=09e9 70 aa e2 ff       =09jmp    c015e80c <fillonedir+0x83>
c0333d9c:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333da1:=09e9 6e aa e2 ff       =09jmp    c015e814 <fillonedir+0x8b>
c0333da6:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333dab:=09e9 81 aa e2 ff       =09jmp    c015e831 <fillonedir+0xa8>
c0333db0:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333db5:=09e9 4c ae e2 ff       =09jmp    c015ec06 <do_sys_poll+0x29c>
c0333dba:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333dbf:=0931 db                =09xor    %ebx,%ebx
c0333dc1:=09e9 a4 b7 e2 ff       =09jmp    c015f56a <sys_pselect6+0x2c>
c0333dc6:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333dcb:=0931 d2                =09xor    %edx,%edx
c0333dcd:=09e9 9f b7 e2 ff       =09jmp    c015f571 <sys_pselect6+0x33>
c0333dd2:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333dd7:=0930 c0                =09xor    %al,%al
c0333dd9:=09e9 65 21 e3 ff       =09jmp    c0165f43 <copy_mount_options+0x9=
2>
c0333dde:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333de3:=0931 ff                =09xor    %edi,%edi
c0333de5:=09e9 04 52 e3 ff       =09jmp    c0168fee <sys_io_submit+0x59>
c0333dea:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333def:=09e9 2a 35 e4 ff       =09jmp    c017731e <sys_epoll_wait+0x279>
c0333df4:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333df9:=09e9 35 35 e4 ff       =09jmp    c0177333 <sys_epoll_wait+0x28e>
c0333dfe:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333e03:=09e9 0d 75 e4 ff       =09jmp    c017b315 <load_elf_binary+0xfcc>
c0333e08:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333e0d:=09e9 18 75 e4 ff       =09jmp    c017b32a <load_elf_binary+0xfe1>
c0333e12:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333e17:=09e9 21 75 e4 ff       =09jmp    c017b33d <load_elf_binary+0xff4>
c0333e1c:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333e21:=09e9 49 75 e4 ff       =09jmp    c017b36f <load_elf_binary+0x1026=
>
c0333e26:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333e2b:=09e9 75 75 e4 ff       =09jmp    c017b3a5 <load_elf_binary+0x105c=
>
c0333e30:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333e35:=09e9 99 75 e4 ff       =09jmp    c017b3d3 <load_elf_binary+0x108a=
>
c0333e3a:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333e3f:=09e9 c3 75 e4 ff       =09jmp    c017b407 <load_elf_binary+0x10be=
>
c0333e44:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333e49:=0930 c0                =09xor    %al,%al
c0333e4b:=09e9 0b f9 e5 ff       =09jmp    c019375b <reiserfs_file_write+0x=
16df>
c0333e50:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c0333e55:=0930 c0                =09xor    %al,%al
c0333e57:=09e9 24 f9 e5 ff       =09jmp    c0193780 <reiserfs_file_write+0x=
1704>
c0333e5c:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333e61:=0930 d2                =09xor    %dl,%dl
c0333e63:=09e9 48 84 ed ff       =09jmp    c020c2b0 <__bitmap_parse+0x90>
c0333e68:=098b 5c 24 20          =09mov    0x20(%esp),%ebx
c0333e6c:=09c7 03 f2 ff ff ff    =09movl   $0xfffffff2,(%ebx)
c0333e72:=098b 7c 24 14          =09mov    0x14(%esp),%edi
c0333e76:=098b 4c 24 18          =09mov    0x18(%esp),%ecx
c0333e7a:=0931 c0                =09xor    %eax,%eax
c0333e7c:=09f3 aa                =09rep stos %al,%es:(%edi)
c0333e7e:=09e9 21 cb ed ff       =09jmp    c02109a4 <csum_partial_copy_gene=
ric+0xf4>
c0333e83:=098b 5c 24 24          =09mov    0x24(%esp),%ebx
c0333e87:=09c7 03 f2 ff ff ff    =09movl   $0xfffffff2,(%ebx)
c0333e8d:=09e9 12 cb ed ff       =09jmp    c02109a4 <csum_partial_copy_gene=
ric+0xf4>
c0333e92:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333e97:=09e9 33 cd ed ff       =09jmp    c0210bcf <__strncpy_from_user+0x=
17>
c0333e9c:=098d 0c 8a             =09lea    (%edx,%ecx,4),%ecx
c0333e9f:=09e9 43 cd ed ff       =09jmp    c0210be7 <__clear_user+0x13>
c0333ea4:=098d 0c 88             =09lea    (%eax,%ecx,4),%ecx
c0333ea7:=09e9 04 ce ed ff       =09jmp    c0210cb0 <__copy_from_user_ll_no=
cache_nozero+0xc5>
c0333eac:=0901 c1                =09add    %eax,%ecx
c0333eae:=09e9 1f ce ed ff       =09jmp    c0210cd2 <__copy_from_user_ll_no=
cache_nozero+0xe7>
c0333eb3:=098d 0c 88             =09lea    (%eax,%ecx,4),%ecx
c0333eb6:=09e9 17 ce ed ff       =09jmp    c0210cd2 <__copy_from_user_ll_no=
cache_nozero+0xe7>
c0333ebb:=098d 0c 88             =09lea    (%eax,%ecx,4),%ecx
c0333ebe:=09e9 c0 ce ed ff       =09jmp    c0210d83 <__copy_from_user_ll_no=
zero+0xac>
c0333ec3:=0901 c1                =09add    %eax,%ecx
c0333ec5:=09e9 dc ce ed ff       =09jmp    c0210da6 <__copy_from_user_ll_no=
zero+0xcf>
c0333eca:=098d 0c 88             =09lea    (%eax,%ecx,4),%ecx
c0333ecd:=09e9 d4 ce ed ff       =09jmp    c0210da6 <__copy_from_user_ll_no=
zero+0xcf>
c0333ed2:=098d 0c 88             =09lea    (%eax,%ecx,4),%ecx
c0333ed5:=0951                   =09push   %ecx
c0333ed6:=0950                   =09push   %eax
c0333ed7:=0931 c0                =09xor    %eax,%eax
c0333ed9:=09f3 aa                =09rep stos %al,%es:(%edi)
c0333edb:=0958                   =09pop    %eax
c0333edc:=0959                   =09pop    %ecx
c0333edd:=09e9 75 cf ed ff       =09jmp    c0210e57 <__copy_from_user_ll+0x=
ac>
c0333ee2:=0901 c1                =09add    %eax,%ecx
c0333ee4:=09eb 03                =09jmp    c0333ee9 <iret_exc+0x641>
c0333ee6:=098d 0c 88             =09lea    (%eax,%ecx,4),%ecx
c0333ee9:=0951                   =09push   %ecx
c0333eea:=0950                   =09push   %eax
c0333eeb:=0931 c0                =09xor    %eax,%eax
c0333eed:=09f3 aa                =09rep stos %al,%es:(%edi)
c0333eef:=0958                   =09pop    %eax
c0333ef0:=0959                   =09pop    %ecx
c0333ef1:=09e9 84 cf ed ff       =09jmp    c0210e7a <__copy_from_user_ll+0x=
cf>
c0333ef6:=098d 0c 88             =09lea    (%eax,%ecx,4),%ecx
c0333ef9:=09e9 2d d0 ed ff       =09jmp    c0210f2b <__copy_to_user_ll+0xac=
>
c0333efe:=0901 c1                =09add    %eax,%ecx
c0333f00:=09e9 49 d0 ed ff       =09jmp    c0210f4e <__copy_to_user_ll+0xcf=
>
c0333f05:=098d 0c 88             =09lea    (%eax,%ecx,4),%ecx
c0333f08:=09e9 41 d0 ed ff       =09jmp    c0210f4e <__copy_to_user_ll+0xcf=
>
c0333f0d:=098d 0c 88             =09lea    (%eax,%ecx,4),%ecx
c0333f10:=0951                   =09push   %ecx
c0333f11:=0950                   =09push   %eax
c0333f12:=0931 c0                =09xor    %eax,%eax
c0333f14:=09f3 aa                =09rep stos %al,%es:(%edi)
c0333f16:=0958                   =09pop    %eax
c0333f17:=0959                   =09pop    %ecx
c0333f18:=09e9 4d d1 ed ff       =09jmp    c021106a <__copy_from_user_ll_no=
cache+0xc5>
c0333f1d:=0901 c1                =09add    %eax,%ecx
c0333f1f:=09eb 03                =09jmp    c0333f24 <iret_exc+0x67c>
c0333f21:=098d 0c 88             =09lea    (%eax,%ecx,4),%ecx
c0333f24:=0951                   =09push   %ecx
c0333f25:=0950                   =09push   %eax
c0333f26:=0931 c0                =09xor    %eax,%eax
c0333f28:=09f3 aa                =09rep stos %al,%es:(%edi)
c0333f2a:=0958                   =09pop    %eax
c0333f2b:=0959                   =09pop    %ecx
c0333f2c:=09e9 5b d1 ed ff       =09jmp    c021108c <__copy_from_user_ll_no=
cache+0xe7>
c0333f31:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333f36:=09e9 89 d1 ed ff       =09jmp    c02110c4 <strncpy_from_user+0x33=
>
c0333f3b:=098d 0c 8b             =09lea    (%ebx,%ecx,4),%ecx
c0333f3e:=09e9 b4 d1 ed ff       =09jmp    c02110f7 <clear_user+0x2d>
c0333f43:=0931 c0                =09xor    %eax,%eax
c0333f45:=09e9 e1 d1 ed ff       =09jmp    c021112b <strnlen_user+0x2f>
c0333f4a:=09b0 01                =09mov    $0x1,%al
c0333f4c:=09e9 da d1 ed ff       =09jmp    c021112b <strnlen_user+0x2f>
c0333f51:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0333f56:=09e9 8f 6a ee ff       =09jmp    c021a9ea <proc_bus_pci_read+0xba=
>
c0333f5b:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333f60:=09e9 af 6a ee ff       =09jmp    c021aa14 <proc_bus_pci_read+0xe4=
>
c0333f65:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333f6a:=09e9 c5 6a ee ff       =09jmp    c021aa34 <proc_bus_pci_read+0x10=
4>
c0333f6f:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333f74:=09e9 e4 6a ee ff       =09jmp    c021aa5d <proc_bus_pci_read+0x12=
d>
c0333f79:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333f7e:=09e9 fc 6a ee ff       =09jmp    c021aa7f <proc_bus_pci_read+0x14=
f>
c0333f83:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333f88:=0930 c9                =09xor    %cl,%cl
c0333f8a:=09e9 81 6b ee ff       =09jmp    c021ab10 <proc_bus_pci_write+0x7=
7>
c0333f8f:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333f94:=0966 31 c9             =09xor    %cx,%cx
c0333f97:=09e9 98 6b ee ff       =09jmp    c021ab34 <proc_bus_pci_write+0x9=
b>
c0333f9c:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333fa1:=0931 c9                =09xor    %ecx,%ecx
c0333fa3:=09e9 a8 6b ee ff       =09jmp    c021ab50 <proc_bus_pci_write+0xb=
7>
c0333fa8:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333fad:=0966 31 c9             =09xor    %cx,%cx
c0333fb0:=09e9 bd 6b ee ff       =09jmp    c021ab72 <proc_bus_pci_write+0xd=
9>
c0333fb5:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333fba:=0930 c9                =09xor    %cl,%cl
c0333fbc:=09e9 cf 6b ee ff       =09jmp    c021ab90 <proc_bus_pci_write+0xf=
7>
c0333fc1:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333fc6:=0930 c0                =09xor    %al,%al
c0333fc8:=09e9 25 76 ef ff       =09jmp    c022b5f2 <acpi_os_readable+0xb>
c0333fcd:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333fd2:=0930 c0                =09xor    %al,%al
c0333fd4:=09e9 23 76 ef ff       =09jmp    c022b5fc <acpi_os_readable+0x15>
c0333fd9:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0333fde:=09e9 7f 7f f1 ff       =09jmp    c024bf62 <read_port+0x42>
c0333fe3:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333fe8:=0930 c0                =09xor    %al,%al
c0333fea:=09e9 e8 7f f1 ff       =09jmp    c024bfd7 <write_port+0x44>
c0333fef:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0333ff4:=0966 31 c0             =09xor    %ax,%ax
c0333ff7:=09e9 08 07 f2 ff       =09jmp    c0254704 <vt_ioctl+0x1006>
c0333ffc:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0334001:=0966 31 c9             =09xor    %cx,%cx
c0334004:=09e9 06 07 f2 ff       =09jmp    c025470f <vt_ioctl+0x1011>
c0334009:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c033400e:=0966 31 c0             =09xor    %ax,%ax
c0334011:=09e9 03 07 f2 ff       =09jmp    c0254719 <vt_ioctl+0x101b>
c0334016:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c033401b:=0966 31 c0             =09xor    %ax,%ax
c033401e:=09e9 01 07 f2 ff       =09jmp    c0254724 <vt_ioctl+0x1026>
c0334023:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0334028:=0966 31 c9             =09xor    %cx,%cx
c033402b:=09e9 fc 06 f2 ff       =09jmp    c025472c <vt_ioctl+0x102e>
c0334030:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0334035:=0966 31 db             =09xor    %bx,%bx
c0334038:=09e9 f5 06 f2 ff       =09jmp    c0254732 <vt_ioctl+0x1034>
c033403d:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0334042:=09e9 54 15 f2 ff       =09jmp    c025559b <con_get_unimap+0x9f>
c0334047:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c033404c:=09e9 53 15 f2 ff       =09jmp    c02555a4 <con_get_unimap+0xa8>
c0334051:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0334056:=09e9 8d 15 f2 ff       =09jmp    c02555e8 <con_get_unimap+0xec>
c033405b:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0334060:=0966 31 d2             =09xor    %dx,%dx
c0334063:=09e9 65 1c f2 ff       =09jmp    c0255ccd <con_set_unimap+0x118>
c0334068:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c033406d:=0966 31 c9             =09xor    %cx,%cx
c0334070:=09e9 5c 1c f2 ff       =09jmp    c0255cd1 <con_set_unimap+0x11c>
c0334075:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c033407a:=09e9 00 1d f2 ff       =09jmp    c0255d7f <con_get_trans_new+0x32=
>
c033407f:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0334084:=0930 d2                =09xor    %dl,%dl
c0334086:=09e9 30 1d f2 ff       =09jmp    c0255dbb <con_set_trans_old+0x2a=
>
c033408b:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0334090:=09e9 9c 1d f2 ff       =09jmp    c0255e31 <con_get_trans_old+0x51=
>
c0334095:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c033409a:=0966 31 d2             =09xor    %dx,%dx
c033409d:=09e9 cb 1d f2 ff       =09jmp    c0255e6d <con_set_trans_new+0x2b=
>
c03340a2:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c03340a7:=0966 31 f6             =09xor    %si,%si
c03340aa:=09e9 8e 1f f2 ff       =09jmp    c025603d <set_selection+0x48>
c03340af:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c03340b4:=0966 31 c9             =09xor    %cx,%cx
c03340b7:=09e9 8b 1f f2 ff       =09jmp    c0256047 <set_selection+0x52>
c03340bc:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c03340c1:=0966 31 f6             =09xor    %si,%si
c03340c4:=09e9 84 1f f2 ff       =09jmp    c025604d <set_selection+0x58>
c03340c9:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c03340ce:=0966 31 f6             =09xor    %si,%si
c03340d1:=09e9 81 1f f2 ff       =09jmp    c0256057 <set_selection+0x62>
c03340d6:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03340db:=0966 31 c0             =09xor    %ax,%ax
c03340de:=09e9 7c 1f f2 ff       =09jmp    c025605f <set_selection+0x6a>
c03340e3:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03340e8:=09e9 23 7c f2 ff       =09jmp    c025bd10 <tioclinux+0xa3>
c03340ed:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03340f2:=09e9 3c 7c f2 ff       =09jmp    c025bd33 <tioclinux+0xc6>
c03340f7:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c03340fc:=09e9 6a 7c f2 ff       =09jmp    c025bd6b <tioclinux+0xfe>
c0334101:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c0334106:=09e9 a2 ca f5 ff       =09jmp    c0290bad <scsi_ioctl+0x10a>
c033410b:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c0334110:=09e9 a1 ca f5 ff       =09jmp    c0290bb6 <scsi_ioctl+0x113>
c0334115:=09be f2 ff ff ff       =09mov    $0xfffffff2,%esi
c033411a:=0930 d2                =09xor    %dl,%dl
c033411c:=09e9 b2 01 f7 ff       =09jmp    c02a42d3 <sg_write+0x100>
c0334121:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c0334126:=09e9 06 07 f7 ff       =09jmp    c02a4831 <sg_ioctl+0x3f9>
c033412b:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c0334130:=09e9 04 07 f7 ff       =09jmp    c02a4839 <sg_ioctl+0x401>
c0334135:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c033413a:=09e9 02 07 f7 ff       =09jmp    c02a4841 <sg_ioctl+0x409>
c033413f:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c0334144:=09e9 00 07 f7 ff       =09jmp    c02a4849 <sg_ioctl+0x411>
c0334149:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c033414e:=09e9 ff 06 f7 ff       =09jmp    c02a4852 <sg_ioctl+0x41a>
c0334153:=09b9 f2 ff ff ff       =09mov    $0xfffffff2,%ecx
c0334158:=09e9 01 07 f7 ff       =09jmp    c02a485e <sg_ioctl+0x426>
c033415d:=09bf f2 ff ff ff       =09mov    $0xfffffff2,%edi
c0334162:=09e9 00 07 f7 ff       =09jmp    c02a4867 <sg_ioctl+0x42f>
c0334167:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c033416c:=09e9 ff 06 f7 ff       =09jmp    c02a4870 <sg_ioctl+0x438>
c0334171:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0334176:=09e9 fc 06 f7 ff       =09jmp    c02a4877 <sg_ioctl+0x43f>
c033417b:=09bb f2 ff ff ff       =09mov    $0xfffffff2,%ebx
c0334180:=09e9 76 07 f7 ff       =09jmp    c02a48fb <sg_ioctl+0x4c3>
c0334185:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c033418a:=09e9 32 09 f7 ff       =09jmp    c02a4ac1 <sg_ioctl+0x689>
c033418f:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c0334194:=0931 db                =09xor    %ebx,%ebx
c0334196:=09e9 f8 6d 10 00       =09jmp    c043af93 <pci_pcbios_init+0x31>
c033419b:=096a 00                =09push   $0x0
c033419d:=0907                   =09pop    %es
c033419e:=09e9 e7 c5 f9 ff       =09jmp    c02d078a <__restore_processor_st=
ate+0x26>
c03341a3:=096a 00                =09push   $0x0
c03341a5:=090f a1                =09pop    %fs
c03341a7:=09e9 e1 c5 f9 ff       =09jmp    c02d078d <__restore_processor_st=
ate+0x29>
c03341ac:=096a 00                =09push   $0x0
c03341ae:=090f a9                =09pop    %gs
c03341b0:=09e9 db c5 f9 ff       =09jmp    c02d0790 <__restore_processor_st=
ate+0x2c>
c03341b5:=096a 00                =09push   $0x0
c03341b7:=0917                   =09pop    %ss
c03341b8:=09e9 d6 c5 f9 ff       =09jmp    c02d0793 <__restore_processor_st=
ate+0x2f>
c03341bd:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03341c2:=09e9 88 cd f9 ff       =09jmp    c02d0f4f <rthal_strncpy_from_use=
r+0x17>
c03341c7:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03341cc:=09e9 b6 e4 f9 ff       =09jmp    c02d2687 <move_addr_to_user+0x61=
>
c03341d1:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03341d6:=09e9 1e e6 f9 ff       =09jmp    c02d27f9 <sys_recvmsg+0x16b>
c03341db:=09ba f2 ff ff ff       =09mov    $0xfffffff2,%edx
c03341e0:=09e9 2d e6 f9 ff       =09jmp    c02d2812 <sys_recvmsg+0x184>
c03341e5:=09b8 f2 ff ff ff       =09mov    $0xfffffff2,%eax
c03341ea:=0930 c9                =09xor    %cl,%cl
c03341ec:=09e9 85 cc ff ff       =09jmp    c0330e76 <proc_dodebug+0x67>
Disassembly of section .init.text:

c041a000 <no_halt>:
c041a000:=09c6 05 05 1c 41 c0 00 =09movb   $0x0,0xc0411c05
c041a007:=09b8 01 00 00 00       =09mov    $0x1,%eax
c041a00c:=09c3                   =09ret   =20

c041a00d <mca_pentium>:
c041a00d:=09c7 05 74 4a 45 c0 01 =09movl   $0x1,0xc0454a74
c041a014:=0900 00 00=20
c041a017:=09b8 01 00 00 00       =09mov    $0x1,%eax
c041a01c:=09c3                   =09ret   =20

c041a01d <no_387>:
c041a01d:=09c6 05 06 1c 41 c0 00 =09movb   $0x0,0xc0411c06
c041a024:=090f 20 c0             =09mov    %cr0,%eax
c041a027:=0983 c8 0e             =09or     $0xe,%eax
c041a02a:=090f 22 c0             =09mov    %eax,%cr0
c041a02d:=09b8 01 00 00 00       =09mov    $0x1,%eax
c041a032:=09c3                   =09ret   =20

c041a033 <nosmp>:
c041a033:=09c7 05 28 53 3d c0 00 =09movl   $0x0,0xc03d5328
c041a03a:=0900 00 00=20
c041a03d:=09b8 01 00 00 00       =09mov    $0x1,%eax
c041a042:=09c3                   =09ret   =20


=20


----- Original Nachricht ----
Von:     Philippe Gerum <rpm@xenomai.org>
An:      "M. Koehrer" <mathias_koehrer@domain.hid>
Datum:   27.04.2007 17:36
Betreff: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel

> On Fri, 2007-04-27 at 17:10 +0200, M. Koehrer wrote:
> > Hi Philippe,
> >=20
> > here is the next result (I have switched off the "quiet" kernel paramet=
er
> to get everything).
> >=20
>=20
> Thanks, I will look at this output asap. On your side, please run
> $ objdump -d vmlinux > foo
>=20
> then search for the kernel routine embodying the text address 0xc03e5680
> in the dump file (leftmost column). I'd be interested to see the
> disassembly of the entire routine.
>=20
> > IRQ 219 vectored at #e9
> > BUG: unable to handle kernel paging request at virtual address 511203b2
> >  printing eip:
> > c03e5680
> > *pde =3D 00000000
> > Oops: 0002 [#1]
> > SMP=20
> > Modules linked in: e1000
> > CPU:    0
> > EIP:    0060:[<c03e5680>]    Not tainted VLI
> > EFLAGS: 00010092   (2.6.20.4 #18)
> > EIP is at 0xc03e5680
> > eax: c011226c   ebx: 00000006   ecx: c0114375   edx: dfc1a000
> > esi: 00000046   edi: ffffffff   ebp: 00000000   esp: dfc1be24
> > ds: 007b   es: 007b   ss: 0068
> > Process ifconfig (pid: 1241, ti=3Ddfc1a000 task=3Ddfcb3030 task.ti=3Ddf=
c1a000)
> > Stack: 000000db 00000000 c03d9100 c010efa9 00006d80 00000001 00000060
> e099a210=20
> >        00000286 ffffff24 df7015c8 00000000 0000000f 00000001 c0103439
> df7015c8=20
> >        e099a0ff e09c0000 00000000 0000000f 00000001 80080740 c14a007b
> df70007b=20
> > Call Trace:
> >  [<c010efa9>] __ipipe_handle_irq+0x1b9/0x20b
> >  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
> >  [<c0103439>] common_interrupt+0x21/0x38
> >  [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
> >  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
> >  [<c02dcfb1>] __dev_mc_upload+0x1d/0x1e
> >  [<c02dd0d1>] dev_mc_upload+0x24/0x37
> >  [<c02db5dc>] dev_open+0x44/0x62
> >  [<c02da0a9>] dev_change_flags+0x47/0xe4
> >  [<c030d1c2>] devinet_ioctl+0x252/0x56f
> >  [<c02db1ba>] dev_ifsioc+0x113/0x38d
> >  [<c02d15d4>] sock_ioctl+0x0/0x1ad
> >  [<c02d1762>] sock_ioctl+0x18e/0x1ad
> >  [<c02d15d4>] sock_ioctl+0x0/0x1ad
> >  [<c015e1bf>] do_ioctl+0x1f/0x62
> >  [<c015e446>] vfs_ioctl+0x244/0x256
> >  [<c015e48b>] sys_ioctl+0x33/0x4c
> >  [<c01029f3>] sysenter_past_esp+0x6c/0x70
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 91 3d c0=
 00
> 91 3d c0 00 00 00 00 00 00 00 00 00 00 00 00 00=20
> > EIP: [<c03e5680>] 0xc03e5680 SS:ESP 0068:dfc1be24
> >  <0>Kernel panic - not syncing: Fatal exception in interrupt
> >  BUG: at arch/i386/kernel/smp.c:565 smp_call_function()
> >  [<c010b903>] smp_call_function+0x66/0x10a
> >  [<c0118e3a>] printk+0x62/0xd5
> >  [<c010b9c2>] smp_send_stop+0x1b/0x2b
> >  [<c01183d5>] panic+0x4d/0xe4
> >  [<c0103f71>] die+0x1f2/0x226
> >  [<c01116a4>] do_page_fault+0x447/0x517
> >  [<c013fbae>] __alloc_pages+0x52/0x286
> >  [<c010f643>] __ipipe_handle_exception+0xce/0x158
> >  [<c01521e3>] kmem_cache_alloc+0x5d/0x67
> >  [<c010bb1e>] smp_call_function_interrupt+0x31/0x4c
> >  [<c033339d>] error_code+0x81/0x90
> >  [<c0114375>] try_to_wake_up+0x33c/0x346
> >  [<c011226c>] __activate_task+0x1c/0x29
> >  [<c010efa9>] __ipipe_handle_irq+0x1b9/0x20b
> >  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
> >  [<c0103439>] common_interrupt+0x21/0x38
> >  [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
> >  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
> >  [<c02dcfb1>] __dev_mc_upload+0x1d/0x1e
> >  [<c02dd0d1>] dev_mc_upload+0x24/0x37
> >  [<c02db5dc>] dev_open+0x44/0x62
> >  [<c02da0a9>] dev_change_flags+0x47/0xe4
> >  [<c030d1c2>] devinet_ioctl+0x252/0x56f
> >  [<c02db1ba>] dev_ifsioc+0x113/0x38d
> >  [<c02d15d4>] sock_ioctl+0x0/0x1ad
> >  [<c02d1762>] sock_ioctl+0x18e/0x1ad
> >  [<c02d15d4>] sock_ioctl+0x0/0x1ad
> >  [<c015e1bf>] do_ioctl+0x1f/0x62
> >  [<c015e446>] vfs_ioctl+0x244/0x256
> >  [<c015e48b>] sys_ioctl+0x33/0x4c
> >  [<c01029f3>] sysenter_past_esp+0x6c/0x70
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> >=20
> >=20
> >=20
> > ----- Original Nachricht ----
> > Von:     Philippe Gerum <rpm@xenomai.org>
> > An:      "M. Koehrer" <mathias_koehrer@domain.hid>
> > Datum:   27.04.2007 17:05
> > Betreff: Re: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
> >=20
> > > On Fri, 2007-04-27 at 16:56 +0200, Philippe Gerum wrote:
> > > > On Fri, 2007-04-27 at 16:28 +0200, M. Koehrer wrote:
> > > > > Hello Philippe,
> > > > >=20
> > > > > here it is: (I have no idea what BUGON does...)
> > > > >=20
> > > >=20
> > > > This patch will print out the irq/vector mappings. I'm interested i=
n
> > > > reading this output.
> > > >=20
> > > > --- arch/i386/kernel/io_apic.c~=092007-02-26 10:31:39.000000000 +01=
00
> > > > +++ arch/i386/kernel/io_apic.c=092007-04-27 16:51:51.000000000 +020=
0
> > > > @@ -1259,6 +1259,7 @@
> > > >  =09current_vector =3D vector;
> > > >  =09current_offset =3D offset;
> > > >  =09irq_vector[irq] =3D vector;
> > > > +=09printk("IRQ %d vectored at #%2x\n", irq, vector);
> > >=20
> > > Please s/%2x/%.2x
> > >=20
> > > > =20
> > > >  =09return vector;
> > > >  }
> > > >=20
> > > --=20
> > > Philippe.
> > >=20
> > >=20
> > >=20
> >=20
> --=20
> Philippe.
>=20
>=20
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


50=80 AMAZON-Einkaufsgutschein bei Bestellung von Arcor-DSL:
Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

