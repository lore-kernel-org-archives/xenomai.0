Message-ID: <4D4D6F32.4070302@domain.hid>
Date: Sat, 05 Feb 2011 16:39:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=pm4BfNAwCzw-6HLOiKfJQmgMQdPmVXTcCBSBs@domain.hid>	<4D49CF24.9080700@domain.hid>	<AANLkTinaTVSJW1jQzn7+jbsQgNE+HAEOXLEK3LC0MoWR@mail.gmail.com>	<4D49D608.5020006@domain.hid>	<AANLkTinU4b-SY6Vy7=Ss+Nxrp-+qEZ6qsTudBsmrjbh_@domain.hid>	<4D4A80F6.5020600@domain.hid>	<4D4A8354.7010209@domain.hid>	<AANLkTim3M6fPN5u6AjNn5xdwbOM9AmzB+yG2w37o1A3J@mail.gmail.com>	<4D4C7F10.3020703@domain.hid>
	<AANLkTi=QiGXpMwdY3tEz=Qo0tO8Q5fe1xnPpo+dX3eEP@mail.gmail.com>
In-Reply-To: <AANLkTi=QiGXpMwdY3tEz=Qo0tO8Q5fe1xnPpo+dX3eEP@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] I-pipe clock source change and MMC issues (AT91)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai@xenomai.org

at91_enthus wrote:
>>> Rookie mistake. Indeed, I can have everything in userspace using Xenomai.
>> I

Or in kernel-space... with Xenomai RTDM skin.

>>> wrote a simple program that did a periodic job every 100 us and the
>> jitter
>>> was very small (around 20 us without load and around 35 us with SSH-ing
>> and
>>> Xenomai compilation running on board).

Well, as we often say, benchmarking requires making more than that to
load the board, and for a long time.

>>>
>>> Somewhat unrelated to this thread, I found that when I invoked
>>> rt_task_set_periodic(), I got very precise timings (as expected).
>> However,
>>> when I tried to insert small delays using rt_timer_spin(), the errors
>>> (t_meas - t_spin_func_argument) were not large, but noticeable. For
>> example,
>>> I can precisely measure a 50 us periodic task on the scope. With the same
>>> interval in rt_timer_spin(), I get 55-60 us. As far as I understood, all
>>> timing-related functions use the same time base, so what's the reason for
>>> this behavior?
>>

Well, rt_task_set_periodic gets the hardware timer to tick exactly every
50us. So, whatever time it takes between the return of the call to
rt_task_wait_period() to the entry of the next is irrelevant. And
particularily, the jitter will not matter as long as it is smaller than 50u.

On the other hand, doing:

for(;;) {
	/* Do something */
	rt_timer_spin(50000);
}

The period of the loop will be 50us + rt_timer_spin jitter + time to "do
something". And so, will not even be constant.
You are not creating a periodic task. Besides, the system will not
execute anything else in user-space than your real-time task, and in
particular, the Linux will never run. Except of course if "do something"
contains a call to some secondary domain function, in which case, your
real-time task no longer is real-time.

So, that is not the correct way to get a periodic task.

-- 
                                                                Gilles.

