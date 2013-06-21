References: <mailman.1.1371808801.4609.xenomai@xenomai.org>
Message-ID: <1371820048.30624.YahooMailNeo@web172205.mail.ir2.yahoo.com>
Date: Fri, 21 Jun 2013 14:07:28 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
In-Reply-To: <mailman.1.1371808801.4609.xenomai@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] High latency and smi with intel vendor chip
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=0AIn my dmesg I get the following message:=0Admesg | grep -i xeno=0A=
[=A0=A0=A0 4.478964] I-pipe: head domain Xenomai registered.=0A[=A0=A0=A0 4=
.494089] Xenomai: hal/x86_64 started.=0A[=A0=A0=A0 4.505969] Xenomai: sched=
uling class idle registered.=0A[=A0=A0=A0 4.521300] Xenomai: scheduling cla=
ss rt registered.=0A[=A0=A0=A0 4.538525] Xenomai: real-time nucleus v2.6.2.=
1 (Day At The Beach) loaded.=0A[=A0=A0=A0 4.559065] Xenomai: debug mode ena=
bled.=0A[=A0=A0=A0 4.579351] Xenomai: SMI-enabled chipset found=0A[=A0=A0=
=A0 4.592628] Xenomai: SMI workaround failed!=0A[=A0=A0=A0 4.605677] Xenoma=
i: starting native API services.=0A[=A0=A0=A0 4.619979] Xenomai: starting P=
OSIX services.=0A[=A0=A0=A0 4.633088] Xenomai: starting RTDM services.=0A=
=0A=0AAnd I have very high latencies. I read that I should try to insert my=
 the ID of my LCP into the /usr/src/xenomai/ksrc/arch/x86/smi.c file. But I=
'm not sure how. I would try it like this:=0A{PCI_DEVICE(PCI_VENDOR_ID_INTE=
L, PCI_DEVICE_ID_INTEL_82801JIR_0)}=0ABut I don't know if the "0" is correc=
t. Is the last sign the "rev"? I this case, what is my last sign?=0A=0AIn g=
eneral, is it a good idea to disable the ISA Bridge with the smi.c file?=0A=
=0AWhat I have to do after modifing this file? Do I have to recompile my ke=
rnel, or is it enough to make/make install xenomai?=0A=0A=0AThats the outpu=
t of lcpi:=0Alspci -n=0A00:00.0 0600: 8086:3403 (rev 22)=0A00:01.0 0604: 80=
86:3408 (rev 22)=0A00:02.0 0604: 8086:3409 (rev 22)=0A00:03.0 0604: 8086:34=
0a (rev 22)=0A00:07.0 0604: 8086:340e (rev 22)=0A00:08.0 0604: 8086:340f (r=
ev 22)=0A00:09.0 0604: 8086:3410 (rev 22)=0A00:0a.0 0604: 8086:3411 (rev 22=
)=0A00:10.0 0800: 8086:3425 (rev 22)=0A00:10.1 0800: 8086:3426 (rev 22)=0A0=
0:11.0 0800: 8086:3427 (rev 22)=0A00:11.1 0800: 8086:3428 (rev 22)=0A00:14.=
0 0800: 8086:342e (rev 22)=0A00:14.1 0800: 8086:3422 (rev 22)=0A00:14.2 080=
0: 8086:3423 (rev 22)=0A00:14.3 0800: 8086:3438 (rev 22)=0A00:16.0 0880: 80=
86:3430 (rev 22)=0A00:16.1 0880: 8086:3431 (rev 22)=0A00:16.2 0880: 8086:34=
32 (rev 22)=0A00:16.3 0880: 8086:3433 (rev 22)=0A00:16.4 0880: 8086:3429 (r=
ev 22)=0A00:16.5 0880: 8086:342a (rev 22)=0A00:16.6 0880: 8086:342b (rev 22=
)=0A00:16.7 0880: 8086:342c (rev 22)=0A00:1a.0 0c03: 8086:3a37=0A00:1a.1 0c=
03: 8086:3a38=0A00:1a.7 0c03: 8086:3a3c=0A00:1b.0 0403: 8086:3a3e=0A00:1c.0=
 0604: 8086:3a40=0A00:1c.4 0604: 8086:3a48=0A00:1c.5 0604: 8086:3a4a=0A00:1=
