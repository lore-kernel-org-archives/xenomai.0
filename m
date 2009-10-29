Message-ID: <4AE9F68A.6000700@domain.hid>
Date: Thu, 29 Oct 2009 21:09:46 +0100
From: Benjamin Biegel <biegel@domain.hid>
MIME-Version: 1.0
References: <4AE82B39.5040301@domain.hid>
	<4AE82F22.6090203@domain.hid>	<4AE86123.9060602@domain.hid>
	<4AE8789B.2020907@domain.hid> <4AE879BF.5070308@domain.hid>
	<4AE97077.1020205@domain.hid> <4AE980C6.2030104@domain.hid>
	<4AE98AF7.5090706@domain.hid> <4AE99653.3090303@domain.hid>
In-Reply-To: <4AE99653.3090303@domain.hid>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Just to close the thread.<br>
<br>
The following solved the problem:<br>
I disabled the on-board NIC and added a PCI-NIC and changed this
PCI-NIC to eth0. This NIC shared interrupt with an unused USB-port only.<br>
<br>
Thanks again for helping me out!<br>
<br>
Benjamin<br>
<br>
Jan Kiszka wrote:
<blockquote cite="mid:4AE99653.3090303@domain.hid" type="cite">
  <pre wrap="">[argh, please don't post html mails, they are unreadable in text mode]

Benjamin Biegel wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Jan Kiszka wrote:

Benjamin Biegel wrote:


Thanks for your help.

I now recompiled with the your suggestions. The config-file generated my gconfig is attached.

The xenomai examples work. But when i do the local loopback test described in:
<a class="moz-txt-link-freetext" href="http://www.xenomai.org/index.php/RTnet:Installation_%26_Testing">http://www.xenomai.org/index.php/RTnet:Installation_%26_Testing</a>
the computer freezes after some time after the command './rtnet start'. It does not even show 'waiting for slaves'.

If i do the ctrl + backslash quit after running './rtnet start' i can see with lsmod that rtmac rtcft rt_loopback rt_e1000 rtpacket rtipv4 rtnet are loaded. But even if i do this forced quit the PC freezes.



I guess the freeze is finally triggered by rtifconfig rteth0 up. What is
/proc/interrupts reporting when you loaded standard e1000 and enabled
the interface under Linux (/me is looking for IRQ conflicts)?


When i boot Xenomai normally and look in /proc/interrupts, i get the list attached. Is this what can show IRQ conflicts? lsmod shows that e1000 is loaded at boot.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
OK, so the e1000 (eth0) IRQ is now shared with your ATA controller - not
good.

Unless your e1000 is on a real PCI card that could be flips around in
some slots and/or its IRQ can configured in the BIOS, I'm afraid there
is no way around MSI. But if MSI should not used by the e1000 even if
enabled, then your system is actually unusable for RT-Ethernet. So, try
to re-enable MSI and check if the IRQ assignment changes. eth0 must
finally end up with an exclusively used IRQ.

Jan

  </pre>
</blockquote>
<br>
</body>
</html>

