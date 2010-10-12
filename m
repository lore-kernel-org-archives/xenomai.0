MIME-Version: 1.0
In-Reply-To: <AANLkTimTRK9RG6md3vVoohx7KFw2uwczZGGaXvajnPxq@domain.hid>
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>
	<1286611432.13186.200.camel@domain.hid>
	<AANLkTinfQTmC=165zLerDF1JsYnS-XHaUtWrMuOGmN4D@mail.gmail.com>
	<AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>
	<4CB2B98A.8010605@domain.hid>
	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>
	<4CB36116.8090507@domain.hid> <4CB367AA.6020403@domain.hid>
	<AANLkTimpY=60yJbWBwnu7KWZMst5ajFvrRoFzVx092oN@mail.gmail.com>
	<AANLkTimTRK9RG6md3vVoohx7KFw2uwczZGGaXvajnPxq@domain.hid>
Date: Mon, 11 Oct 2010 18:55:09 -0700
Message-ID: <AANLkTimhhDqZnoURH8+8CU8bPx1KKMhemDJjwo8ni2sj@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=00163642753f4b30ff049261c46a
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

--00163642753f4b30ff049261c46a
Content-Type: text/plain; charset=ISO-8859-1

Hey Wolfgang,

I made some great progress in the last few hours. I figured that the PEAK
PCI can bus card had IRQ 11 according to "lspci" and after the kernel
modules are loaded it switched to IRQ 16 which caused all the trouble since
the USB and the SCSI controller have the same IRQ.

Now, I just went ahead and hard coded

/usr/src/xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c
FUNCTION rtcan_sja1000_register...
#############

    chip->bus_err_on = 1;

    printk("PETER chip->irq_num = %i\n", chip->irq_num);
    chip->irq_num = 11;
    printk("PETER chip->irq_num = %i\n", chip->irq_num);

    ret = rtdm_irq_request(&dev->irq_handle,
               chip->irq_num, rtcan_sja_interrupt,
               chip->irq_flags, sja_ctrl_name, dev);

#############

After compiling, I was able to load all three modules and
Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
rtcan0            1000000 active            1          0          0
rtcan1          undefined stopped           0          0          0

root@domain.hid# cat /proc/xenomai/irq
IRQ         CPU0        CPU1        CPU2        CPU3        CPU4
CPU5        CPU6        CPU7
 11:           0           0           0           0           0
0           0           0         SJA1000 SJA1000
521:           5           1           0           0           3
2           1           1         [IPI]
524:      267014      183344      104046       50083      487162
389563      399807      299675         [timer]
525:           0           0           0           0           0
0           0           0         [critical sync]
578:          38           0           0           0           4
0           0           1         [virtual]

root@domain.hid# cat
/proc/rtcan/rtcan0/info
Device     rtcan0
Controller SJA1000
Board      PEAK-PCI
Clock-Hz   8000000
Baudrate   1000000
Bit-time   brp=1 prop_seg=0 phase_seg1=5 phase_seg2=2 sjw=1 sam=0
Ctrl-Mode
State      active
TX-Counter 1
RX-Counter 0
Errors     0
Refcount   0

However, I was not able to start my program that communicates on the can
bus. Instead, dmesg shows

