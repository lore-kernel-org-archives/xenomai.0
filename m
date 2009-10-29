Message-ID: <4AE98AF7.5090706@domain.hid>
Date: Thu, 29 Oct 2009 13:30:47 +0100
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
References: <4AE82B39.5040301@domain.hid>
	<4AE82F22.6090203@domain.hid>	<4AE86123.9060602@domain.hid>
	<4AE8789B.2020907@domain.hid> <4AE879BF.5070308@domain.hid>
	<4AE97077.1020205@domain.hid> <4AE980C6.2030104@domain.hid>
In-Reply-To: <4AE980C6.2030104@domain.hid>
Content-Type: multipart/mixed; boundary="------------050606040009060700050800"
Subject: Re: [Xenomai-help] RTnet install problem: Xenomai
 configuration	tool not found
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050606040009060700050800
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Jan Kiszka wrote:
<blockquote cite="mid:4AE980C6.2030104@domain.hid" type="cite">
  <pre wrap="">Benjamin Biegel wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Thanks for your help.

I now recompiled with the your suggestions. The config-file generated my gconfig is attached.

The xenomai examples work. But when i do the local loopback test described in:
<a class="moz-txt-link-freetext" href="http://www.xenomai.org/index.php/RTnet:Installation_%26_Testing">http://www.xenomai.org/index.php/RTnet:Installation_%26_Testing</a>
the computer freezes after some time after the command './rtnet start'. It does not even show 'waiting for slaves'.

If i do the ctrl + backslash quit after running './rtnet start' i can see with lsmod that rtmac rtcft rt_loopback rt_e1000 rtpacket rtipv4 rtnet are loaded. But even if i do this forced quit the PC freezes.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I guess the freeze is finally triggered by rtifconfig rteth0 up. What is
/proc/interrupts reporting when you loaded standard e1000 and enabled
the interface under Linux (/me is looking for IRQ conflicts)?<font
 color="#330099">
</font></pre>
</blockquote>
<font color="#330099">When i boot Xenomai normally and look in
/proc/interrupts, i get the list attached. Is this what can show IRQ
conflicts? lsmod shows that e1000 is loaded at boot.</font><br>
<blockquote cite="mid:4AE980C6.2030104@domain.hid" type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">Is it possible it would not crash if there were actually slaves?

Or do you have other suggestions?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
If the above reports no clashes for e1000's IRQ line, please attach a
serial or netconsole and try to capture any potential oops via a second
PC. See linux/Documentation/serial-console.txt or
linux/Documentation/networking/netconsole.txt for details.
  </pre>
</blockquote>
<font color="#330099">Does the /proc/interrupts file show that
serial-console/netconsole is the next step? Would it be easier to try
and install Xenomai + RTnet on another computer? Or is it normal that
an amount of problems have to be solved first?<br>
<br>
Thanks again :)<br>
</font>
<blockquote cite="mid:4AE980C6.2030104@domain.hid" type="cite">
  <pre wrap="">
Jan

  </pre>
</blockquote>
<br>
</body>
</html>

--------------050606040009060700050800
Content-Type: text/plain;
 name="interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts"

           CPU0       
  0:         84   IO-APIC-edge      timer
  1:        168   IO-APIC-edge      i8042
  4:          2   IO-APIC-edge    
  7:          1   IO-APIC-edge      parport0
  8:          1   IO-APIC-edge      rtc0
  9:          0   IO-APIC-fasteoi   acpi
 12:       1611   IO-APIC-edge      i8042
 14:          0   IO-APIC-edge      ata_piix
 15:       1173   IO-APIC-edge      ata_piix
 16:          0   IO-APIC-fasteoi   uhci_hcd:usb2, uhci_hcd:usb5
 17:       2273   IO-APIC-fasteoi   Intel ICH5
 18:       7157   IO-APIC-fasteoi   ata_piix, uhci_hcd:usb4, eth0
 19:          0   IO-APIC-fasteoi   uhci_hcd:usb3
 23:          0   IO-APIC-fasteoi   ehci_hcd:usb1
NMI:          0   Non-maskable interrupts
LOC:       5991   Local timer interrupts
RES:          0   Rescheduling interrupts
CAL:          0   Function call interrupts
TLB:          0   TLB shootdowns
SPU:          0   Spurious interrupts
ERR:          0
MIS:          0


--------------050606040009060700050800--

