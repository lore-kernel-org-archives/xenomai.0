Message-ID: <4A83108E.10309@domain.hid>
Date: Wed, 12 Aug 2009 20:57:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE20060EFA4BEC@us194mx002.tycoelectronics.net>
	<4A81CA67.9060301@domain.hid> <4A81CE4F.9060301@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4DEE@us194mx002.tycoelectronics.net>
	<4A82DC78.9060408@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4EE1@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE20060EFA4EE1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Charlton, John wrote:
> Gilles,
> 
> I am using linux kernel 2.6.27.7 and xenomai 2.4.6.1. I get the same results below after loading xeno_timerbench module:
> 
> I loaded xeno_timerbench module as follows but get the same results:
> modprobe xeno_timerbench
> 
> ./latency -t 2:
> 
> == Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> latency: failed to open benchmark device, code -38
> (modprobe xeno_timerbench?)
> 
> ./latency -t 1:
> == Sampling period: 100 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> latency: failed to open benchmark device, code -38
> (modprobe xeno_timerbench?)
> 
> cat /proc/modules:
> xeno_timerbench 5700 0 - Live 0xce9a0000
> savagefb 23520 0 - Live 0xce9a9000
> via686a 12780 0 - Live 0xce986000
> i2c_viapro 7348 0 - Live 0xce979000
> 8139cp 17152 0 - Live 0xce99a000
> i2c_core 22448 1 i2c_viapro, Live 0xce993000
> shpchp 26996 0 - Live 0xce98b000
> pci_hotplug 7492 1 shpchp, Live 0xce97d000
> via_agp 7456 1 - Live 0xce976000 

Ok. Could you show us the boot logs?


-- 
					    Gilles.