[ 2162.848141] PETER chip->irq_num = 16 PETER chip->irq_num = 11rtcan:
registered rtcan0
[ 2162.848157] PETER rtcan_peak_pci_add_chan
drivers/xenomai/can/sja1000/rtcan_peak_pci.c 164 :
[ 2162.848164] PEAK-PCI-CAN: base_addr=ffffc90007fb8400
conf_addr=ffffc90007f3c000 irq=16
[ 2162.848168] PETER chip->irq_num = 16 PETER chip->irq_num = 11rtcan:
registered rtcan1
[ 5252.947307] irq 16: nobody cared (try booting with the "irqpoll" option)
[ 5252.947313] Pid: 0, comm: swapper Tainted: P
2.6.34.5-ipipe-2.5.5.1-test_02 #10
[ 5252.947316] Call Trace:
[ 5252.947319]  <IRQ>  [<ffffffff810a2736>] __report_bad_irq+0x26/0xa0
[ 5252.947331]  [<ffffffff810a293c>] note_interrupt+0x18c/0x1d0
[ 5252.947333]  [<ffffffff810a3335>] handle_fasteoi_irq+0xb5/0xe0
[ 5252.947336]  [<ffffffff81005e6d>] handle_irq+0x1d/0x30
[ 5252.947338]  [<ffffffff81005340>] do_IRQ+0x70/0x100
[ 5252.947340]  [<ffffffff810a8d57>] __ipipe_sync_stage+0x207/0x20d
[ 5252.947342]  [<ffffffff810052d0>] ? do_IRQ+0x0/0x100
[ 5252.947344]  [<ffffffff810a8d5d>] ? __xirq_end+0x0/0x9c
[ 5252.947345]  [<ffffffff810052d0>] ? do_IRQ+0x0/0x100
[ 5252.947347]  [<ffffffff810a9213>] __ipipe_walk_pipeline+0x113/0x120
[ 5252.947350]  [<ffffffff81023084>] __ipipe_handle_irq+0x124/0x310
[ 5252.947352]  [<ffffffff810a2af0>] ? __ipipe_ack_fasteoi_irq+0x0/0x10
[ 5252.947356]  [<ffffffff81552193>] common_interrupt+0x13/0x2c
[ 5252.947357]  <EOI>  [<ffffffff81023416>] ? __ipipe_halt_root+0x26/0x40
[ 5252.947362]  [<ffffffff8100ba06>] default_idle+0x36/0x90
[ 5252.947365]  [<ffffffff81001d84>] cpu_idle+0x74/0xd0
[ 5252.947368]  [<ffffffff8154c1af>] start_secondary+0x1b2/0x1b6
[ 5252.947370] handlers:
[ 5252.947370] [<ffffffff813cd590>] (usb_hcd_irq+0x0/0xb0)
[ 5252.947374] [<ffffffffa0066c30>] (mpt_interrupt+0x0/0xa00 [mptbase])
[ 5252.947382] Disabling IRQ #16

Which I guess tells me that I have to hard code the irq number somewhere
else as well. I hope we narrowed down the problem and I really hope that
there is a way to resolve this IRQ conflict

THANKS so much,
 peter



On Mon, Oct 11, 2010 at 5:09 PM, Peter Pastor <peter.pastor@domain.hid>wrote:

