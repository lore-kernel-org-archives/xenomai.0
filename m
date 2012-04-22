Message-ID: <4F93A3EA.7010802@domain.hid>
Date: Sun, 22 Apr 2012 08:23:38 +0200
From: xenophile <xenophile@domain.hid>
MIME-Version: 1.0
References: <mailman.0.1334997334.18156.xenomai@xenomai.org>
	<4F931496.1060607@domain.hid> <4F93208F.4040600@domain.hid>
In-Reply-To: <4F93208F.4040600@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] linux 2.6.11
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

On 21/04/12 23:03, Gilles Chanteperdrix wrote:
> On 04/21/2012 10:12 PM, xenophile wrote:
>> Hi,
>>
>> I am trying to see why a trivial driver reading an ADC on an EP9312 ARM
>> board has slowed by a factor of three. Since I installed it under 2.6.29
>> a couple fo years ago.
>>
>> It's looking like this is due to a kernel update I did in the mean time
>> to 2.6.32
>
> If the kernel is patched with Xenomai, did you check that you have the
> same setting for FCSE ? Other than that, you can have an idea of how the
> time is spent in both cases using the I-pipe tracer.
>

I'm interested in exploring RT on this hardware and part of the change 
of kernel was to move to more recent kernel which has better support for 
this board and to find a kernel that has been used RT with this type of 
hardware so that I don't have to start from scratch.

Yesterday I tested 2.6.33 and it was equally slow. I need to find out if 
this is due to kernel version or gcc. (4.3.4)

I need to resolve the cause of this factor of 2 or 3 slow down before I 
get involved in xenomia patching so as to start from a sound base.

>> Would there be any value in trying to rebuild a 2.6.11 based system for
>> realtime work ?
>
> xenomai comes with a latency test that you can run on any two
> configuration to compare their latencies. If you go on the adeos project
> download area:
> http://download.gna.org/adeos/patches/
>
> You will find kernel patches for versions such as 2.6.13 or 2.6.14, they
> are supposed to work with xenomai latest stable release. You can even
> find patches for 2.4 kernels for i386 and ppc.
>
> Chances are however that these patches have bugs which have been fixed
> since then (after all, 2.6.11 is 7 years old).
>

Thanks, I was hoping to find some comments on which kernels are more 
responsive. I'm sure there's good and bad since RT is not one of the 
main priorities for kernel development, this may not be a case of the 
most recent being the best.

 From a simple user experience circa 2.6.11 was hugely more responsive 
than the more recent offerings. Maybe 2.6.13 or 2.6.14 are close enough 
to be in the same league.

I would have thought this sort of thing would have been thoroughly 
investigated by RT people and would be documented.

regards.




