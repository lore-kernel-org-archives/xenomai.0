From: "Beaufils Sylvie (IT&LAB)" <sylvie.beaufils@thomson-networks.com>
Date: Thu, 27 Dec 2012 13:44:30 +0000
Message-ID: <14AA522E86E5754F8BC33C742D045A4A8135033E@srv0024.corp.thvnet.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Pb with PCIe card using IRQ 32 on x86_64 platform
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

We try to add a PCIe HBA SAS Adaptec 1405 to a x86_64 platform (Xeon E5-165=
0).

It runs fine with a kernel 3.2.35 without xenomai, whatever the PCIe slot.

With (kernel 3.2.35 + ipipe-core-3.2.21-x86-2 + xenomai 2.6.1), it depends =
on the PCIe slot: it runs fine if it gets IRQ 34 but in another slot it get=
s IRQ 32 and hdd is not detected. dmesg shows mvsas errors:

[    2.420330] mvsas 0000:03:00.0: PCI INT A -> GSI 32 (level, low) -> IRQ =
32
. . .
[    5.072211] sas: DOING DISCOVERY on port 0, pid:5
. . .
[   26.150292] sas: command 0xffff8804682a1ec0, task 0xffff8804682a2cc0, ti=
med out: BLK_EH_NOT_HANDLED
[   26.150304] sas: Enter sas_scsi_recover_host
[   26.150307] sas: trying to find task 0xffff8804682a2cc0
[   26.150310] sas: sas_scsi_find_task: aborting task 0xffff8804682a2cc0

Moreover, IRQ 16 gets disabled after 2 messages "irq 16: nobody cared". I t=
ried with "irqpoll" boot option: hdd is working but without interrupts.

CONFIG_X86_LOCAL_APIC and CONFIG_X86_IO_APIC are enabled. I didn't find any=
thing in the BIOS to change the IRQ assignment.=20

I also compiled ipipe.git core-3.4 from git.denx.de with same results.

I've seen in the source code that 32 is already used by IRQ_MOVE_CLEANUP_VE=
CTOR, is it related to my problem? Is there a way to get the PCIe card work=
ing with IRQ 32 ?
=20
I can provide the whole kernel config and dmesg if needed.

Thanks,
Sylvie

