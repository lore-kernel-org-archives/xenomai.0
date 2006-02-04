Message-ID: <43E4FB8C.2050405@domain.hid>
Date: Sat, 04 Feb 2006 20:07:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] SMI-doc improvement / RTDM paper
References: <43E4F63C.4090200@domain.hid> <43E4FAD7.7060804@domain.hid>
In-Reply-To: <43E4FAD7.7060804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Hannes Mayer wrote:
> Hi all!
> 
> Jan Kiszka wrote:
> [...]
> 
>> +    printk("Xenomai: Intel chipset found but SMI workaround not 
>> enabled in kernel\n"
>> +           "         configuration. You may encounter high interrupt 
>> latencies.\n");
> 
> 
> Speaking of printk. Since 2.1 I don't see any messages in the
> kernel log. I bet there is a new switch somewhere, but I
> can't find it. Any hint appreciated.
> 

dmesg | grep -i xenomai: ?

> BTW, Jan, the SMI seems to be disabled now, even if I haven't
> seen the message of disabling SMI in the klog.
> 
> Thanks & best regards,
> Hannes.
> 
> 


-- 

Philippe.