> Hey Wolfgang,
>
> I am compiling the rtcan code as modules. Also, for debugging purposes, I
> moved the xeno_can.ko and friends out of the /lib/modules directory and
> successfully booted into xenomai. Once xenomai booted up correctly, I insmod
> the modules by hand, first xeno_can.ko, then xeno_can_sja1000.ko and then
> the xeno_can_peak_pci.ko. The first two modules do not cause any trouble.
> However, the last one causes the system to freeze (after a short delay).
>
> The ERROR message is
> ERROR -16: IRQ is busy, check shared interrupt support !
> ERROR -16 while trying to register SJA1000 device.
>
> It turns out that I haven't had the shared interrupt support turned on !!
>
> However, after enabling shared inturrupts (in the real-time subsystem
> category) and recompiling and rebooting... the error message disappears but
> the system still freezes after a certain while. I cannot really grep what
> comes out of the dmesg and also, it seems that each time I load this final
> kernel module it spits out slightly different things.
>
> Initially it seems that everything is fine. It registers rtcan0 and rtcan1
> on IRQ 16
>
> I do not quit understand why it is assigned to 16 though and not 11.
>
> Well, I assume that the system freeze because of the interrupt assignment.
> Is there a way to load the kernel module with the desired IRQ as parameter ?
>
> I attached 2 more pictures: 1) right after loading the xeno_can_peak_pci.ko
> and 2) after the system "woke" up again as "zombie".
>
> Sorry for not posting the content of the images. I was not able to pipe it
> into a file (file system got re-mounted as read-only). Hope that is ok.
>
> BTW: the MP-BIOS bug: 8254 timer not connected to IO-APIC and the address
> space collision: host bridge window [ ... ] conflicts with PCI Bus 0000:00 [
> ... ] pci no compatible bridge window for [ ... ] still exist (see attached
> image >> error.jpg)
>
> THANKS so much,
>  peter
>
>
>
>
>
>
> On Mon, Oct 11, 2010 at 2:23 PM, Peter Pastor <peter.pastor@domain.hid>wrote:
>
>> Hey Wolfgang,
>>
>> we are using this card
>>
>> http://www.gridconnect.com/pcicanin2ch.html
>>
>> 07:04.0 Network controller [0280]: PEAK-System Technik GmbH PCAN-PCI
>> CAN-Bus controller [001c:0001] (rev 02)
>>        Subsystem: PEAK-System Technik GmbH Device [001c:0005]
>>        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>        Interrupt: pin A routed to IRQ 11
>>        Region 0: Memory at f3ae0000 (32-bit, non-prefetchable) [size=64K]
>>        Region 1: Memory at f3af0000 (32-bit, non-prefetchable) [size=64K]
>>
>> I will let you know how it goes with the printks.
>>
>> THANKS a lot,
>>  peter
>>
>> On Mon, Oct 11, 2010 at 12:38 PM, Wolfgang Grandegger <wg@domain.hid>wrote:
>>
>>> On 10/11/2010 09:10 PM, Gilles Chanteperdrix wrote:
>>> > Peter Pastor wrote:
>>> >> Hey Gilles,
>>> >>
>>> >> Thanks for the hint. I "fixed" this problem by loading the nvidia
>>> driver
>>> >> (instead of nv) as default. Now the graphic cards uses IRQ 24 which
>>> does not
>>> >> collide with IRQ 11 of the CAN bus card (see attached lspci.txt).
>>> >>
>>> >> The only other device that uses IRQ 11 is
>>> >> # 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI
>>> Port
>>> >> [8086:3406] (rev 13)
>>> >>
>>> >> But I guess that is ok, is it ? I checked the FAQs and went through
>>> the list
>>> >> but I feel I can't do much. I will try a few things and disable
>>> everything
>>> >> that is unneeded. The FAQ list also suggests to enable CONFIG_PCI_MSI
>>> which
>>> >> is disabled right now. What would now be a reasonable thing to do ?
>>> >
>>> > Keep PCI_MSI disabled. The FAQ is wrong and should be fixed.
>>> >
>>> >>
>>> >> How can I find out and about which device is causing the address space
>>> >> collision ?
>>> >>
>>> >> # address space collision: host bridge window [mem
>>> 0xd7f00000-0xe0000000]
>>> >> conflicts with PCI Bus 0000:00 [mem 0xe0000000-0xf7ffffff]
>>> >>
>>> >> I attached the syslog of the latest boot. I enabled some debugging
>>> infos
>>> >> which hopefully allow to trace down the problem. Interestingly, this
>>> time,
>>> >> the kernel spit out
>>> >>
>>> >> # RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
>>> >>
>>> >> right before it froze.
>>> >
>>> > You should try and put some printks in RTCan code to see how far it
>>> > goes. But I guess Wolfgang may be of more help.
>>>
>>> Well, normally messages like:
>>>
>>>  RTCAN SJA1000 driver initialized
>>>  PEAK-PCI-CAN: initializing device 001c:0001
>>>  PEAK-PCI-CAN: base_addr=c907c000 conf_addr=c907a000 irq=16
>>>  rtcan: registered rtcan0
>>>  PEAK-PCI-CAN: base_addr=c907e400 conf_addr=c907a000 irq=16
>>>  rtcan: registered rtcan1
>>>
>>> should follow. I would add printk's into peak_pci_init_one() and
>>> rtcan_peak_pci_add_chan() in ksrc/drivers/can/sja1000/rtcan_peak_pci.c.
>>> Did you compile the SJA1000 driver's into the kernel? Try building
>>> modules, which you then can load manually.
>>>
>>> BTW: what PEAK PCI card are you using?
>>>
>>> Wolfgang.
>>>
>>
>>
>