d.0 0c03: 8086:3a34=0A00:1d.1 0c03: 8086:3a35=0A00:1d.2 0c03: 8086:3a36=0A0=
0:1d.3 0c03: 8086:3a39=0A00:1d.7 0c03: 8086:3a3a=0A00:1e.0 0604: 8086:244e =
(rev 90)=0A00:1f.0 0601: 8086:3a16=0A00:1f.2 0101: 8086:3a20=0A00:1f.3 0c05=
: 8086:3a30=0A00:1f.5 0101: 8086:3a26=0A02:00.0 0200: 8086:10d3=0A03:00.0 0=
200: 8086:10d3=0A08:00.0 0300: 1002:9552=0A08:00.1 0403: 1002:aa38=0A09:00.=
0 0200: 8086:105e (rev 06)=0A09:00.1 0200: 8086:105e (rev 06)=0A0b:00.0 020=
0: 8086:105e (rev 06)=0A0b:00.1 0200: 8086:105e (rev 06)=0A=0A=0Alspci -v=
=0A00:00.0 Host bridge: Intel Corporation 5500 I/O Hub to ESI Port (rev 22)=
=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8363=0A=A0=A0=A0 Flags=
: fast devsel=0A=A0=A0=A0 Capabilities: [60] MSI: Enable- Count=3D1/2 Maska=
ble+ 64bit-=0A=A0=A0=A0 Capabilities: [90] Express Root Port (Slot-), MSI 0=
0=0A=A0=A0=A0 Capabilities: [e0] Power Management version 3=0A=0A00:01.0 PC=
I bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 (=
rev 22) (prog-if 00 [Normal decode])=0A=A0=A0=A0 Flags: bus master, fast de=
vsel, latency 0=0A=A0=A0=A0 Bus: primary=3D00, secondary=3D0b, subordinate=
=3D0b, sec-latency=3D0=0A=A0=A0=A0 I/O behind bridge: 0000e000-0000efff=0A=
=A0=A0=A0 Memory behind bridge: fbe00000-fbefffff=0A=A0=A0=A0 Capabilities:=
 [40] Subsystem: ASUSTeK Computer Inc. Device 8363=0A=A0=A0=A0 Capabilities=
: [60] MSI: Enable- Count=3D1/2 Maskable+ 64bit-=0A=A0=A0=A0 Capabilities: =
[90] Express Root Port (Slot+), MSI 00=0A=A0=A0=A0 Capabilities: [e0] Power=
 Management version 3=0A=A0=A0=A0 Kernel driver in use: pcieport=0A=0A00:02=
.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Por=
t 2 (rev 22) (prog-if 00 [Normal decode])=0A=A0=A0=A0 Flags: bus master, fa=
st devsel, latency 0=0A=A0=A0=A0 Bus: primary=3D00, secondary=3D0a, subordi=
nate=3D0a, sec-latency=3D0=0A=A0=A0=A0 Capabilities: [40] Subsystem: ASUSTe=
K Computer Inc. Device 8363=0A=A0=A0=A0 Capabilities: [60] MSI: Enable- Cou=
nt=3D1/2 Maskable+ 64bit-=0A=A0=A0=A0 Capabilities: [90] Express Root Port =
(Slot+), MSI 00=0A=A0=A0=A0 Capabilities: [e0] Power Management version 3=
=0A=A0=A0=A0 Kernel driver in use: pcieport=0A=0A00:03.0 PCI bridge: Intel =
Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 3 (rev 22) (prog-if=
 00 [Normal decode])=0A=A0=A0=A0 Flags: bus master, fast devsel, latency 0=
=0A=A0=A0=A0 Bus: primary=3D00, secondary=3D09, subordinate=3D09, sec-laten=
cy=3D0=0A=A0=A0=A0 I/O behind bridge: 0000d000-0000dfff=0A=A0=A0=A0 Memory =
behind bridge: fbd00000-fbdfffff=0A=A0=A0=A0 Capabilities: [40] Subsystem: =
ASUSTeK Computer Inc. Device 8363=0A=A0=A0=A0 Capabilities: [60] MSI: Enabl=
e- Count=3D1/2 Maskable+ 64bit-=0A=A0=A0=A0 Capabilities: [90] Express Root=
 Port (Slot+), MSI 00=0A=A0=A0=A0 Capabilities: [e0] Power Management versi=
on 3=0A=A0=A0=A0 Kernel driver in use: pcieport=0A=0A00:07.0 PCI bridge: In=
tel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 7 (rev 22) (pro=
g-if 00 [Normal decode])=0A=A0=A0=A0 Flags: bus master, fast devsel, latenc=
y 0=0A=A0=A0=A0 Bus: primary=3D00, secondary=3D08, subordinate=3D08, sec-la=
tency=3D0=0A=A0=A0=A0 I/O behind bridge: 0000c000-0000cfff=0A=A0=A0=A0 Memo=
ry behind bridge: fbc00000-fbcfffff=0A=A0=A0=A0 Prefetchable memory behind =
bridge: 00000000d0000000-00000000dfffffff=0A=A0=A0=A0 Capabilities: [40] Su=
bsystem: ASUSTeK Computer Inc. Device 8363=0A=A0=A0=A0 Capabilities: [60] M=
SI: Enable- Count=3D1/2 Maskable+ 64bit-=0A=A0=A0=A0 Capabilities: [90] Exp=
ress Root Port (Slot+), MSI 00=0A=A0=A0=A0 Capabilities: [e0] Power Managem=
ent version 3=0A=A0=A0=A0 Kernel driver in use: pcieport=0A=0A00:08.0 PCI b=
ridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 8 (rev=
 22) (prog-if 00 [Normal decode])=0A=A0=A0=A0 Flags: bus master, fast devse=
l, latency 0=0A=A0=A0=A0 Bus: primary=3D00, secondary=3D07, subordinate=3D0=
7, sec-latency=3D0=0A=A0=A0=A0 Capabilities: [40] Subsystem: ASUSTeK Comput=
er Inc. Device 8363=0A=A0=A0=A0 Capabilities: [60] MSI: Enable- Count=3D1/2=
 Maskable+ 64bit-=0A=A0=A0=A0 Capabilities: [90] Express Root Port (Slot+),=
 MSI 00=0A=A0=A0=A0 Capabilities: [e0] Power Management version 3=0A=A0=A0=
