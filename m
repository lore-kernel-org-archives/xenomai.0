Message-ID: <4A4B5116.3090006@domain.hid>
Date: Wed, 01 Jul 2009 14:05:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A48FB71.6070506@domain.hid> <4A49CD81.4060706@domain.hid>	
	<4A49CFF0.7070202@domain.hid> <1246353623.7803.21.camel@domain.hid>	
	<4A49D935.3060900@domain.hid> <1246353913.7803.24.camel@domain.hid>	
	<4A49DA4E.2020604@domain.hid> <1246354047.7803.25.camel@domain.hid>
	<4A49DC0A.5000208@domain.hid> <4A4A391B.8000700@domain.hid>
	<4A4B4ED4.6020208@domain.hid>
In-Reply-To: <4A4B4ED4.6020208@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] x86: Endless minor faults
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> It's still unclear what goes on precisely, we are still digging, but the
>> test system that can produce this is highly contended.
> 
> Short update: Further instrumentation revealed that cr3 differs from
> active_mm->pgd while we are looping over that fault, ie. the kernel
> tries to fixup the wrong mm. And that means we have some open race
> window between updating cr3 and active_mm somewhere (isn't switch_mm run
> in a preemptible manner now?).
> 
> As a first shot I disabled CONFIG_IPIPE_DELAYED_ATOMICSW, and we are now
> checking if it makes a difference. Digging deeper into the code in the
> meanwhile...

CONFIG_IPIPE_DELAYED_ATOMICSW is nonsense. And we don't do switch_mm
without irq protection on x86, at least not from the nucleus, right?
Maybe a race due some Linux user running it unprotectedly?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