--00163642753f4b30ff049261c46a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Wolfgang,<br><br>I made some great progress in the last few hours. I fi=
gured that the PEAK PCI can bus card had IRQ 11 according to &quot;lspci&qu=
ot; and after the kernel modules are loaded it switched to IRQ 16 which cau=
sed all the trouble since the USB and the SCSI controller have the same IRQ=
.<br>
<br>Now, I just went ahead and hard coded <br><br>/usr/src/xenomai/ksrc/dri=
vers/can/sja1000/rtcan_sja1000.c<br>FUNCTION rtcan_sja1000_register...<br>
#############<br><br>=A0=A0=A0 chip-&gt;bus_err_on =3D 1;<br><br>=A0=A0=A0 =
printk(&quot;PETER chip-&gt;irq_num =3D %i\n&quot;, chip-&gt;irq_num);<br>=
=A0=A0=A0 chip-&gt;irq_num =3D 11;<br>=A0=A0=A0 printk(&quot;PETER chip-&gt=
;irq_num =3D %i\n&quot;, chip-&gt;irq_num);<br>
<br>=A0=A0=A0 ret =3D rtdm_irq_request(&amp;dev-&gt;irq_handle,<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 chip-&gt;irq_num, rtcan_sja_interrupt,<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 chip-&gt;irq_flags, sja_ctrl_name, dev=
);<br><br>#############<br><br>After compiling, I was able to load all thre=
e modules and <br>
Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors<br>rtca=
n0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1000000 active=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0<br>rt=
can1=A0=A0=A0=A0=A0=A0=A0=A0=A0 undefined stopped=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0<br><br>r=
oot@domain.hid# cat /proc/xenomai/irq =
<br>
IRQ=A0=A0=A0=A0=A0=A0=A0=A0 CPU0=A0=A0=A0=A0=A0=A0=A0 CPU1=A0=A0=A0=A0=A0=
=A0=A0 CPU2=A0=A0=A0=A0=A0=A0=A0 CPU3=A0=A0=A0=A0=A0=A0=A0 CPU4=A0=A0=A0=A0=
=A0=A0=A0 CPU5=A0=A0=A0=A0=A0=A0=A0 CPU6=A0=A0=A0=A0=A0=A0=A0 CPU7<br>=A011=
:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0 SJA1000 SJA10=
00<br>
521:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0 [IPI]<br>5=
24:=A0=A0=A0=A0=A0 267014=A0=A0=A0=A0=A0 183344=A0=A0=A0=A0=A0 104046=A0=A0=
=A0=A0=A0=A0 50083=A0=A0=A0=A0=A0 487162=A0=A0=A0=A0=A0 389563=A0=A0=A0=A0=
=A0 399807=A0=A0=A0=A0=A0 299675=A0=A0=A0=A0=A0=A0=A0=A0 [timer]<br>
525:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0 [critical =
sync]<br>578:=A0=A0=A0=A0=A0=A0=A0=A0=A0 38=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0 [vir=
tual]<br>
<br>root@domain.hid# cat /proc/rtcan/r=
tcan0/info <br>Device=A0=A0=A0=A0 rtcan0<br>Controller SJA1000<br>Board=A0=
=A0=A0=A0=A0 PEAK-PCI<br>Clock-Hz=A0=A0 8000000<br>Baudrate=A0=A0 1000000<b=
r>Bit-time=A0=A0 brp=3D1 prop_seg=3D0 phase_seg1=3D5 phase_seg2=3D2 sjw=3D1=
 sam=3D0<br>
