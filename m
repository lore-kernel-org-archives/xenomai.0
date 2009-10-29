Message-ID: <4AE99653.3090303@domain.hid>
Date: Thu, 29 Oct 2009 14:19:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AE82B39.5040301@domain.hid>
	<4AE82F22.6090203@domain.hid>	<4AE86123.9060602@domain.hid>
	<4AE8789B.2020907@domain.hid> <4AE879BF.5070308@domain.hid>
	<4AE97077.1020205@domain.hid> <4AE980C6.2030104@domain.hid>
	<4AE98AF7.5090706@domain.hid>
In-Reply-To: <4AE98AF7.5090706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Benjamin Biegel <biegel@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

[argh, please don't post html mails, they are unreadable in text mode]

Benjamin Biegel wrote:
> Jan Kiszka wrote:
> 
> Benjamin Biegel wrote:
> 
> 
> Thanks for your help.
> 
> I now recompiled with the your suggestions. The config-file generated my gconfig is attached.
> 
> The xenomai examples work. But when i do the local loopback test described in:
> http://www.xenomai.org/index.php/RTnet:Installation_%26_Testing
> the computer freezes after some time after the command './rtnet start'. It does not even show 'waiting for slaves'.
> 
> If i do the ctrl + backslash quit after running './rtnet start' i can see with lsmod that rtmac rtcft rt_loopback rt_e1000 rtpacket rtipv4 rtnet are loaded. But even if i do this forced quit the PC freezes.
> 
> 
> 
> I guess the freeze is finally triggered by rtifconfig rteth0 up. What is
> /proc/interrupts reporting when you loaded standard e1000 and enabled
> the interface under Linux (/me is looking for IRQ conflicts)?
> 
> 
> When i boot Xenomai normally and look in /proc/interrupts, i get the list attached. Is this what can show IRQ conflicts? lsmod shows that e1000 is loaded at boot.
> 

OK, so the e1000 (eth0) IRQ is now shared with your ATA controller - not
good.

Unless your e1000 is on a real PCI card that could be flips around in
some slots and/or its IRQ can configured in the BIOS, I'm afraid there
is no way around MSI. But if MSI should not used by the e1000 even if
enabled, then your system is actually unusable for RT-Ethernet. So, try
to re-enable MSI and check if the IRQ assignment changes. eth0 must
finally end up with an exclusively used IRQ.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

