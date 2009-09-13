MIME-Version: 1.0
Date: Sun, 13 Sep 2009 15:35:58 +0300
Message-ID: <9c789a000909130535j4dc046a1h3af2976ab504a000@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d566a1909330047374cad0
Subject: [Xenomai-core] Comedi port over Xenomai fault question !
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org, Alexis Berlemont <berlemont.hauw@domain.hid>, Alexis Berlemont <alexis.berlemont@domain.hid>

--0016e6d566a1909330047374cad0
Content-Type: text/plain; charset=ISO-8859-1

Hello !
I've took a snapshot of the xenomai-abe (Comedi port related) git repos
pointing to the last update and tried it up and it seems that are some
errors.

/usr/xenomai/sbin # ./comedi_config -v comedi0 comedi_pcimio
Comedi: comedi_pcimio: pcimio_attach: found pci-6024e board
Comedi: MITE: 0x90000000 mapped to c907a000 <6>Comedi: DAQ: 0x90001000
mapped to c907c000
Comedi: MITE: version = 2, type = 1, mite mode = 1, interface mode = 3
Comedi: MITE: num channels = 1, write post fifo depth = 1, wins = 0, iowins
= 2
Comedi: comedi_pcimio: pcimio_attach: found irq 48
Unable to handle kernel paging request for data at address 0x00012400
Faulting instruction address:* 0xc023dd08*
Oops: Kernel access of bad area, sig: 11 [#1]
MPC831x RDB
Modules linked in:
*NIP: c023dd08* LR: c0246b70 CTR: 00000000
REGS: c7a51c30 TRAP: 0300   Not tainted  (2.6.24.2)
MSR: 00001032 <ME,IR,DR>  CR: 84008422  XER: 00000000
DAR: 00012400, DSISR: 20000000
TASK = c7864430[898] 'comedi_config' THREAD: c7a50000
GPR00: c0246b70 c7a51ce0 c7864430 00012400 00000001 00000000 c79062c0
c03c0000
GPR08: 00000000 c7900a00 c03d6144 c03a37e8 c7906200 1004a5b8 c033e0b8
c03c0000
GPR16: c03ba578 c03d1a00 c02464fc c03b4d60 c0244e5c c024509c c024535c
c0245380
GPR24: c03da628 c02453a4 20001040 00000000 00000000 c03a2e50 c03c0000
00012400
Call Trace:
[c7a51ce0] [c024bae0]  (unreliable)
[c7a51d00] [c0246b70]
[c7a51d20] [c0246bdc]
[c7a51d40] [c024b88c]
[c7a51d90] [c024c69c]
[c7a51dc0] [c0238b2c]
[c7a51de0] [c0238c64]
[c7a51e20] [c0239094]
[c7a51e40] [c023ba00]
[c7a51e70] [c008b404]
[c7a51eb0] [c008d634]
[c7a51ec0] [c0059eb8]
[c7a51ee0] [c004ad5c]
[c7a51f30] [c0009644]
[c7a51f40] [c0010ca4]
--- Exception: c01Instruction dump:
7d6b1a14 39290010 38000001 7fe34a14 900b00b0 90ff0010 4bffff9c 9421ffe0
7c0802a6 bf61000c 7c7f1b78 90010024 <83c30000> 7c0000a6 5400045e 7c000124
---[ end trace f35e90f95f5de008 ]---


A quick disassembly shows that the error is generated in the mite driver as
pointed next,

c023dcf4 <mite_release_channel>:
mite_release_channel():
/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-xc1/drivers/xenomai/comedi/national_instruments/mite.c:308
c023dcf4:    94 21 ff e0     stwu    r1,-32(r1)
c023dcf8:    7c 08 02 a6     mflr    r0
c023dcfc:    bf 61 00 0c     stmw    r27,12(r1)
c023dd00:    7c 7f 1b 78     mr      r31,r3
c023dd04:    90 01 00 24     stw     r0,36(r1)
/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-xc1/drivers/xenomai/comedi/national_instruments/mite.c:309
*c023dd08:*    83 c3 00 00     lwz     r30,0(r3)


Some hints would be appreciated !

Best !

--0016e6d566a1909330047374cad0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello !<br>I&#39;ve took a snapshot of the xenomai-abe (Comedi port related=
) git repos pointing to the last update and tried it up and it seems that a=
re some errors.<br><br>/usr/xenomai/sbin # ./comedi_config -v comedi0 comed=
i_pcimio<br>
Comedi: comedi_pcimio: pcimio_attach: found pci-6024e board<br>Comedi: MITE=
: 0x90000000 mapped to c907a000 &lt;6&gt;Comedi: DAQ: 0x90001000 mapped to =
c907c000<br>Comedi: MITE: version =3D 2, type =3D 1, mite mode =3D 1, inter=
face mode =3D 3<br>
Comedi: MITE: num channels =3D 1, write post fifo depth =3D 1, wins =3D 0, =
iowins =3D 2<br>Comedi: comedi_pcimio: pcimio_attach: found irq 48<br>Unabl=
e to handle kernel paging request for data at address 0x00012400<br>Faultin=
g instruction address:<b> 0xc023dd08</b><br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>MPC831x RDB<br>Modules lin=
ked in:<br><b>NIP: c023dd08</b> LR: c0246b70 CTR: 00000000<br>REGS: c7a51c3=
0 TRAP: 0300=A0=A0 Not tainted=A0 (2.6.24.2)<br>MSR: 00001032 &lt;ME,IR,DR&=
gt;=A0 CR: 84008422=A0 XER: 00000000<br>
DAR: 00012400, DSISR: 20000000<br>TASK =3D c7864430[898] &#39;comedi_config=
&#39; THREAD: c7a50000<br>GPR00: c0246b70 c7a51ce0 c7864430 00012400 000000=
01 00000000 c79062c0 c03c0000 <br>GPR08: 00000000 c7900a00 c03d6144 c03a37e=
8 c7906200 1004a5b8 c033e0b8 c03c0000 <br>
GPR16: c03ba578 c03d1a00 c02464fc c03b4d60 c0244e5c c024509c c024535c c0245=
380 <br>GPR24: c03da628 c02453a4 20001040 00000000 00000000 c03a2e50 c03c00=
00 00012400 <br>Call Trace:<br>[c7a51ce0] [c024bae0]=A0 (unreliable)<br>[c7=
a51d00] [c0246b70] <br>
[c7a51d20] [c0246bdc] <br>[c7a51d40] [c024b88c] <br>[c7a51d90] [c024c69c] <=
br>[c7a51dc0] [c0238b2c] <br>[c7a51de0] [c0238c64] <br>[c7a51e20] [c0239094=
] <br>[c7a51e40] [c023ba00] <br>[c7a51e70] [c008b404] <br>[c7a51eb0] [c008d=
634] <br>
[c7a51ec0] [c0059eb8] <br>[c7a51ee0] [c004ad5c] <br>[c7a51f30] [c0009644] <=
br>[c7a51f40] [c0010ca4] <br>--- Exception: c01Instruction dump:<br>7d6b1a1=
4 39290010 38000001 7fe34a14 900b00b0 90ff0010 4bffff9c 9421ffe0 <br>7c0802=
a6 bf61000c 7c7f1b78 90010024 &lt;83c30000&gt; 7c0000a6 5400045e 7c000124 <=
br>
---[ end trace f35e90f95f5de008 ]---<br><br><br>A quick disassembly shows t=
hat the error is generated in the mite driver as pointed next, <br><br>c023=
dcf4 &lt;mite_release_channel&gt;:<br>mite_release_channel():<br>/home/haus=
tiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-xc1/drivers/xenomai/comed=
i/national_instruments/mite.c:308<br>
c023dcf4:=A0=A0=A0 94 21 ff e0 =A0=A0=A0 stwu=A0=A0=A0 r1,-32(r1)<br>c023dc=
f8:=A0=A0=A0 7c 08 02 a6 =A0=A0=A0 mflr=A0=A0=A0 r0<br>c023dcfc:=A0=A0=A0 b=
f 61 00 0c =A0=A0=A0 stmw=A0=A0=A0 r27,12(r1)<br>c023dd00:=A0=A0=A0 7c 7f 1=
b 78 =A0=A0=A0 mr=A0=A0=A0=A0=A0 r31,r3<br>c023dd04:=A0=A0=A0 90 01 00 24 =
=A0=A0=A0 stw=A0=A0=A0=A0 r0,36(r1)<br>
/home/haustiq/development/eldk/ppc_6xx/usr/src/linux-2.6.24-xc1/drivers/xen=
omai/comedi/national_instruments/mite.c:309<br><b>c023dd08:</b>=A0=A0=A0 83=
 c3 00 00 =A0=A0=A0 lwz=A0=A0=A0=A0 r30,0(r3)<br><br><br>Some hints would b=
e appreciated !<br>
<br>Best !<br>

--0016e6d566a1909330047374cad0--

