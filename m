References: <CAJte2PC6cFhYMqY9-XGbrkmiw+U5_hQW0S03iCjDWuLKtDW8OA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Taking first steps with EVL
In-reply-to: <CAJte2PC6cFhYMqY9-XGbrkmiw+U5_hQW0S03iCjDWuLKtDW8OA@mail.gmail.com>
Date: Fri, 16 Jul 2021 09:56:50 +0200
Message-ID: <87o8b27ku5.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Byron Jacquot <bjacquot@cardinalpeak.com>
Cc: xenomai@xenomai.org


Byron Jacquot via Xenomai <xenomai@xenomai.org> writes:

> Hello Everyone,
>
> I'm evaluating some of the newer options for doing real-time audio
> processing.  I've been playing with the Xenomai-based ElkOS - some online
> discussion led me to EVL.
>
> I'm working with a Rasbperry Pi 4B - I started with a Raspbian Lite card,
> and have been building EVL kernels from the v5.12-evl-rebase branch.
>
> I've got a grasp on the basics - I cloned & built the kernel, then ran `evl
> test`, discovered missing configuration parameters, added them, and now the
> tests all pass.  I've poked at Hectic and Latmus, too.
>
> I also noticed a boot-time message about pipeline capable Pi4 IRQ chips,
> and found the following discussion of a patch to fix it, so added that and
> eliminated the message.
> https://evlproject.org/pipermail/evl/2021-February/000300.html
>

Mmh, it looks like this patch which is present in v5.10.y-dovetail fell
through the cracks when rebasing on top of v5.11. I just merged it back
to the Dovetail tip at v5.13. Thanks for the hint.

> I'm pulling the basics of application and driver development together
> also.  I'm getting to know EVL thread spawning, diagnosing inappropriate
> system calls, etc.  I've got a stub of a character device driver with the
> OOB calls attached, and my application successfully attached and using
> those calls, partitioning the RT and non-RT access.  Much of this was
> informed by looking at both sides  (user/driver) of Hectic and Latmus.  So
> far, so good!
>
> Now I'm looking to get audio in & out of the system - it looks like there
> are two possible paths I could follow, and wanted to see if anyone here
> might be able to offer steering and guidance.
>
> The first path would be to port the RTDM driver from ElkOS - unwind the
> RTDM parts, and replace them with EVL ones.  I'm reasonably familiar with
> that driver.  Is my understanding correct, that the heart of it is really
> setting up the DMA IRQ with the OOB flag, and the OOB DMA is functional on
> the bcm2835/Pi4?
>

Correct. I've been using this DMA backend in out-of-band mode to run the
oob-spi tidbit (libevl/tidbits), illustrating how to run low jitter
transfers over SPI with EVL on the RPI series (zero/2b/3b/4b) [1].

> The other path would be the ALSA patches described below, plus porting work
> based on it for the BCM2711 I2S port & my converters.  My application
> doesn't need ALSA, but if it's a useful stepping stone, it's not precluded,
> either.
> https://xenomai.org/pipermail/xenomai/2020-September/043502.html
>
> Does one of these seem like a shorter path to proof of concept than the
> other?
>

In a nutshell, option #1 (porting your driver from RTDM to the EVL
kernel API) might be the most straightforward route, since both APIs
share many semantics and your code is known to work already.

Option #2 would require to adapt the i2s and codec drivers backing the
PCM operations, like the couple of top commits at [2] do. You would also
need a user space interface to talk to the oob-capable Alsa stack.  For
this, either direct [oob_]ioctl() would do, or I could share some code
marginally extending tinyalsa [3] to enable pcm_readi()/pcm_writei() for
the oob audio path. That route would require to give more thought to the
problem (not necessarily more code though), but would make the full
range of Alsa features available to control your hardware
(e.g. configuration, muxing etc), in addition to having oob capabilities
as well.

If you application will never need Alsa features, and your existing
driver is doing the job today, then #1 may be a no-brainer. If you want
to benefit from the richness of the Alsa API in addition to
high-frequency, low jitter audio transfers at some point, then #2 is
better.

[1] https://evlproject.org/core/oob-drivers/spi/
[2] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commits/wip/audio/
[3] https://github.com/tinyalsa/tinyalsa

-- 
Philippe.

