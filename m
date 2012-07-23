Message-ID: <500D7FD9.2040300@nta-inc.net>
Date: Mon, 23 Jul 2012 11:46:17 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <5009DF76.5010306@nta-inc.net> <500C7472.50601@xenomai.org>
In-Reply-To: <500C7472.50601@xenomai.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: Re: [Xenomai] Issue with Xenomai 2.6.1 / Linux 2.6.38.8 on logout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 07/22/2012 04:45 PM, Philippe Gerum wrote:
> On 07/21/2012 12:45 AM, Jeff Webb wrote:
>> I have built and installed Xenomai 2.6.1 with a Linux 2.6.38.8 kernel on
>> an Intel X5650 machine running Ubuntu 10.04.  It seems to boot and run
>> fine.  If I try to log out of my GUI session, the monitors go into power
>> save mode and never come back.  I can SSH into the machine to reboot
>> it.  I get the following in /var/log/syslog:
>>
>> irq 16: nobody cared (try booting with the "irqpoll" option)
>> Pid: 2694, comm: Xorg Tainted: P            2.6.38.8-xenomai-2.6.1 #1
>> Call Trace:
>>   [<ffffffff8109da26>] ? __report_bad_irq+0x26/0xa0
>>   [<ffffffff8109dc2c>] ? note_interrupt+0x18c/0x1d0
>>   [<ffffffff8109e89d>] ? handle_fasteoi_irq+0xed/0x120
>>   [<ffffffff81005bdd>] ? handle_irq+0x1d/0x30
>>   [<ffffffff81005091>] ? do_IRQ+0x61/0xf0
>>   [<ffffffff810a4790>] ? __ipipe_sync_stage+0x1f0/0x1f6
>>   [<ffffffff81005030>] ? do_IRQ+0x0/0xf0
>>   [<ffffffff810a4796>] ? __xirq_end+0x0/0xa
>>   [<ffffffff81005030>] ? do_IRQ+0x0/0xf0
>>   [<ffffffff810a4c0e>] ? __ipipe_walk_pipeline+0x10e/0x120
>>   [<ffffffff8101c587>] ? __ipipe_handle_irq+0x137/0x300
>>   [<ffffffff8109e0b0>] ? __ipipe_ack_fasteoi_irq+0x0/0x20
>>   [<ffffffff81555ad3>] ? common_interrupt+0x13/0x30
>> handlers:
>> [<ffffffff813e2990>] (usb_hcd_irq+0x0/0xb0)
>> Disabling IRQ #16
>>
>> I have tried changing some kernel config option to no avail.  I have
>> attached the .config that goes with the information above.  Any help in
>> debugging would be appreciated.
>>
>
> Could you provide a dump of /proc/interrupts?

I have attached dumps of /proc/interrupts before and after things went bad.=
  Here is the corresponding stack trace from this event:

irq 16: nobody cared (try booting with the "irqpoll" option)
Pid: 0, comm: kworker/0:1 Tainted: P            2.6.38.8-xenomai-2.6.1 #1
Call Trace:
[<ffffffff8109da26>] ? __report_bad_irq+0x26/0xa0
[<ffffffff8109dc2c>] ? note_interrupt+0x18c/0x1d0
[<ffffffff8109e89d>] ? handle_fasteoi_irq+0xed/0x120
[<ffffffff81005bdd>] ? handle_irq+0x1d/0x30
[<ffffffff81005091>] ? do_IRQ+0x61/0xf0
[<ffffffff810a4790>] ? __ipipe_sync_stage+0x1f0/0x1f6
[<ffffffff81005030>] ? do_IRQ+0x0/0xf0
[<ffffffff810a4796>] ? __xirq_end+0x0/0xa
[<ffffffff81005030>] ? do_IRQ+0x0/0xf0
[<ffffffff810a4c0e>] ? __ipipe_walk_pipeline+0x10e/0x120
[<ffffffff8101c587>] ? __ipipe_handle_irq+0x137/0x300
[<ffffffff8109e0b0>] ? __ipipe_ack_fasteoi_irq+0x0/0x20
[<ffffffff81555ad3>] ? common_interrupt+0x13/0x30
[<ffffffff8101cb16>] ? __ipipe_halt_root+0x26/0x40
[<ffffffff81559245>] ? atomic_notifier_call_chain+0x15/0x20
[<ffffffff8100b467>] ? default_idle+0x27/0x40
[<ffffffff8100203f>] ? cpu_idle+0xbf/0x110
[<ffffffff8154f499>] ? start_secondary+0x1cc/0x1d3
handlers:
[<ffffffff813e2990>] (usb_hcd_irq+0x0/0xb0)
Disabling IRQ #16



-------------- next part --------------
            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5    =
   CPU6       CPU7       CPU8       CPU9       CPU10      CPU11      CPU12 =
     CPU13      CPU14      CPU15      CPU16      CPU17      CPU18      CPU1=
9      CPU20      CPU21      CPU22      CPU23      =

   0:         54          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge      timer
   1:          3          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge      i8042
   4:        369          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge    =

   7:          1          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge      parport0
   8:          1          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge      rtc0
   9:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   acpi
  12:          6          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge      i8042
  16:         25          0         13          0          0          0    =
      0     199963          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:u=
