Message-ID: <50AA5B96.9060009@xenomai.org>
Date: Mon, 19 Nov 2012 17:17:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi-O4C=z-sXqrq7HMTQ=B2apBBnZMco0p-_iHmfuu+Jexg@mail.gmail.com>	<50AA4EC2.1000206@xenomai.org>
	<CANzNmi-dFbx043zCszBwYu2yZh3awGkRAArwOnaTq3k=ijffdA@mail.gmail.com>
In-Reply-To: <CANzNmi-dFbx043zCszBwYu2yZh3awGkRAArwOnaTq3k=ijffdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Help with Xeno-test please
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 11/19/2012 04:39 PM, Sebastian Pavez wrote:
> 2012/11/19 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> On 11/19/2012 04:10 PM, Sebastian Pavez wrote:
>>> Hi everybody!
>>>
>>> I'm trying to get the latencies values with some load, but I think I'm
>>> doing something wrong. Below is the command I tried and the results, are
>>> they the rights parameters? if not, wich ones I should use instead? Some
>>> recommendations will be appreciated. I read that the xeno-test runs by
>>> default for 15 min, but I'm not getting that behaviour.
>>>
>>> Please some insights, Seba.
>>>
>>>
>>> root@labcontrol:~# /usr/xenomai/bin/xeno-test -l "dohell -b
>>> /usr/bin/hackbench  -s 192.168.0.5 -l /usr/src/linux-3.2.32/fs/ubifs |
>> 100"
>>
>> The pipe in dohell help string is a "logical or", indicating that you
>> should either pass the path to ltp installation directory OR a duration
>> IN SECONDS.
>>
>> --
>>                                             Gilles.
>>
> 
> Thanks for your answer,
> I made the change you suggest me, but I'm getting the same behaviour. It
> only runs 30 seconds by the clocktest ...
> 
> root@labcontrol:~# /usr/xenomai/bin/xeno-test -l "dohell -b
> /usr/bin/hackbench  -s 192.168.0.5 -l 100"

So, you installed ltp in a directory named "100" ?

> == FPU check routines: OK.
> == Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
> rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10
> rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16
> rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21
> rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4
> rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10
> rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16
> rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21
> rtuo_ufpp_ufps1-22 sleeper_ufps2-0 rtk2-1 rtk2-2 rtk_fp2-3 rtk_fp2-4
> rtk_fp_ufpp2-5 rtk_fp_ufpp2-6 rtup2-7 rtup2-8 rtup_ufpp2-9 rtup_ufpp2-10
> rtus2-11 rtus2-12 rtus_ufps2-13 rtus_ufps2-14 rtuo2-15 rtuo2-16
> rtuo_ufpp2-17 rtuo_ufpp2-18 rtuo_ufps2-19 rtuo_ufps2-20 rtuo_ufpp_ufps2-21
> rtuo_ufpp_ufps2-22 sleeper_ufps3-0 rtk3-1 rtk3-2 rtk_fp3-3 rtk_fp3-4
> rtk_fp_ufpp3-5 rtk_fp_ufpp3-6 rtup3-7 rtup3-8 rtup_ufpp3-9 rtup_ufpp3-10
> rtus3-11 rtus3-12 rtus_ufps3-13 rtus_ufps3-14
> ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory

That is another issue:
http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_switchtest_fails_with_pthread_create_resource_temporarily_unavailable


-- 
					    Gilles.

