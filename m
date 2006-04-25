Message-ID: <444E9017.6070105@domain.hid>
Date: Tue, 25 Apr 2006 23:09:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Profiling software
References: <hlb2i3-ur5.ln1@domain.hid> <444E8E99.2050805@domain.hid>
In-Reply-To: <444E8E99.2050805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Bernhard Walle <bernhard.walle@domain.hid>

Philippe Gerum wrote:
> Bernhard Walle wrote:
> 
>> Hello,
>>
>> is it possible to run LTTng together with Xenomai? Or is there any
>> other profiling software that works with Xenomai? Thanks.
>>
>>
> 
> Xenomai supports LTT oldgen on x86 for now, over 2.6.9 IIRC, since it's 
> the latest kernel LTT did support.
> 
> For performance profiling, oprofile over a Xenomai-enabled kernel works.
> 

I nearly forgot the most important: thanks to Jan, we do have a built-in 
performance profiler in recent Adeos releases for x86, providing precise 
timing information about a running kernel, which can be used to locate 
high latency spots for instance.

The patches in the following directory should be applied incrementally 
against an Adeos-patched kernel:
http://download.gna.org/adeos/patches/v2.6/i386/tracer/

A ppc version is in preparation.

-- 

Philippe.

