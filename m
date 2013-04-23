Message-ID: <5176D40E.7060607@xenomai.org>
Date: Tue, 23 Apr 2013 20:33:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.252.1366321778.1444.xenomai@xenomai.org>	<00f801ce3fcb$30850ce0$918f26a0$@com>	<51763D6E.6090407@xenomai.org>
	<016901ce4043$7b54e1f0$71fea5d0$@com>
In-Reply-To: <016901ce4043$7b54e1f0$71fea5d0$@com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] for-core-3.8 on ARM ( i.MX53 )
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <GPontis@z9.com>
Cc: xenomai@xenomai.org

On 04/23/2013 06:56 PM, George Pontis wrote:

>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> Sent: Tuesday, April 23, 2013 12:51 AM
>> To: George Pontis
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai] for-core-3.8 on ARM ( i.MX53 )
>>
>> On 04/23/2013 04:35 AM, George Pontis wrote:
>>
>>> I took a crack at building a 3.8 kernel with Xenomai 2.6.2.1 for ARM,
>> based
>>> on the work in progress toward that ipipe patch.
>>
>>
>> Xenomai 2.6.2.1 will not work, please upgrade to Xenomai 2.6 current
>> git
>> and tell us if you see the same issue.
>>
>> --
>>                                                                 Gilles.
> 
> I got the current Xenomai and rebuilt with that. The process went smoothly and did not
> require any patching or manual intervention, but it still hangs at the same point. Is
> it expected that the 2.6 current tree is identifying itself as 2.6.2.1 ? 


Yes it is expected, incrementing the version number is the last thing we
do before a release. Now, about the hang, several questions:
- does the very same kernel version without CONFIG_IPIPE and
CONFIG_XENOMAI boot normally?
- are the error messages:
mmc0: no vqmmc regulator found
mmc0: no vmmc regulator found
mmc1: no vqmmc regulator found
mmc1: no vmmc regulator found
sgtl5000 1-000a: clock-frequency missing or invalid
imx-sgtl5000: probe of sound.8 failed with error -22
Expected?
- does not the message:
Console: switching to colour frame buffer device 80x30
Tell us that in fact the kernel logs are continuing on the framebuffer?
- is the timer running correctly?
- is the clocksource incrementing correctly?

Regards.

-- 
                                                                Gilles.