Ctrl-Mode=A0 <br>State=A0=A0=A0=A0=A0 active<br>TX-Counter 1<br>RX-Counter =
0<br>Errors=A0=A0=A0=A0 0<br>Refcount=A0=A0 0<br><br>However, I was not abl=
e to start my program that communicates on the can bus. Instead, dmesg show=
s<br><br>[ 2162.848141] PETER chip-&gt;irq_num =3D 16 PETER chip-&gt;irq_nu=
m =3D 11rtcan: registered rtcan0<br>
[ 2162.848157] PETER rtcan_peak_pci_add_chan drivers/xenomai/can/sja1000/rt=
can_peak_pci.c 164 : <br>[ 2162.848164] PEAK-PCI-CAN: base_addr=3Dffffc9000=
7fb8400 conf_addr=3Dffffc90007f3c000 irq=3D16<br>[ 2162.848168] PETER chip-=
&gt;irq_num =3D 16 PETER chip-&gt;irq_num =3D 11rtcan: registered rtcan1<br=
>
[ 5252.947307] irq 16: nobody cared (try booting with the &quot;irqpoll&quo=
t; option)<br>[ 5252.947313] Pid: 0, comm: swapper Tainted: P=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 2.6.34.5-ipipe-2.5.5.1-test_02 #10<br>[ 5252.947316] Cal=
l Trace:<br>[ 5252.947319]=A0 &lt;IRQ&gt;=A0 [&lt;ffffffff810a2736&gt;] __r=
eport_bad_irq+0x26/0xa0<br>
[ 5252.947331]=A0 [&lt;ffffffff810a293c&gt;] note_interrupt+0x18c/0x1d0<br>=
[ 5252.947333]=A0 [&lt;ffffffff810a3335&gt;] handle_fasteoi_irq+0xb5/0xe0<b=
r>[ 5252.947336]=A0 [&lt;ffffffff81005e6d&gt;] handle_irq+0x1d/0x30<br>[ 52=
52.947338]=A0 [&lt;ffffffff81005340&gt;] do_IRQ+0x70/0x100<br>
[ 5252.947340]=A0 [&lt;ffffffff810a8d57&gt;] __ipipe_sync_stage+0x207/0x20d=
<br>[ 5252.947342]=A0 [&lt;ffffffff810052d0&gt;] ? do_IRQ+0x0/0x100<br>[ 52=
52.947344]=A0 [&lt;ffffffff810a8d5d&gt;] ? __xirq_end+0x0/0x9c<br>[ 5252.94=
7345]=A0 [&lt;ffffffff810052d0&gt;] ? do_IRQ+0x0/0x100<br>
[ 5252.947347]=A0 [&lt;ffffffff810a9213&gt;] __ipipe_walk_pipeline+0x113/0x=
120<br>[ 5252.947350]=A0 [&lt;ffffffff81023084&gt;] __ipipe_handle_irq+0x12=
4/0x310<br>[ 5252.947352]=A0 [&lt;ffffffff810a2af0&gt;] ? __ipipe_ack_faste=
oi_irq+0x0/0x10<br>
[ 5252.947356]=A0 [&lt;ffffffff81552193&gt;] common_interrupt+0x13/0x2c<br>=
[ 5252.947357]=A0 &lt;EOI&gt;=A0 [&lt;ffffffff81023416&gt;] ? __ipipe_halt_=
root+0x26/0x40<br>[ 5252.947362]=A0 [&lt;ffffffff8100ba06&gt;] default_idle=
+0x36/0x90<br>
[ 5252.947365]=A0 [&lt;ffffffff81001d84&gt;] cpu_idle+0x74/0xd0<br>[ 5252.9=
47368]=A0 [&lt;ffffffff8154c1af&gt;] start_secondary+0x1b2/0x1b6<br>[ 5252.=
947370] handlers:<br>[ 5252.947370] [&lt;ffffffff813cd590&gt;] (usb_hcd_irq=
+0x0/0xb0)<br>
[ 5252.947374] [&lt;ffffffffa0066c30&gt;] (mpt_interrupt+0x0/0xa00 [mptbase=
])<br>[ 5252.947382] Disabling IRQ #16<br><br>Which I guess tells me that I=
 have to hard code the irq number somewhere else as well. I hope we narrowe=
