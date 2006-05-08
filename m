Message-ID: <445EB95C.6050302@domain.hid>
Date: Sun, 07 May 2006 23:22:04 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] kconfig help questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>


Going thru xenomai Kconfig again, some observations/uncertainties came up.
I'll make a patch, given feedback.

XENO_OPT_TIMING_PERIODIC

"Aperiodic mode provides for non-constant delays between timer ticks,"

the wording here (non-constant delays) left me momentarily wondering
if _APERIODIC was bad (this, despite the use of 'provides'). 
Maybe "sub-tick delays" makes some sense ..

XENO_OPT_SHIRQ_LEVEL

Are there any decent estimates or examples of the latency / jitter increases
if this is enabled ?  Is it highly cpu or chipset dependent ?
I presume /proc/interrupts is the place to look to see if you might need it,
iff any of the devices of interest are shared.
my laptop shows sharing, my soekris does not

  3:          5          XT-PIC  ehci_hcd:usb1, ohci1394
  4:          0          XT-PIC  uhci_hcd:usb6
  7:     708975          XT-PIC  ipw2200, ehci_hcd:usb2, uhci_hcd:usb7
  8:          1          XT-PIC  rtc
  9:     437509          XT-PIC  acpi, Intel 82801DB-ICH4, Intel 
82801DB-ICH4 Modem, ohci_hcd:usb3, ohci_hcd:usb4, uhci_hcd:usb5, yenta, eth0

# cat /proc/interrupts
           CPU0
  0:   13148086          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:      33084          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:     337134          XT-PIC  eth0
 11:     926639          XT-PIC  ndiswrapper
 14:         11          XT-PIC  ide0
NMI:          0


XENO_OPT_SHIRQ_EDGE

does this only apply to ISA bus ?

XENO_SKIN_NATIVE

will add module name

XENO_OPT_NATIVE_INTR

Note that the preferred
way of implementing generic drivers usable across all Xenomai
interfaces is defined by the Real-Time Driver Model (RTDM).

It doesnt say theyre (in)?compatible, should it ?


SUMMARY

Id like to see estimates of the latency costs associated with each choice,
where its practical to do so (given the current unknowables, like 
variations across
cpus, chipsets etc).  I recognize that such numbers are the hoped-for
end result of the xenomai-data ML, and perhaps nothing real can be said
yet (or ever) in Kconfig, except in (overly?) broad statements.