=A0 Kernel driver in use: pcieport=0A=0A00:09.0 PCI bridge: Intel Corporati=
on 5520/5500/X58 I/O Hub PCI Express Root Port 9 (rev 22) (prog-if 00 [Norm=
al decode])=0A=A0=A0=A0 Flags: bus master, fast devsel, latency 0=0A=A0=A0=
=A0 Bus: primary=3D00, secondary=3D06, subordinate=3D06, sec-latency=3D0=0A=
=A0=A0=A0 Capabilities: [40] Subsystem: ASUSTeK Computer Inc. Device 8363=
=0A=A0=A0=A0 Capabilities: [60] MSI: Enable- Count=3D1/2 Maskable+ 64bit-=
=0A=A0=A0=A0 Capabilities: [90] Express Root Port (Slot+), MSI 00=0A=A0=A0=
=A0 Capabilities: [e0] Power Management version 3=0A=A0=A0=A0 Kernel driver=
 in use: pcieport=0A=0A00:0a.0 PCI bridge: Intel Corporation 5520/5500/X58 =
I/O Hub PCI Express Root Port 10 (rev 22) (prog-if 00 [Normal decode])=0A=
=A0=A0=A0 Flags: bus master, fast devsel, latency 0=0A=A0=A0=A0 Bus: primar=
y=3D00, secondary=3D05, subordinate=3D05, sec-latency=3D0=0A=A0=A0=A0 Capab=
ilities: [40] Subsystem: ASUSTeK Computer Inc. Device 8363=0A=A0=A0=A0 Capa=
bilities: [60] MSI: Enable- Count=3D1/2 Maskable+ 64bit-=0A=A0=A0=A0 Capabi=
lities: [90] Express Root Port (Slot+), MSI 00=0A=A0=A0=A0 Capabilities: [e=
0] Power Management version 3=0A=A0=A0=A0 Kernel driver in use: pcieport=0A=
=0A00:10.0 PIC: Intel Corporation 5520/5500/X58 Physical and Link Layer Reg=
isters Port 0 (rev 22) (prog-if 00 [8259])=0A=A0=A0=A0 Subsystem: Device 00=
43:0063=0A=A0=A0=A0 Flags: fast devsel=0A=A0=A0=A0 Capabilities: [50] Vendo=
r Specific Information: Len=3Dff <?>=0A=0A00:10.1 PIC: Intel Corporation 55=
20/5500/X58 Routing and Protocol Layer Registers Port 0 (rev 22) (prog-if 0=
0 [8259])=0A=A0=A0=A0 Subsystem: Device 0043:0063=0A=A0=A0=A0 Flags: fast d=
evsel=0A=0A00:11.0 PIC: Intel Corporation 5520/5500 Physical and Link Layer=
 Registers Port 1 (rev 22) (prog-if 00 [8259])=0A=A0=A0=A0 Subsystem: Devic=
e 0043:0063=0A=A0=A0=A0 Flags: fast devsel=0A=A0=A0=A0 Capabilities: [50] V=
endor Specific Information: Len=3Dff <?>=0A=0A00:11.1 PIC: Intel Corporatio=
n 5520/5500 Routing & Protocol Layer Register Port 1 (rev 22) (prog-if 00 [=
8259])=0A=A0=A0=A0 Subsystem: Device 0043:0063=0A=A0=A0=A0 Flags: fast devs=
el=0A=0A00:14.0 PIC: Intel Corporation 5520/5500/X58 I/O Hub System Managem=
ent Registers (rev 22) (prog-if 00 [8259])=0A=A0=A0=A0 Subsystem: Device 00=
43:0063=0A=A0=A0=A0 Flags: fast devsel=0A=A0=A0=A0 Capabilities: [40] Expre=
ss Root Complex Integrated Endpoint, MSI 00=0A=0A00:14.1 PIC: Intel Corpora=
tion 5520/5500/X58 I/O Hub GPIO and Scratch Pad Registers (rev 22) (prog-if=
 00 [8259])=0A=A0=A0=A0 Subsystem: Device 0043:0063=0A=A0=A0=A0 Flags: fast=
 devsel=0A=A0=A0=A0 Capabilities: [40] Express Root Complex Integrated Endp=
oint, MSI 00=0A=0A00:14.2 PIC: Intel Corporation 5520/5500/X58 I/O Hub Cont=
rol Status and RAS Registers (rev 22) (prog-if 00 [8259])=0A=A0=A0=A0 Subsy=
stem: Device 0043:0063=0A=A0=A0=A0 Flags: fast devsel=0A=A0=A0=A0 Capabilit=
ies: [40] Express Root Complex Integrated Endpoint, MSI 00=0A=0A00:14.3 PIC=
: Intel Corporation 5520/5500/X58 I/O Hub Throttle Registers (rev 22) (prog=
-if 00 [8259])=0A=A0=A0=A0 Subsystem: Device 0043:0063=0A=A0=A0=A0 Flags: f=
ast devsel=0A=0A00:16.0 System peripheral: Intel Corporation 5520/5500/X58 =
Chipset QuickData Technology Device (rev 22)=0A=A0=A0=A0 Subsystem: ASUSTeK=
 Computer Inc. Device 8363=0A=A0=A0=A0 Flags: fast devsel, IRQ 43=0A=A0=A0=