d down the problem and I really hope that there is a way to resolve this IR=
Q conflict<br>
<br>THANKS so much,<br>=A0peter<br><br><br><br><div class=3D"gmail_quote">O=
n Mon, Oct 11, 2010 at 5:09 PM, Peter Pastor <span dir=3D"ltr">&lt;<a href=
=3D"mailto:peter.pastor@domain.hid">peter.pastor@domain.hid</a>&gt;</span> wr=
ote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hey Wolfgang,<br>=
<br>I am compiling the rtcan code as modules. Also, for debugging purposes,=
 I moved the xeno_can.ko and friends out of the /lib/modules directory and =
successfully booted into xenomai. Once xenomai booted up correctly, I insmo=
d the modules by hand, first xeno_can.ko, then xeno_can_sja1000.ko and then=
 the xeno_can_peak_pci.ko. The first two modules do not cause any trouble. =
However, the last one causes the system to freeze (after a short delay). <b=
r>


<br>The ERROR message is <br>ERROR -16: IRQ is busy, check shared interrupt=
 support !<br>ERROR -16 while trying to register SJA1000 device.<br><br>It =
turns out that I haven&#39;t had the shared interrupt support turned on !! =
<br>


<br>However, after enabling shared inturrupts (in the real-time subsystem c=
ategory) and recompiling and rebooting... the error message disappears but =
the system still freezes after a certain while. I cannot really grep what c=
omes out of the dmesg and also, it seems that each time I load this final k=
ernel module it spits out slightly different things.<br>

<br>Initially it seems that everything is fine. It registers rtcan0 and rtc=
an1 on IRQ 16<br><br>I do not quit understand why it is assigned to 16 thou=
gh and not 11.<br><br>Well, I assume that the system freeze because of the =
interrupt assignment. Is there a way to load the kernel module with the des=
ired IRQ as parameter ?<br>

<br>I attached 2 more pictures: 1) right after loading the xeno_can_peak_pc=
i.ko and 2) after the system &quot;woke&quot; up again as &quot;zombie&quot=
;. <br><br>Sorry for not posting the content of the images. I was not able =
to pipe it into a file (file system got re-mounted as read-only). Hope that=
 is ok.<br>

<br>BTW: the MP-BIOS bug: 8254 timer not connected to IO-APIC and the addre=
ss space collision: host bridge window [ ... ] conflicts with PCI Bus 0000:=
00 [ ... ] pci no compatible bridge window for [ ... ] still exist (see att=
ached image &gt;&gt; error.jpg)<br>

<br>THANKS so much,<br><font color=3D"#888888">
=A0peter</font><div><div></div><div class=3D"h5"><br><br><br><br><br>
<br><div class=3D"gmail_quote">On Mon, Oct 11, 2010 at 2:23 PM, Peter Pasto=
r <span dir=3D"ltr">&lt;<a href=3D"mailto:peter.pastor@domain.hid" target=3D=
"_blank">peter.pastor@domain.hid</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


<div>Hey Wolfgang,<br>
<br>
we are using this card<br>
<br>
<a href=3D"http://www.gridconnect.com/pcicanin2ch.html" target=3D"_blank">h=
ttp://www.gridconnect.com/pcicanin2ch.html</a><br>
<br>
07:04.0 Network controller [0280]: PEAK-System Technik GmbH PCAN-PCI<br>
CAN-Bus controller [001c:0001] (rev 02)<br>
 =A0 =A0 =A0 =A0Subsystem: PEAK-System Technik GmbH Device [001c:0005]<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr-<br>
Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort-<br>
&lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 11<br>
 =A0 =A0 =A0 =A0Region 0: Memory at f3ae0000 (32-bit, non-prefetchable) [si=
ze=3D64K]<br>
 =A0 =A0 =A0 =A0Region 1: Memory at f3af0000 (32-bit, non-prefetchable) [si=
ze=3D64K]<br>
<br>
I will let you know how it goes with the printks.<br>
<br>
THANKS a lot,<br>
</div><font color=3D"#888888"><font color=3D"#888888">=A0peter</font><br><b=
r></font><div class=3D"gmail_quote"><div>On Mon, Oct 11, 2010 at 12:38 PM, =
Wolfgang Grandegger <span dir=3D"ltr">&lt;<a href=3D"mailto:wg@domain.hid=
om" target=3D"_blank">wg@domain.hid</a>&gt;</span> wrote:<br>



