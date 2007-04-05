Date: Thu, 5 Apr 2007 16:25:58 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
Message-ID: <20070405162558.23084607@domain.hid>
In-Reply-To: <1175766682.7594.9.camel@domain.hid>
References: <20070403143122.4ac4ffaf@domain.hid>
	<46124C61.3070107@domain.hid>
	<20070403162752.2d4a1ae6@domain.hid>
	<46126603.1050007@domain.hid>
	<20070403170416.6c3f7ded@domain.hid>
	<46126DC3.8070905@domain.hid>
	<20070403171828.2da9c6fa@domain.hid>
	<46127166.9040503@domain.hid>
	<20070403175535.7340cc06@domain.hid>
	<46127DD8.8060502@domain.hid>
	<20070404181558.0ba333da@domain.hid>
	<4613D7CC.2040703@domain.hid>
	<20070405092815.15bd1af1@domain.hid>
	<20070405101200.10084177@domain.hid>
	<4614BA29.3010609@domain.hid>
	<20070405113420.0d2cc0ae@domain.hid>
	<1175766682.7594.9.camel@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

On Thu, 05 Apr 2007 11:51:22 +0200
Philippe Gerum <rpm@xenomai.org> wrote:

>try preventing the yenta module
no change, frozen a few seconds after modprobe xeno_native

> Try downgrading from SMP to UP, without IO-APIC support but still
> keeping ACPI enabled, for the purpose of testing:
> 1) Does this work?
yes, and the PC is still alive... but in fact it is only half of the original
laptop !
> 2) What does /proc/interrupts say?
           CPU0       
  0:     155256    XT-PIC-XT        timer, rthal_broadcast_timer
  1:        264    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  3:          0    XT-PIC-XT        uhci_hcd:usb4
  5:          0    XT-PIC-XT        uhci_hcd:usb3
  8:          1    XT-PIC-XT        rtc
  9:        173    XT-PIC-XT        acpi, uhci_hcd:usb1, ehci_hcd:usb5
 10:       1266    XT-PIC-XT        uhci_hcd:usb2, HDA Intel, eth0
 11:       5826    XT-PIC-XT        i915@domain.hid
 12:        115    XT-PIC-XT        i8042
 14:      13322    XT-PIC-XT        libata
 15:       1265    XT-PIC-XT        libata
NMI:        572 
LOC:     153853 
ERR:          0

tests available in xenomai/bin run normally with the following figures (under X
windows, with no additionnal load):

root@domain.hid$ ./irqbench 
CPU frequency: 1664.442 MHz
Port type:     serial
Port address:  0x3f8

Waiting on target...
root@domain.hid$ ./switchbench 
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|       1.610|       1.704|      13.133|           0

root@domain.hid$ ./latency 
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.902|       1.305|      11.990|       0|       0.902|      11.990
RTD|       0.812|       1.316|       9.165|       0|       0.812|      11.990
RTD|       0.950|       1.333|      12.679|       0|       0.812|      12.679
RTD|       0.740|       1.326|      10.139|       0|       0.740|      12.679
RTD|       0.746|       1.332|       9.400|       0|       0.740|      12.679
RTD|       0.848|       1.324|       9.366|       0|       0.740|      12.679
RTD|       0.788|       1.327|       9.135|       0|       0.740|      12.679
RTD|       0.926|       1.326|       9.383|       0|       0.740|      12.679
RTD|       0.800|       1.321|      10.248|       0|       0.740|      12.679
RTD|       0.752|       1.321|      10.079|       0|       0.740|      12.679
---|------------|------------|------------|--------|-------------------------
RTS|       0.740|       1.323|      12.679|       0|    00:00:10/00:00:10
root@domain.hid$ rmmod xeno_posix xeno_native  xeno_nucleus

   Daniel

-- 
      Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
ZIRST, 655 avenue de l'Europe, 38330 MONTBONNOT SAINT MARTIN, FRANCE 
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
	 http://necs.inrialpes.fr/people/simon/