=A0 Memory at fb9d8000 (64-bit, non-prefetchable) [size=3D16K]=0A=A0=A0=A0 =
Capabilities: [80] MSI-X: Enable- Count=3D1 Masked-=0A=A0=A0=A0 Capabilitie=
s: [90] Express Root Complex Integrated Endpoint, MSI 00=0A=A0=A0=A0 Capabi=
lities: [e0] Power Management version 3=0A=A0=A0=A0 Kernel modules: ioatdma=
=0A=0A00:16.1 System peripheral: Intel Corporation 5520/5500/X58 Chipset Qu=
ickData Technology Device (rev 22)=0A=A0=A0=A0 Subsystem: ASUSTeK Computer =
Inc. Device 8363=0A=A0=A0=A0 Flags: fast devsel, IRQ 44=0A=A0=A0=A0 Memory =
at fb9dc000 (64-bit, non-prefetchable) [size=3D16K]=0A=A0=A0=A0 Capabilitie=
s: [80] MSI-X: Enable- Count=3D1 Masked-=0A=A0=A0=A0 Capabilities: [90] Exp=
ress Root Complex Integrated Endpoint, MSI 00=0A=A0=A0=A0 Capabilities: [e0=
] Power Management version 3=0A=A0=A0=A0 Kernel modules: ioatdma=0A=0A00:16=
.2 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Tec=
hnology Device (rev 22)=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device=
 8363=0A=A0=A0=A0 Flags: fast devsel, IRQ 45=0A=A0=A0=A0 Memory at fb9e0000=
 (64-bit, non-prefetchable) [size=3D16K]=0A=A0=A0=A0 Capabilities: [80] MSI=
-X: Enable- Count=3D1 Masked-=0A=A0=A0=A0 Capabilities: [90] Express Root C=
omplex Integrated Endpoint, MSI 00=0A=A0=A0=A0 Capabilities: [e0] Power Man=
agement version 3=0A=A0=A0=A0 Kernel modules: ioatdma=0A=0A00:16.3 System p=
eripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Dev=
ice (rev 22)=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8363=0A=A0=
=A0=A0 Flags: fast devsel, IRQ 46=0A=A0=A0=A0 Memory at fb9e4000 (64-bit, n=
on-prefetchable) [size=3D16K]=0A=A0=A0=A0 Capabilities: [80] MSI-X: Enable-=
 Count=3D1 Masked-=0A=A0=A0=A0 Capabilities: [90] Express Root Complex Inte=
grated Endpoint, MSI 00=0A=A0=A0=A0 Capabilities: [e0] Power Management ver=
sion 3=0A=A0=A0=A0 Kernel modules: ioatdma=0A=0A00:16.4 System peripheral: =
Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22=
)=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8363=0A=A0=A0=A0 Flag=
s: fast devsel, IRQ 43=0A=A0=A0=A0 Memory at fb9e8000 (64-bit, non-prefetch=
able) [size=3D16K]=0A=A0=A0=A0 Capabilities: [80] MSI-X: Enable- Count=3D1 =
Masked-=0A=A0=A0=A0 Capabilities: [90] Express Root Complex Integrated Endp=
oint, MSI 00=0A=A0=A0=A0 Capabilities: [e0] Power Management version 3=0A=
=A0=A0=A0 Kernel modules: ioatdma=0A=0A00:16.5 System peripheral: Intel Cor=
poration 5520/5500/X58 Chipset QuickData Technology Device (rev 22)=0A=A0=
=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8363=0A=A0=A0=A0 Flags: fast=
 devsel, IRQ 44=0A=A0=A0=A0 Memory at fb9ec000 (64-bit, non-prefetchable) [=
size=3D16K]=0A=A0=A0=A0 Capabilities: [80] MSI-X: Enable- Count=3D1 Masked-=
=0A=A0=A0=A0 Capabilities: [90] Express Root Complex Integrated Endpoint, M=
SI 00=0A=A0=A0=A0 Capabilities: [e0] Power Management version 3=0A=A0=A0=A0=
 Kernel modules: ioatdma=0A=0A00:16.6 System peripheral: Intel Corporation =
5520/5500/X58 Chipset QuickData Technology Device (rev 22)=0A=A0=A0=A0 Subs=
ystem: ASUSTeK Computer Inc. Device 8363=0A=A0=A0=A0 Flags: fast devsel, IR=
Q 45=0A=A0=A0=A0 Memory at fb9f0000 (64-bit, non-prefetchable) [size=3D16K]=
=0A=A0=A0=A0 Capabilities: [80] MSI-X: Enable- Count=3D1 Masked-=0A=A0=A0=
=A0 Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 00=0A=
=A0=A0=A0 Capabilities: [e0] Power Management version 3=0A=A0=A0=A0 Kernel =
modules: ioatdma=0A=0A00:16.7 System peripheral: Intel Corporation 5520/550=
0/X58 Chipset QuickData Technology Device (rev 22)=0A=A0=A0=A0 Subsystem: A=
SUSTeK Computer Inc. Device 8363=0A=A0=A0=A0 Flags: fast devsel, IRQ 46=0A=
=A0=A0=A0 Memory at fb9f4000 (64-bit, non-prefetchable) [size=3D16K]=0A=A0=
=A0=A0 Capabilities: [80] MSI-X: Enable- Count=3D1 Masked-=0A=A0=A0=A0 Capa=
bilities: [90] Express Root Complex Integrated Endpoint, MSI 00=0A=A0=A0=A0=
 Capabilities: [e0] Power Management version 3=0A=A0=A0=A0 Kernel modules: =