sb3
  17:        194          0         61          0          0          0    =
      0          0          6          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:u=
sb4, uhci_hcd:usb7
  18:        186       1363          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:u=
sb8
  22:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:u=
sb1, uhci_hcd:usb5
  23:          4          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:u=
sb2, uhci_hcd:usb6
  24:         35          0          0          0          0          0    =
     65          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   nvidia
  90:       9695          0          0          0          0          0    =
   4025          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   PCI-MSI-edge      ahci
  91:        511          0          0          0          0          0    =
      0          0          0          0          0          0       2477  =
        0          0          0          0          0          0          0=
          0          0          0          0   PCI-MSI-edge      eth0
  92:        638          0          0          0          0          0    =
      0          0        490          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   PCI-MSI-edge      hda_intel
 NMI:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Non-maskable interrupts
 LOC:      10187       6126       2655       1303        983        980    =
   6265       2846      10789       1199       2046       2486       4813  =
     9435       1779       1575       1131        846       2360       7006=
       7805       1518       1305        885   Local timer interrupts
 SPU:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Spurious interrupts
 PMI:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Performance monitoring inter=
rupts
 IWI:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IRQ work interrupts
 RES:       8085       5795       2484        861        468        291    =
   4156       2585        982        615        348        384       2601  =
     2813        574        396        229        237       1389       2274=
        717        446        361        180   Rescheduling interrupts
 CAL:       3186        350        345        343        396        345    =
   1465        357        781        466        565        308        339  =
      345        345        363        341        349        343        343=
        408        343        343        344   Function call interrupts
 TLB:        322        176         90         58         50         25    =
    226        207        125         81         72         69        212  =
      536        175        131         51        107        178       1448=
        304        159        106         60   TLB shootdowns
 TRM:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Thermal event interrupts
 THR:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Threshold APIC interrupts
 MCE:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Machine check exceptions
 MCP:          2          2          2          2          2          2    =
      2          2          2          2          2          2          2  =
        2          2          2          2          2          2          2=
          2          2          2          2   Machine check polls
 ERR:          0
 MIS:          0
-------------- next part --------------
            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5    =
   CPU6       CPU7       CPU8       CPU9       CPU10      CPU11      CPU12 =
     CPU13      CPU14      CPU15      CPU16      CPU17      CPU18      CPU1=
9      CPU20      CPU21      CPU22      CPU23      =

   0:         54          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge      timer
   1:          3          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge      i8042
   4:        369          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge    =

   7:          1          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge      parport0
   8:          1          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge      rtc0
   9:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   acpi
  12:          6          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-edge      i8042
  16:         25          0         13          0          0          0    =
      0         83          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:u=
sb3
  17:        194          0         33          0          0          0    =
      0          0          6          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:u=
sb4, uhci_hcd:usb7
  18:        186       1152          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   uhci_hcd:u=
sb8
  22:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:u=
sb1, uhci_hcd:usb5
  23:          4          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   ehci_hcd:u=
sb2, uhci_hcd:usb6
  24:         35          0          0          0          0          0    =
     53          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IO-APIC-fasteoi   nvidia
  90:       9695          0          0          0          0          0    =
   3807          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   PCI-MSI-edge      ahci
  91:        511          0          0          0          0          0    =
      0          0          0          0          0          0       2402  =
        0          0          0          0          0          0          0=
          0          0          0          0   PCI-MSI-edge      eth0
  92:        638          0          0          0          0          0    =
      0          0        490          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   PCI-MSI-edge      hda_intel
 NMI:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Non-maskable interrupts
 LOC:       9979       5661       2448       1241        901        829    =
   5730       2564      10738       1172        759        811       4523  =
     8887       1729       1506       1090        814       2249       6795=
       6685       1478       1282        859   Local timer interrupts
 SPU:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Spurious interrupts
 PMI:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Performance monitoring inter=
rupts
 IWI:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   IRQ work interrupts
 RES:       7678       5479       2266        714        362        235    =
   4059       2517        953        599        336        368       2424  =
     2524        516        356        173        189       1344       2229=
        701        433        353        176   Rescheduling interrupts
 CAL:       2953        249        235        233        286        235    =
   1376        246        671        356        454        276        229  =
      235        235        253        231        239        234        233=
        298        233        233        234   Function call interrupts
 TLB:        302        165         75         45         37         17    =
    221        199        116         67         66         59        183  =
      511        157        119         42         99        162       1430=
        297        149        104         59   TLB shootdowns
 TRM:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Thermal event interrupts
 THR:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Threshold APIC interrupts
 MCE:          0          0          0          0          0          0    =
      0          0          0          0          0          0          0  =
        0          0          0          0          0          0          0=
          0          0          0          0   Machine check exceptions
 MCP:          2          2          2          2          2          2    =
      2          2          2          2          2          2          2  =
        2          2          2          2          2          2          2=
          2          2          2          2   Machine check polls
 ERR:          0
 MIS:          0
