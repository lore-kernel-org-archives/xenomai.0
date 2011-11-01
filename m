Message-ID: <4EB029B9.4070608@domain.hid>
Date: Tue, 01 Nov 2011 18:17:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <loom.20111028T160712-174@domain.hid>
	<4EAABB40.5050107@domain.hid> <4EAAD83D.3020503@domain.hid>
	<4EAAFA3C.2080902@domain.hid> <4EAEEB5B.7040907@domain.hid>
In-Reply-To: <4EAEEB5B.7040907@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] twl4030-irq takes 50%cpu constantly on omap3
 gumstix overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: manfred@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

On 10/31/2011 07:39 PM, Manfred Quack wrote:
> I am sorry to bother again ...
> 
> So I managed to compile with 1.16 patch and manually patching in these 
> changes:
> http://git.denx.de/?p=ipipe-2.6.git;a=commitdiff;h=6e5856f8b5383ea25970cbd076956c00b7ee4400 
> 
> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=153abc5f8a5d86ffab64469206f709191c64d901
> 
> I ran a latency test for ~1h, and generating load by downloading a 700MB 
> .iso over the wireless onto an SD card.
> I first got quite good results, (~60us worst case) but at the end of the 
> test (after ~1h) it suddenly jumped to 5000us (so 5ms).
> Looking at dmesg i got an error message about spurious interrupts:
> 
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 86
> 
> These messages also appear sometimes in the precompiled images (kernel 
> 2.6.39) from the gumstix page. But because the spurious interrupts seem 
> not to create any problems except for the large latency in the 
> latency-tests, I guess it should be possible for the scheduler to reject 
> these spurious interrupts (and provide stable worst-case latency-counts).
> 
> So my question is: Do you know something about these issues, and have 
> they been treated for any of the kernel versions in any i-pipe patch?

This error has nothing to do with the I-pipe kernel, we had many of
these some time ago, but I have not seen one in years. So, the problem
is probably in the patched kernel you use, not in the mainline kernel.
Fortunately, once you found the culprit, it is easy to fix, some
hardware register is written in an interrupt handler which should be
read back right after that, and is not.

But before trying and finding the culprit, you should make sure that the
latency you observe is due to this error. Re-run the same test you ran
on an USB key instead of an SD card for instance. If you do not observe
the high latency re-run the test on the SD card, but run the latency
test on the serial port, to make sure that the kernel message appears at
the time when you get the high latency.

> Which combination of kernel and I-Pipe and xenomai version would you 
> expect to be the most stable/reliable on an omap3530?

The I-pipe patch is validated with mainline kernels by essentially
running the latency head, and generating load with the "dohell" script,
now installed by xenomai. All released patches have been validated.

-- 
                                                                Gilles.