ioatdma=0A=0A00:1a.0 USB controller: Intel Corporation 82801JI (ICH10 Famil=
y) USB UHCI Controller #4 (prog-if 00 [UHCI])=0A=A0=A0=A0 Subsystem: ASUSTe=
K Computer Inc. Device 8362=0A=A0=A0=A0 Flags: bus master, medium devsel, l=
atency 0, IRQ 16=0A=A0=A0=A0 I/O ports at 7400 [size=3D32]=0A=A0=A0=A0 Capa=
bilities: [50] PCI Advanced Features=0A=A0=A0=A0 Kernel driver in use: uhci=
_hcd=0A=0A00:1a.1 USB controller: Intel Corporation 82801JI (ICH10 Family) =
USB UHCI Controller #5 (prog-if 00 [UHCI])=0A=A0=A0=A0 Subsystem: ASUSTeK C=
omputer Inc. Device 8362=0A=A0=A0=A0 Flags: bus master, medium devsel, late=
ncy 0, IRQ 21=0A=A0=A0=A0 I/O ports at 7480 [size=3D32]=0A=A0=A0=A0 Capabil=
ities: [50] PCI Advanced Features=0A=A0=A0=A0 Kernel driver in use: uhci_hc=
d=0A=0A00:1a.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB=
2 EHCI Controller #2 (prog-if 20 [EHCI])=0A=A0=A0=A0 Subsystem: ASUSTeK Com=
puter Inc. Device 8362=0A=A0=A0=A0 Flags: bus master, medium devsel, latenc=
y 0, IRQ 18=0A=A0=A0=A0 Memory at fb9fd000 (32-bit, non-prefetchable) [size=
=3D1K]=0A=A0=A0=A0 Capabilities: [50] Power Management version 2=0A=A0=A0=
=A0 Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0=0A=A0=A0=A0 Capabi=
lities: [98] PCI Advanced Features=0A=A0=A0=A0 Kernel driver in use: ehci_h=
cd=0A=0A00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Family) HD A=
udio Controller=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 82cb=0A=
=A0=A0=A0 Flags: bus master, fast devsel, latency 0, IRQ 14=0A=A0=A0=A0 Mem=
ory at fb9f8000 (64-bit, non-prefetchable) [size=3D16K]=0A=A0=A0=A0 Capabil=
ities: [50] Power Management version 2=0A=A0=A0=A0 Capabilities: [60] MSI: =
Enable- Count=3D1/1 Maskable- 64bit+=0A=A0=A0=A0 Capabilities: [70] Express=
 Root Complex Integrated Endpoint, MSI 00=0A=0A00:1c.0 PCI bridge: Intel Co=
rporation 82801JI (ICH10 Family) PCI Express Root Port 1 (prog-if 00 [Norma=
l decode])=0A=A0=A0=A0 Flags: bus master, fast devsel, latency 0=0A=A0=A0=
=A0 Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D0=0A=
=A0=A0=A0 I/O behind bridge: 00001000-00001fff=0A=A0=A0=A0 Memory behind br=
idge: c0000000-c01fffff=0A=A0=A0=A0 Prefetchable memory behind bridge: 0000=
0000c0200000-00000000c03fffff=0A=A0=A0=A0 Capabilities: [40] Express Root P=
ort (Slot+), MSI 00=0A=A0=A0=A0 Capabilities: [80] MSI: Enable- Count=3D1/1=
 Maskable- 64bit-=0A=A0=A0=A0 Capabilities: [90] Subsystem: ASUSTeK Compute=
r Inc. Device 8363=0A=A0=A0=A0 Capabilities: [a0] Power Management version =
2=0A=A0=A0=A0 Kernel driver in use: pcieport=0A=0A00:1c.4 PCI bridge: Intel=
 Corporation 82801JI (ICH10 Family) PCI Express Root Port 5 (prog-if 00 [No=
rmal decode])=0A=A0=A0=A0 Flags: bus master, fast devsel, latency 0=0A=A0=
=A0=A0 Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0=
=0A=A0=A0=A0 I/O behind bridge: 0000b000-0000bfff=0A=A0=A0=A0 Memory behind=
 bridge: fbb00000-fbbfffff=0A=A0=A0=A0 Prefetchable memory behind bridge: 0=
0000000c0400000-00000000c05fffff=0A=A0=A0=A0 Capabilities: [40] Express Roo=
t Port (Slot+), MSI 00=0A=A0=A0=A0 Capabilities: [80] MSI: Enable- Count=3D=
1/1 Maskable- 64bit-=0A=A0=A0=A0 Capabilities: [90] Subsystem: ASUSTeK Comp=
uter Inc. Device 8363=0A=A0=A0=A0 Capabilities: [a0] Power Management versi=
on 2=0A=A0=A0=A0 Kernel driver in use: pcieport=0A=0A00:1c.5 PCI bridge: In=
tel Corporation 82801JI (ICH10 Family) PCI Express Root Port 6 (prog-if 00 =
[Normal decode])=0A=A0=A0=A0 Flags: bus master, fast devsel, latency 0=0A=
=A0=A0=A0 Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=
=3D0=0A=A0=A0=A0 I/O behind bridge: 0000a000-0000afff=0A=A0=A0=A0 Memory be=
hind bridge: fba00000-fbafffff=0A=A0=A0=A0 Prefetchable memory behind bridg=
e: 00000000c0600000-00000000c07fffff=0A=A0=A0=A0 Capabilities: [40] Express=
 Root Port (Slot+), MSI 00=0A=A0=A0=A0 Capabilities: [80] MSI: Enable- Coun=