</div><div><div></div><div><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;"><div><div></div><div>On 10/11/2010 09:10 PM, Gilles Chanteperdrix=
 wrote:<br>



&gt; Peter Pastor wrote:<br>
&gt;&gt; Hey Gilles,<br>
&gt;&gt;<br>
&gt;&gt; Thanks for the hint. I &quot;fixed&quot; this problem by loading t=
he nvidia driver<br>
&gt;&gt; (instead of nv) as default. Now the graphic cards uses IRQ 24 whic=
h does not<br>
&gt;&gt; collide with IRQ 11 of the CAN bus card (see attached lspci.txt).<=
br>
&gt;&gt;<br>
&gt;&gt; The only other device that uses IRQ 11 is<br>
&gt;&gt; # 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ES=
I Port<br>
&gt;&gt; [8086:3406] (rev 13)<br>
&gt;&gt;<br>
&gt;&gt; But I guess that is ok, is it ? I checked the FAQs and went throug=
h the list<br>
&gt;&gt; but I feel I can&#39;t do much. I will try a few things and disabl=
e everything<br>
&gt;&gt; that is unneeded. The FAQ list also suggests to enable CONFIG_PCI_=
MSI which<br>
&gt;&gt; is disabled right now. What would now be a reasonable thing to do =
?<br>
&gt;<br>
&gt; Keep PCI_MSI disabled. The FAQ is wrong and should be fixed.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; How can I find out and about which device is causing the address s=
pace<br>
&gt;&gt; collision ?<br>
&gt;&gt;<br>
&gt;&gt; # address space collision: host bridge window [mem 0xd7f00000-0xe0=
000000]<br>
&gt;&gt; conflicts with PCI Bus 0000:00 [mem 0xe0000000-0xf7ffffff]<br>
&gt;&gt;<br>
&gt;&gt; I attached the syslog of the latest boot. I enabled some debugging=
 infos<br>
&gt;&gt; which hopefully allow to trace down the problem. Interestingly, th=
is time,<br>
&gt;&gt; the kernel spit out<br>
&gt;&gt;<br>
&gt;&gt; # RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team<b=
r>
&gt;&gt;<br>
&gt;&gt; right before it froze.<br>
&gt;<br>
&gt; You should try and put some printks in RTCan code to see how far it<br=
>
&gt; goes. But I guess Wolfgang may be of more help.<br>
<br>
</div></div>Well, normally messages like:<br>
<br>
 =A0RTCAN SJA1000 driver initialized<br>
 =A0PEAK-PCI-CAN: initializing device 001c:0001<br>
 =A0PEAK-PCI-CAN: base_addr=3Dc907c000 conf_addr=3Dc907a000 irq=3D16<br>
 =A0rtcan: registered rtcan0<br>
 =A0PEAK-PCI-CAN: base_addr=3Dc907e400 conf_addr=3Dc907a000 irq=3D16<br>
 =A0rtcan: registered rtcan1<br>
<br>
should follow. I would add printk&#39;s into peak_pci_init_one() and<br>
rtcan_peak_pci_add_chan() in ksrc/drivers/can/sja1000/rtcan_peak_pci.c.<br>
Did you compile the SJA1000 driver&#39;s into the kernel? Try building<br>
modules, which you then can load manually.<br>
<br>
BTW: what PEAK PCI card are you using?<br>
<font color=3D"#888888"><br>
Wolfgang.<br>
</font></blockquote></div></div></div><br>
</blockquote></div><br>
</div></div></blockquote></div><br>

--00163642753f4b30ff049261c46a--

