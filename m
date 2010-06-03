Message-ID: <4C07B70E.6050303@domain.hid>
Date: Thu, 03 Jun 2010 16:07:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C04E8D8.8030101@domain.hid>	<4C04EDAF.1080800@domain.hid>	<4C051100.7000803@domain.hid>	<4C051E26.8020102@domain.hid>	<4C053217.5010809@domain.hid>	<4C053608.3030604@domain.hid>	<4C06011A.7020507@domain.hid>	<4C07A9F4.7090709@domain.hid>
	<4C07AC61.4040705@domain.hid> <4C07B031.6090504@domain.hid>
	<4C07B530.3040200@domain.hid>
In-Reply-To: <4C07B530.3040200@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux kernel 2.6.32.14 and Xenomai 2.5.2 does
	not boot
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Daniele Nicolodi wrote:
>>> Booting a working 2.6.30 kernel I noticed this error message as first
>>> output on the console. Can it be related to my issue with more modern
>>> kernels and ipipe patches?
>>>
>>> ERROR: 8254 timer not connected to IO-APIC
>>>
>>> I have no idea of what it means.
>> Is APIC enabled in your kernel configuration?
> 
> It likely is.
> 
> I'm getting this error for many kernel releases now. It must be related
> to I-pipe's patching of the APIC or IO-APIC code. Irritating but mostly
> harmless.

What I mean is that when Xenomai wants to use the 8254 (which is the
case if the APIC is disabled in linux kernel configuration) and the 8254
has become unreachable by Linux by some change in recent versions,
Xenomai timing subystem becomes screwed up.

When, on the other hand, Xenomai wants to use the APIC, the fact that
the 8254 has become unreachable is harmless.

And from the .config Daniele posted, it appears that he disabled APIC,
so that Xenomai is trying to use the 8254.

-- 
					    Gilles.