t=3D1/1 Maskable- 64bit-=0A=A0=A0=A0 Capabilities: [90] Subsystem: ASUSTeK =
Computer Inc. Device 8363=0A=A0=A0=A0 Capabilities: [a0] Power Management v=
ersion 2=0A=A0=A0=A0 Kernel driver in use: pcieport=0A=0A00:1d.0 USB contro=
ller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #1 (prog=
-if 00 [UHCI])=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8362=0A=
=A0=A0=A0 Flags: bus master, medium devsel, latency 0, IRQ 23=0A=A0=A0=A0 I=
/O ports at 7800 [size=3D32]=0A=A0=A0=A0 Capabilities: [50] PCI Advanced Fe=
atures=0A=A0=A0=A0 Kernel driver in use: uhci_hcd=0A=0A00:1d.1 USB controll=
er: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #2 (prog-i=
f 00 [UHCI])=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8362=0A=A0=
=A0=A0 Flags: bus master, medium devsel, latency 0, IRQ 19=0A=A0=A0=A0 I/O =
ports at 7880 [size=3D32]=0A=A0=A0=A0 Capabilities: [50] PCI Advanced Featu=
res=0A=A0=A0=A0 Kernel driver in use: uhci_hcd=0A=0A00:1d.2 USB controller:=
 Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #3 (prog-if 0=
0 [UHCI])=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8362=0A=A0=A0=
=A0 Flags: bus master, medium devsel, latency 0, IRQ 18=0A=A0=A0=A0 I/O por=
ts at 7c00 [size=3D32]=0A=A0=A0=A0 Capabilities: [50] PCI Advanced Features=
=0A=A0=A0=A0 Kernel driver in use: uhci_hcd=0A=0A00:1d.3 USB controller: In=
tel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6 (prog-if 00 [=
UHCI])=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8362=0A=A0=A0=A0=
 Flags: bus master, medium devsel, latency 0, IRQ 16=0A=A0=A0=A0 I/O ports =
at 8000 [size=3D32]=0A=A0=A0=A0 Capabilities: [50] PCI Advanced Features=0A=
=A0=A0=A0 Kernel driver in use: uhci_hcd=0A=0A00:1d.7 USB controller: Intel=
 Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #1 (prog-if 20 [EH=
CI])=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8362=0A=A0=A0=A0 F=
lags: bus master, medium devsel, latency 0, IRQ 23=0A=A0=A0=A0 Memory at fb=
9fe000 (32-bit, non-prefetchable) [size=3D1K]=0A=A0=A0=A0 Capabilities: [50=
] Power Management version 2=0A=A0=A0=A0 Capabilities: [58] Debug port: BAR=
=3D1 offset=3D00a0=0A=A0=A0=A0 Capabilities: [98] PCI Advanced Features=0A=
=A0=A0=A0 Kernel driver in use: ehci_hcd=0A=0A00:1e.0 PCI bridge: Intel Cor=
poration 82801 PCI Bridge (rev 90) (prog-if 01 [Subtractive decode])=0A=A0=
=A0=A0 Flags: bus master, fast devsel, latency 0=0A=A0=A0=A0 Bus: primary=
=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32=0A=A0=A0=A0 Capab=
ilities: [50] Subsystem: ASUSTeK Computer Inc. Device 8363=0A=0A00:1f.0 ISA=
 bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface Controller=0A=A0=
=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8362=0A=A0=A0=A0 Flags: bus =
master, medium devsel, latency 0=0A=A0=A0=A0 Capabilities: [e0] Vendor Spec=
ific Information: Len=3D0c <?>=0A=A0=A0=A0 Kernel modules: lpc_ich=0A=0A00:=
1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port SATA ID=
E Controller #1 (prog-if 8f [Master SecP SecO PriP PriO])=0A=A0=A0=A0 Subsy=
stem: ASUSTeK Computer Inc. Device 8362=0A=A0=A0=A0 Flags: bus master, 66MH=
z, medium devsel, latency 0, IRQ 23=0A=A0=A0=A0 I/O ports at 8c00 [size=3D8=
]=0A=A0=A0=A0 I/O ports at 8880 [size=3D4]=0A=A0=A0=A0 I/O ports at 8800 [s=
ize=3D8]=0A=A0=A0=A0 I/O ports at 8480 [size=3D4]=0A=A0=A0=A0 I/O ports at =
8400 [size=3D16]=0A=A0=A0=A0 I/O ports at 8080 [size=3D16]=0A=A0=A0=A0 Capa=
bilities: [70] Power Management version 3=0A=A0=A0=A0 Capabilities: [b0] PC=
I Advanced Features=0A=A0=A0=A0 Kernel driver in use: ata_piix=0A=0A00:1f.3=
 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller=0A=A0=A0=
