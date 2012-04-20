Message-ID: <4F918990.7060200@domain.hid>
Date: Fri, 20 Apr 2012 18:06:40 +0200
From: Michael Trimarchi <michael@domain.hid>
MIME-Version: 1.0
References: <4F8FE2A9.8080303@domain.hid> <4F8FEF3C.5010905@domain.hid>
	<4F917BA4.1090804@domain.hid>
	<4F9181A3.9070306@domain.hid>
In-Reply-To: <4F9181A3.9070306@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] IMX25 timer access patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>, Michael Trimarchi <trimarchi@domain.hid>

Hi

On 04/20/2012 05:32 PM, Gilles Chanteperdrix wrote:
> On 04/20/2012 05:07 PM, Michael Trimarchi wrote:
>> Hi Gilles
>>
>> This is my version:
>>
>> commit be8ccd4a39708cef6e67e4e00432d0207e596a76
>> Author: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> Date:   Wed Feb 23 01:38:09 2011 +0100
>>
>>     forward port, rebase on 3.0-noarch, adeos-ipipe-3.0.13-arm-1.18-05
>>
>>
>> on top of it I have my board patches and this commit for an error of the timer precision
>>
>> commit fff6198ec1033e55d42cc24914b6b958365d7495
>> Author: Mehnert, Torsten <T.Mehnert@domain.hid>
>> Date:   Mon Aug 1 08:02:07 2011 +0000
>>
>>     i.MX25 GPT clock fix: ensure correct the clock source
>>     
>>     Request for comment and commit.
>>     
>>     From: T. Mehnert <t.mehnert@domain.hid>
>>     Date: Mon, 4 Jul 2011 15:53:30 +0200
>>     Subject: [PATCH] i.MX25 GPT clock fix: ensure correct the clock source
>>     
>>     This patch ensures, that Linux will take the correct clock source (AHB_DIV)
>>     for gpt in the ARM i.MX25 implementation. The currect code depends on the re
>>     defaults of the CCM_MCR register. So on some boards it could happen that the
>>     UPLL is used for clock source, which results in faulty time behavior in Linu
>>     In this case all delays or sleeps will will be faktor 1.8 too long.
>>     
>>     Signed-off-by: Torsten Mehnert <t.mehnert@domain.hid>
>>     Signed-off-by: Sascha Hauer <s.hauer@domain.hid>
>>
>>
>> On 04/19/2012 12:55 PM, Gilles Chanteperdrix wrote:
>>> On 04/19/2012 12:02 PM, Michael Trimarchi wrote:
>>>> Hi,
>>>>
>>>> I will send a proper patch. Is it possible to include in the ipipe-arm branch?
>>>>
>>>> Michael
>>>
>>> Yes, OK. Please resend the patch to the xenomai-core, or adeos-main
>>> mailing list, I see ipipe-arm is broken since at least 2.6.33. It
>>> compiles but probably does not work.
>>>
>>
>> I'm still debugging my imx25 board, and I have problem with the timer. If I execute
>> clocktest for xenomai after some while I have:
>>
>>
>> now at 2897236425903 nsecs
>>
>> cpu: 0
>>  clock 0:
>>   .base:       c04f26a8
>>   .index:      0
>>   .resolution: 1 nsecs
>>   .get_time:   ktime_get
>>   .offset:     0 nsecs
>> active timers:
>>  #0: <c04f2c00>, tick_sched_timer, S:01
>>  # expires at 2889380000000-2889380000000 nsecs [in -7856425903 to -7856425903 nsecs]
>>  #1: <c3aa1f38>, hrtimer_wakeup, S:01
>>  # expires at 2889470961229-2889471011229 nsecs [in -7765464674 to -7765414674 nsecs]
>>  #2: <c3a97f38>, hrtimer_wakeup, S:01
>>  # expires at 2889508847229-2889508897229 nsecs [in -7727578674 to -7727528674 nsecs]
>>  #3: <c0510648>, sched_rt_period_timer, S:01
>>  # expires at 2890000000000-2890000000000 nsecs [in -7236425903 to -7236425903 nsecs]
>>  #4: <c04f2d68>, watchdog_timer_fn, S:01
>>  # expires at 2892070000002-2892070000002 nsecs [in -5166425901 to -5166425901 nsecs]
>>
>>
>> And I don't have any tick from the i.Mx timer until they wrap again to be positive.
>> Can you suggest some way to debug? Do you know what it can happen?
> 
> If you have CONFIG_MXC_IRQ_PRIO enabled, disable it, this option is
> incompatible with xenomai.
> 

It's already disable. 

# CONFIG_MACH_EUKREA_CPUIMX25 is not set
# CONFIG_MXC_IRQ_PRIOR is not set
CONFIG_MXC_AVIC=y
CONFIG_MXC_PWM=y


During clock test it stuck for a while and then start again 

# /usr/bin/clocktest 
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0             662480.6           -0.033          0            0.0

Michael

