Message-ID: <cbe23c50702090939g4709270aicaea7b7870398e0a@domain.hid>
Date: Fri, 9 Feb 2007 18:39:13 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] Multiple NIC trouble
In-Reply-To: <45CCAAC6.3040901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>
	<17864.63903.244809.994959@domain.hid>
	<cbe23c50702062357m6d8b913fsc65af3339ba092de@domain.hid>
	<45C9B7C4.8050705@domain.hid>
	<cbe23c50702080711s18459ea7le22545518bfc7c6f@domain.hid>
	<45CB4291.408@domain.hid>
	<cbe23c50702090849i3bfff5a0j64acbcd58163f880@domain.hid>
	<45CCA96C.7080605@domain.hid> <45CCAAC6.3040901@domain.hid>
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
Cc: Xenomai help <xenomai@xenomai.org>

2007/2/9, Jan Kiszka <jan.kiszka@domain.hid>:
>
> And when playing with the config: Enable the NMI watchdog in Xenomai and
> pass "nmi_watchdog=2" as kernel parameter. Unless something is totally
> screwed after the lockup, this should choke.

Ok for that too,
regarding NMI my current kernel compile option are:

zcat /proc/config.gz | grep DEBUG | egrep -e "NMI"
CONFIG_XENO_HW_NMI_DEBUG_LATENCY=y
CONFIG_XENO_HW_NMI_DEBUG_LATENCY_MAX=100

>From what I understand from Documentation/nmi_watchdog.txt
I already a have NMI Watchdog activated since my kernel is SMP.
Moreover:
zcat /proc/config.gz | grep APIC
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

did I miss something?

Nevertheless I did not add the kernel boot parameter nmi_watchdog=2
and I will on next test cycle.

-- 
Erk