=A0 Subsystem: ASUSTeK Computer Inc. Device 8362=0A=A0=A0=A0 Flags: medium =
devsel, IRQ 14=0A=A0=A0=A0 Memory at fb9ff000 (64-bit, non-prefetchable) [s=
ize=3D256]=0A=A0=A0=A0 I/O ports at 0400 [size=3D32]=0A=A0=A0=A0 Kernel mod=
ules: i2c-i801=0A=0A00:1f.5 IDE interface: Intel Corporation 82801JI (ICH10=
 Family) 2 port SATA IDE Controller #2 (prog-if 85 [Master SecO PriO])=0A=
=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8362=0A=A0=A0=A0 Flags: b=
us master, 66MHz, medium devsel, latency 0, IRQ 21=0A=A0=A0=A0 I/O ports at=
 9c00 [size=3D8]=0A=A0=A0=A0 I/O ports at 9880 [size=3D4]=0A=A0=A0=A0 I/O p=
orts at 9800 [size=3D8]=0A=A0=A0=A0 I/O ports at 9480 [size=3D4]=0A=A0=A0=
=A0 I/O ports at 9400 [size=3D16]=0A=A0=A0=A0 I/O ports at 9080 [size=3D16]=
=0A=A0=A0=A0 Capabilities: [70] Power Management version 3=0A=A0=A0=A0 Capa=
bilities: [b0] PCI Advanced Features=0A=A0=A0=A0 Kernel driver in use: ata_=
piix=0A=0A02:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Net=
work Connection=0A=A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 8369=0A=
=A0=A0=A0 Flags: bus master, fast devsel, latency 0, IRQ 17=0A=A0=A0=A0 Mem=
ory at fbae0000 (32-bit, non-prefetchable) [size=3D128K]=0A=A0=A0=A0 I/O po=
rts at ac00 [size=3D32]=0A=A0=A0=A0 Memory at fbadc000 (32-bit, non-prefetc=
hable) [size=3D16K]=0A=A0=A0=A0 Capabilities: [c8] Power Management version=
 2=0A=A0=A0=A0 Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+=
=0A=A0=A0=A0 Capabilities: [e0] Express Endpoint, MSI 00=0A=A0=A0=A0 Capabi=
lities: [a0] MSI-X: Enable- Count=3D5 Masked-=0A=A0=A0=A0 Kernel driver in =
use: e1000e=0A=A0=A0=A0 Kernel modules: e1000e=0A=0A03:00.0 Ethernet contro=
ller: Intel Corporation 82574L Gigabit Network Connection=0A=A0=A0=A0 Subsy=
stem: ASUSTeK Computer Inc. Device 8369=0A=A0=A0=A0 Flags: bus master, fast=
 devsel, latency 0, IRQ 16=0A=A0=A0=A0 Memory at fbbe0000 (32-bit, non-pref=
etchable) [size=3D128K]=0A=A0=A0=A0 I/O ports at bc00 [size=3D32]=0A=A0=A0=
=A0 Memory at fbbdc000 (32-bit, non-prefetchable) [size=3D16K]=0A=A0=A0=A0 =
Capabilities: [c8] Power Management version 2=0A=A0=A0=A0 Capabilities: [d0=
] MSI: Enable- Count=3D1/1 Maskable- 64bit+=0A=A0=A0=A0 Capabilities: [e0] =
Express Endpoint, MSI 00=0A=A0=A0=A0 Capabilities: [a0] MSI-X: Enable- Coun=
t=3D5 Masked-=0A=A0=A0=A0 Kernel driver in use: e1000e=0A=A0=A0=A0 Kernel m=
odules: e1000e=0A=0A08:00.0 VGA compatible controller: Advanced Micro Devic=
es [AMD] nee ATI RV710 [Mobility Radeon HD 4300 Series] (prog-if 00 [VGA co=
ntroller])=0A=A0=A0=A0 Subsystem: Giga-byte Technology Device 21ac=0A=A0=A0=
=A0 Flags: bus master, fast devsel, latency 0, IRQ 30=0A=A0=A0=A0 Memory at=
 d0000000 (64-bit, prefetchable) [size=3D256M]=0A=A0=A0=A0 Memory at fbcb00=
