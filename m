Message-ID: <4AE980C6.2030104@domain.hid>
Date: Thu, 29 Oct 2009 12:47:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AE82B39.5040301@domain.hid>
	<4AE82F22.6090203@domain.hid>	<4AE86123.9060602@domain.hid>
	<4AE8789B.2020907@domain.hid> <4AE879BF.5070308@domain.hid>
	<4AE97077.1020205@domain.hid>
In-Reply-To: <4AE97077.1020205@domain.hid>
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

Benjamin Biegel wrote:
> Thanks for your help.
> 
> I now recompiled with the your suggestions. The config-file generated my gconfig is attached.
> 
> The xenomai examples work. But when i do the local loopback test described in:
> http://www.xenomai.org/index.php/RTnet:Installation_%26_Testing
> the computer freezes after some time after the command './rtnet start'. It does not even show 'waiting for slaves'.
> 
> If i do the ctrl + backslash quit after running './rtnet start' i can see with lsmod that rtmac rtcft rt_loopback rt_e1000 rtpacket rtipv4 rtnet are loaded. But even if i do this forced quit the PC freezes.

I guess the freeze is finally triggered by rtifconfig rteth0 up. What is
/proc/interrupts reporting when you loaded standard e1000 and enabled
the interface under Linux (/me is looking for IRQ conflicts)?

> 
> Is it possible it would not crash if there were actually slaves?
> 
> Or do you have other suggestions?

If the above reports no clashes for e1000's IRQ line, please attach a
serial or netconsole and try to capture any potential oops via a second
PC. See linux/Documentation/serial-console.txt or
linux/Documentation/networking/netconsole.txt for details.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

