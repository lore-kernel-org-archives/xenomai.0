Message-ID: <4DC3C575.9000902@domain.hid>
Date: Fri, 06 May 2011 11:55:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DC2962B.9060802@domain.hid> <4DC299F2.40700@domain.hid>
	<4DC2A315.8030707@domain.hid> <4DC2ADE1.9000301@domain.hid>
	<4DC2B06B.9020303@domain.hid> <4DC2B75C.8030503@domain.hid>
	<4DC2C10C.9080102@domain.hid> <4DC2C411.60109@domain.hid>
	<4DC2D0C9.3020605@domain.hid> <4DC2DDC6.8090909@domain.hid>
	<4DC3BF3C.2030405@domain.hid>
In-Reply-To: <4DC3BF3C.2030405@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] mini2440: ipipe kernel stuck in idle loop after
 xenomai init
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

On 05/06/2011 11:28 AM, Alexey Galakhov wrote:
> On 05/05/2011 11:26 PM, Gilles Chanteperdrix wrote:
>> Please try and move the cal to ipipe_tsc_update to the acktimer function.
>> Also call printk in the actkimer function, in order to see if the last
>> action is a set_dec, or an acktimer.
> Just tried to add printk (not moved anything). Got:

Just explaining what happens.

> 
> ipipe_mach_set_dec: 4294967295
> ipipe_mach_set_dec: 4294967295

These are for the setup calibration (rthal_calibrate_timer).

> ipipe_mach_set_dec: 42186

This is the call to __ipipe_mach_release_timer, at the end of
calibration, which should put the timer back under Linux control, in
auto-reload mode.

> Xenomai: scheduling class idle registered.
> Xenomai: scheduling class rt registered.
> acktimer
> acktimer
> acktimer
> acktimer
> acktimer

Linux ticks, set_dec is not called, because the timer auto-reloads.

> Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
> ipipe_mach_set_dec: 42187

Here the timer goes under Xenomai control, ipipe_mach_timerstolen is set
to 1.

> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> acktimer

First timer interrupt, should trig a call to Xenomai tick timer handler,
which should reprogram the next timer. At this time, there is only one
timer in Xenomai's list: the host timer, so, we should see an
set_dec(42186) again.

The problem probably comes from the fact that you are running with
CONFIG_GENERIC_CLOCKEVENTS, I will try and reproduce this on different
hardware.

-- 
					    Gilles.

