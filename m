Message-ID: <4DB9CF05.2030205@domain.hid>
Date: Thu, 28 Apr 2011 22:33:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>
	<4DB83CBE.5040007@domain.hid>	<4DB94BA0.1020503@domain.hid>
	<4DB94C9C.7080904@domain.hid>
In-Reply-To: <4DB94C9C.7080904@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after
	switching	clocksource
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

Gilles Chanteperdrix wrote:
> Alexey Galakhov wrote:
>> On 04/27/2011 09:56 PM, Gilles Chanteperdrix wrote:
>>> But I think your problem has more to do with the following commit, could
>>> you try reverting it?
>>> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=6ab29d9c7a4b119f45ef4d93780e894fe1c0c6c6;hp=cd9c5e016092258d4450e137be2d0844d0fe8b38
>>>
>>> The same issue was reported on ixp4xx.
>> Just tried to revert this patch. Hangs. But now in a different way: it
>> starts to initialize peripherals and stops on LED initialization. Looks
>> like race conditions since it stops in slightly different place each
>> time I try to boot (randomly at led3, led4 or "backlight" LED). Last
>> lines of dmesg are, i.e.:
>>
>> [    3.090000] samsung-ts s3c2440-ts: driver attached, registering input
>> device
>> [    3.100000] input: S3C24XX TouchScreen as /devices/virtual/input/input0
>> [    3.120000] S3C24XX RTC, (c) 2004,2006 Simtec Electronics
>> [    3.120000] s3c-rtc s3c2410-rtc: rtc disabled, re-enabling
>> [    3.135000] s3c-rtc s3c2410-rtc: rtc core: registered s3c as rtc0
>> [    3.135000] i2c /dev entries driver
>> [    3.155000] S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics
>> [    3.160000] s3c2410-wdt s3c2410-wdt: watchdog inactive, reset
>> disabled, irq enabled
>> [    3.180000] s3c-sdi s3c2440-sdi: powered down.
>> [    3.180000] s3c-sdi s3c2440-sdi: mmc0 - using pio, sw SDIO IRQ
>> [    3.185000] s3c-sdi s3c2440-sdi: running at 0kHz (requested: 0kHz).
>> [    3.200000] Registered led device: led1
>> [    3.205000] Registered led device: led2
>> [    3.210000] s3c-sdi s3c2440-sdi: running at 398kHz (requested: 400kHz).
>> [    3.215000] Registered led device: led3
>> [    3.220000] Registered led device: led4
>> (hangs)
>>
>> Going to try kgdb over serial line.
> 
> Ok. Better try without this patch first, then try reapplying the patch
> when you are certain that everything else works correctly. The patch
> enables some assembly code that was never actually tested. On my side, I
> will try and test it separately.
> 

With the following patch, the asm code looks fine to me:

diff --git a/arch/arm/kernel/ipipe_tsc_asm.S
b/arch/arm/kernel/ipipe_tsc_asm.S
index ca88882..d3c833f 100644
--- a/arch/arm/kernel/ipipe_tsc_asm.S
+++ b/arch/arm/kernel/ipipe_tsc_asm.S
@@ -143,7 +143,7 @@ __ipipe_decrementer_16:
 	ldr	ip, [r0]
 	ldr	r2, .LCdec16_last_cnt
 	subs 	ip, r2, ip
-	addcs	ip, ip, #0x10000
+	addcc	ip, ip, #0x10000
 	myldrd	r2, r3, r3, .LCdec16_last_tsc
 	cmp	r1, r2
 	bne	1b
@@ -155,7 +155,7 @@ __ipipe_decrementer_16:
 	ldr	ip, [r0]
 	ldr	r2, .LCdec16_last_cnt
 	subs 	ip, r2, ip
-	addcs	ip, ip, #0x10000
+	addcc	ip, ip, #0x10000
 	myldrd	r2, r3, r3, .LCdec16_last_tsc
 	cmp	r1, r3
 	bne	1b



-- 
                                                                Gilles.

