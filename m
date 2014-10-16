Message-ID: <1413464642.48297.YahooMailNeo@web141701.mail.bf1.yahoo.com>
Date: Thu, 16 Oct 2014 06:04:02 -0700
From: =?iso-8859-1?Q?R=F3bert_Marc?= <rob_marc2003@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai]  RTDM problem with Advantech PCM-3680I
Reply-To: =?iso-8859-1?Q?R=F3bert_Marc?= <rob_marc2003@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Xenomai community,=0A=0AI am experiencing problems with my Advantech c=
ard under Xenomai.=0APlease note that the card (Advantech PCM-3680I) functi=
ons perfectly under non-RT Linux (Ubuntu 12.04). I can send and receive mes=
sages.=0AAlthough the modules are loaded the devices can't be seen. See det=
ails below.=0A=0A=0AHere are some technical details:=0A=0Artos@rtos-pc-104:=
~$ sudo rtcanconfig rtcan0 -b 1000000 -v start=0Amode: start (0x1)=0ACan't =
get interface index for rtcan0, code =3D -19=0A=0A=0A>>  what is error code=
 -19?=0A=0A=0Artos@rtos-pc-104:~$ lsmod | grep adv=0Axeno_can_adv_pci      =
 12730  0 =0Aadvcan                             707511  4 =0Axeno_can_sja10=
00       17366  1 xeno_can_adv_pci=0Axeno_can                         28373=
  2 xeno_can_adv_pci,xeno_can_sja1000=0A=0A=0A>> drivers are loaded =0A=0A=
=0Artos@rtos-pc-104:~$ dmesg | grep CAN=0A[    4.341607] RT-Socket-CAN 0.90=
.2 - (C) 2006 RT-Socket-CAN Development Team=0A[    4.372061] RTCAN SJA1000=
 driver initialized=0A[    4.405671] ADV-PCI-CAN 0000:01:04.0: RTCAN Regist=
ering card=0A[    4.405697] ADV-PCI-CAN 0000:01:04.0: RTCAN detected Advant=
ech PCI card at slot #4=0A[    4.405712] ADV-PCI-CAN: Initializing device 1=
3fe:c002:c002=0A[    4.405731] ADV-PCI-CAN: base_addr=3D0001ef00 conf_addr=
=3D  (null) irq=3D16 ocr=3D0xfa cdr=3D0xc0=0A[    4.405811] RTCAN: unregist=
ered rtcan0=0A[    4.405836] ADV-PCI-CAN: probe of 0000:01:04.0 failed with=
 error -5=0A[    4.494279] CAN Communication Driver.=0A[    4.514136] Advan=
tech CAN Port CAN Driver (c) Oct  3 2014 15:12:52=0A[    4.514202] Advanteh=
 PCI CAN devie c002 found( 2 CAN port)=0A=0A=0A>> conf_addr=3D  (null) migh=
t be the problem???=0A=0Artos@rtos-pc-104:~$ dmesg | grep rtcan=0A[    4.40=
5777] rtcan: registered rtcan0=0A[    4.405795] Unregistering SJA1000 devic=
e rtcan0=0A[    4.405811] RTCAN: unregistered rtcan0=0A=0A=0Artos@rtos-pc-1=
04:~$ cat /proc/rtcan/devices =0AName___________ _Baudrate State___ TX_Coun=
ter RX_Counter ____Errors=0Artos@rtos-pc-104:~$ =0A=0Artos@rtos-pc-104:~$ c=
at /proc/rtcan/sockets =0Afd Name___________ Filter ErrMask RX_Timeout_ns T=
X_Timeout_ns RX_BufFull TX_Lo=0A=0A=0AKernel: 3.5.7=0AXenomai: 2.6.3=0A=0A=
=0ATo show that I am running under Xenomai, and the Xenomai core is fully f=
unctional:=0A=0Artos@rtos-pc-104:~$ dmesg | grep Xenom=0A[    0.862003] I-p=
ipe: head domain Xenomai registered.=0A[    0.862077] Xenomai: hal/i386 sta=
rted.=0A[    0.862125] Xenomai: scheduling class idle registered.=0A[    0.=
862130] Xenomai: scheduling class rt registered.=0A[    0.864945] Xenomai: =
real-time nucleus v2.6.3 (Lies and Truths) loaded.=0A[    0.864951] Xenomai=
: debug mode enabled.=0A[    0.865124] Xenomai: SMI-enabled chipset found, =
but SMI workaround disabled=0A[    0.865190] Xenomai: starting native API s=
ervices.=0A[    0.865197] Xenomai: starting POSIX services.=0A[    0.865246=
] Xenomai: starting RTDM services.=0A =0A=0AAny ideas how can I solve this =
issue?=0A=0AThanks,=0ARobert=0A