00 (64-bit, non-prefetchable) [size=3D64K]=0A=A0=A0=A0 I/O ports at c000 [s=
ize=3D256]=0A=A0=A0=A0 Expansion ROM at fbcc0000 [disabled] [size=3D128K]=
=0A=A0=A0=A0 Capabilities: [50] Power Management version 3=0A=A0=A0=A0 Capa=
bilities: [58] Express Legacy Endpoint, MSI 00=0A=A0=A0=A0 Capabilities: [a=
0] MSI: Enable- Count=3D1/1 Maskable- 64bit+=0A=A0=A0=A0 Kernel driver in u=
se: radeon=0A=A0=A0=A0 Kernel modules: radeon=0A=0A08:00.1 Audio device: Ad=
vanced Micro Devices [AMD] nee ATI RV710/730 HDMI Audio [Radeon HD 4000 ser=
ies]=0A=A0=A0=A0 Subsystem: Giga-byte Technology Device aa38=0A=A0=A0=A0 Fl=
ags: bus master, fast devsel, latency 0, IRQ 5=0A=A0=A0=A0 Memory at fbcfc0=
00 (64-bit, non-prefetchable) [size=3D16K]=0A=A0=A0=A0 Capabilities: [50] P=
ower Management version 3=0A=A0=A0=A0 Capabilities: [58] Express Legacy End=
point, MSI 00=0A=A0=A0=A0 Capabilities: [a0] MSI: Enable- Count=3D1/1 Maska=
ble- 64bit+=0A=0A09:00.0 Ethernet controller: Intel Corporation 82571EB Gig=
abit Ethernet Controller (rev 06)=0A=A0=A0=A0 Subsystem: Intel Corporation =
PRO/1000 PT Dual Port Server Adapter=0A=A0=A0=A0 Flags: bus master, fast de=
vsel, latency 0, IRQ 24=0A=A0=A0=A0 Memory at fbd80000 (32-bit, non-prefetc=
hable) [size=3D128K]=0A=A0=A0=A0 Memory at fbd60000 (32-bit, non-prefetchab=
le) [size=3D128K]=0A=A0=A0=A0 I/O ports at d880 [size=3D32]=0A=A0=A0=A0 Exp=
ansion ROM at fbd40000 [disabled] [size=3D128K]=0A=A0=A0=A0 Capabilities: [=
c8] Power Management version 2=0A=A0=A0=A0 Capabilities: [d0] MSI: Enable- =
Count=3D1/1 Maskable- 64bit+=0A=A0=A0=A0 Capabilities: [e0] Express Endpoin=
t, MSI 00=0A=A0=A0=A0 Kernel driver in use: rt_e1000=0A=A0=A0=A0 Kernel mod=
ules: e1000e=0A=0A09:00.1 Ethernet controller: Intel Corporation 82571EB Gi=
gabit Ethernet Controller (rev 06)=0A=A0=A0=A0 Subsystem: Intel Corporation=
 PRO/1000 PT Dual Port Server Adapter=0A=A0=A0=A0 Flags: bus master, fast d=
evsel, latency 0, IRQ 34=0A=A0=A0=A0 Memory at fbde0000 (32-bit, non-prefet=
chable) [size=3D128K]=0A=A0=A0=A0 Memory at fbdc0000 (32-bit, non-prefetcha=
ble) [size=3D128K]=0A=A0=A0=A0 I/O ports at dc00 [size=3D32]=0A=A0=A0=A0 Ex=
pansion ROM at fbda0000 [disabled] [size=3D128K]=0A=A0=A0=A0 Capabilities: =
[c8] Power Management version 2=0A=A0=A0=A0 Capabilities: [d0] MSI: Enable-=
 Count=3D1/1 Maskable- 64bit+=0A=A0=A0=A0 Capabilities: [e0] Express Endpoi=
nt, MSI 00=0A=A0=A0=A0 Kernel driver in use: e1000e=0A=A0=A0=A0 Kernel modu=
les: e1000e=0A=0A0b:00.0 Ethernet controller: Intel Corporation 82571EB Gig=
abit Ethernet Controller (rev 06)=0A=A0=A0=A0 Subsystem: Intel Corporation =
PRO/1000 PT Dual Port Server Adapter=0A=A0=A0=A0 Flags: bus master, fast de=
vsel, latency 0, IRQ 28=0A=A0=A0=A0 Memory at fbe80000 (32-bit, non-prefetc=
hable) [size=3D128K]=0A=A0=A0=A0 Memory at fbe60000 (32-bit, non-prefetchab=
le) [size=3D128K]=0A=A0=A0=A0 I/O ports at e880 [size=3D32]=0A=A0=A0=A0 Exp=
ansion ROM at fbe40000 [disabled] [size=3D128K]=0A=A0=A0=A0 Capabilities: [=
c8] Power Management version 2=0A=A0=A0=A0 Capabilities: [d0] MSI: Enable- =
Count=3D1/1 Maskable- 64bit+=0A=A0=A0=A0 Capabilities: [e0] Express Endpoin=
t, MSI 00=0A=A0=A0=A0 Kernel driver in use: rt_e1000=0A=A0=A0=A0 Kernel mod=
ules: e1000e=0A=0A0b:00.1 Ethernet controller: Intel Corporation 82571EB Gi=
gabit Ethernet Controller (rev 06)=0A=A0=A0=A0 Subsystem: Intel Corporation=
 PRO/1000 PT Dual Port Server Adapter=0A=A0=A0=A0 Flags: bus master, fast d=
evsel, latency 0, IRQ 40=0A=A0=A0=A0 Memory at fbee0000 (32-bit, non-prefet=
chable) [size=3D128K]=0A=A0=A0=A0 Memory at fbec0000 (32-bit, non-prefetcha=
ble) [size=3D128K]=0A=A0=A0=A0 I/O ports at ec00 [size=3D32]=0A=A0=A0=A0 Ex=
pansion ROM at fbea0000 [disabled] [size=3D128K]=0A=A0=A0=A0 Capabilities: =
[c8] Power Management version 2=0A=A0=A0=A0 Capabilities: [d0] MSI: Enable-=
 Count=3D1/1 Maskable- 64bit+=0A=A0=A0=A0 Capabilities: [e0] Express Endpoi=
nt, MSI 00=0A=A0=A0=A0 Kernel driver in use: rt_e1000=0A=A0=A0=A0 Kernel mo=
dules: e1000e
