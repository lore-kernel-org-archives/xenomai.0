Date: Thu, 14 Feb 2013 13:12:37 +0100 (CET)
From: hahnchristopher@arcor.de
Message-ID: <224444793.158669.1360843957336.JavaMail.ngmail@webmail16.arcor-online.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] kernel configuration problems with ACPI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hey guys,

I'm running the new Xenomai 2.6.2.1 with 3.5.7 Kernel on a x86 machine.
I tried several kernel configurations, but I haven't found the right one ye=
t.

The PC (ADLD25PC) uses a PEAK-Systems PCIE/104 CAN interface and two serial=
port devices.

I have selected the CAN driver and 16550A driver as kernel modules. =



With kernel configuration "-xenomai4"  the serial and can devices works, bu=
t there are only 2 CPUs detected - so the hyperthreading cores arn't detect=
ed.
And I get a message during bootup "BIOS bug, no explicit IRQ entries, using=
 default mptable. (tell your hw vendor)."
This is my "best" solution so far - CONFIG_ACPI is completely disabled.


In "-xenomai5" configuration is ACPI enabled as you can see in the attached=
 kernel configs.
The mptable message disappears, 4 cores are detected, but serial and can de=
vice IRQs get disabled.
The can interface and a usb hub get IRQ 19 - thats solvable for me, but the=
 serialport on IRQ 4 gets disabled and I don't know why. (lspci -v log is a=
lso attached)


Could you point me in a direction how to combine the advantages of the two =
configurations?


Thank you,

Christopher




-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspci.log
Type: text/x-log
Size: 9114 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130214/59b05cb=
d/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-3.5.7-xenomai4
Type: application/octet-stream
Size: 135282 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130214/59b05cb=
d/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-3.5.7-xenomai5
Type: application/octet-stream
Size: 137375 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130214/59b05cb=
d/attachment-0001.obj>
