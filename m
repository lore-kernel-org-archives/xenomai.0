MIME-Version: 1.0
From: Byron Jacquot <bjacquot@cardinalpeak.com>
Date: Thu, 15 Jul 2021 17:34:37 -0600
Message-ID: <CAJte2PC6cFhYMqY9-XGbrkmiw+U5_hQW0S03iCjDWuLKtDW8OA@mail.gmail.com>
Subject: Taking first steps with EVL
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Everyone,

I'm evaluating some of the newer options for doing real-time audio
processing.  I've been playing with the Xenomai-based ElkOS - some online
discussion led me to EVL.

I'm working with a Rasbperry Pi 4B - I started with a Raspbian Lite card,
and have been building EVL kernels from the v5.12-evl-rebase branch.

I've got a grasp on the basics - I cloned & built the kernel, then ran `evl
test`, discovered missing configuration parameters, added them, and now the
tests all pass.  I've poked at Hectic and Latmus, too.

I also noticed a boot-time message about pipeline capable Pi4 IRQ chips,
and found the following discussion of a patch to fix it, so added that and
eliminated the message.
https://evlproject.org/pipermail/evl/2021-February/000300.html

I'm pulling the basics of application and driver development together
also.  I'm getting to know EVL thread spawning, diagnosing inappropriate
system calls, etc.  I've got a stub of a character device driver with the
OOB calls attached, and my application successfully attached and using
those calls, partitioning the RT and non-RT access.  Much of this was
informed by looking at both sides  (user/driver) of Hectic and Latmus.  So
far, so good!

Now I'm looking to get audio in & out of the system - it looks like there
are two possible paths I could follow, and wanted to see if anyone here
might be able to offer steering and guidance.

The first path would be to port the RTDM driver from ElkOS - unwind the
RTDM parts, and replace them with EVL ones.  I'm reasonably familiar with
that driver.  Is my understanding correct, that the heart of it is really
setting up the DMA IRQ with the OOB flag, and the OOB DMA is functional on
the bcm2835/Pi4?

The other path would be the ALSA patches described below, plus porting work
based on it for the BCM2711 I2S port & my converters.  My application
doesn't need ALSA, but if it's a useful stepping stone, it's not precluded,
either.
https://xenomai.org/pipermail/xenomai/2020-September/043502.html

Does one of these seem like a shorter path to proof of concept than the
other?

Thank you,

Byron Jacquot
