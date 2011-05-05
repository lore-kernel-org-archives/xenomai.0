Message-ID: <4DC2C10C.9080102@domain.hid>
Date: Thu, 05 May 2011 21:23:56 +0600
From: Alexey Galakhov <agalakhov@domain.hid>
MIME-Version: 1.0
References: <4DC2962B.9060802@domain.hid> <4DC299F2.40700@domain.hid>
	<4DC2A315.8030707@domain.hid> <4DC2ADE1.9000301@domain.hid>
	<4DC2B06B.9020303@domain.hid> <4DC2B75C.8030503@domain.hid>
In-Reply-To: <4DC2B75C.8030503@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

On 05/05/2011 08:42 PM, Gilles Chanteperdrix wrote:
> On 05/05/2011 04:12 PM, Alexey Galakhov wrote:
>> On 05/05/2011 08:02 PM, Gilles Chanteperdrix wrote:
>>> On 05/05/2011 03:16 PM, Alexey Galakhov wrote:
>>>> May it be caused by the following code from plat-samsung/time.c ?
>>>>
>>>> static inline void set_dec(unsigned long reload)
>>>> {
>>>>         __raw_writel(reload, S3C2410_TCNTB(4)); /* <-------- In fact,
>>>> TCNT is 16-bit, so what if reload > 0xffff and reload & 0xffff == 0 ??? */
>>> Try adding:
>>>
>>> if (reload > 0xffff)
>>> 	reload = 0xffff;
>>>
>>> before the raw_writel
>> No effect. It may make sense but does not fix this bug.
> It may also happen that the timer has a lower limit, when the reload
> parameter is below this limit, you shoud call ipipe_trigger_irq, as
> explained in the porting guide.
Seems to be not the case but tried it anyway (guessed lower limit
0x00ff), no effect. Also tried to add printk to __ipipe_mach_set_dec,
got the following:

I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
ipipe_mach_set_dec: 42187
ipipe_mach_set_dec: 4294967295
- - (repeats many times) - -
ipipe_mach_set_dec: 4294967295
ipipe_mach_set_dec: 42186
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
ipipe_mach_set_dec: 42187
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
msgmni has been set to 119
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered (default)
- - (hangs) - -

--
Alex

