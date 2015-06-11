Message-ID: <8f7e2c2ccbb9edd9f8c491ee09d2e096.squirrel@sourcetrek.com>
In-Reply-To: <79A9E4882C44D44FA53B5AB15E6198011385D400@ADEERL01SMS001.cznet.zeiss.org>
References: <79A9E4882C44D44FA53B5AB15E6198011385C369@ADEERL01SMS001.cznet.zeiss.org>
 <b692bb78ab6f887dfd41f71655a0a205.squirrel@sourcetrek.com>
 <44y4jq71ku.fsf@be-well.ilk.org>
 <650830a42485b39f0a0443dcb4c5c962.squirrel@sourcetrek.com>
 <79A9E4882C44D44FA53B5AB15E6198011385D400@ADEERL01SMS001.cznet.zeiss.org>
Date: Thu, 11 Jun 2015 19:35:11 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] init failed code -19 on Cyclone V SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Lopes, Alexandre" <alexandre.lopes.ext@zeiss.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Lopes, Alexandre wrote:
> @Lowell: Like Gilles mentioned, there are several timers in the
> Cortex A9. At address PERIPH_BASE_ADDR + 0x200 you have the global timer
> registers and at PERIPH_BASE_ADDR + 0x600 you have the private timer and
> watchdog timer registers (on a per core basis). On the Altera socfpga
> systems
> the base address is, in this case, 0xfffec000. Unfortunately Altera
> didn’t
> register the global timer, at least not on the upstream Kernels.

The Linux mainline code refuses to start the global timer with old
revisions of the cortex A9 core which global timer is not exactly the same
as with newer revisions (there is a difference in what condition triggers
the timer interrupt which make it possible for the old revisions timer to
not receive an interrupt if the programmed delay is too short, whereas it
can not happen with newer versions). So, the SOCs in mainline based on
such old versions do not even bother to declare the global timer registers
in the DT.

The I-pipe clock source does not care about the timer, it only needs the
free running counter, and actually has been using it long before the arm
global timer driver was merged. This free running counter works fine in
both cases (and has an unparalleled resolution and latency, which makes it
interesting for emulating a tsc), so, I have patched up the global timer
code to keep the clocksource even with old revisions and only skip the
clockevent device registration, so that we can add the global timer
register declarations in DT and have the clocksource without the timer.
But this is a hack, really, it means that we have to add the DT data in
the I-pipe patch, and this is going to byte us when mainline decides to
restructure the global timer support.

The proper fix is to submit a patch to mainline that agrees both parties,
namely implement a different clockevent callback for the old revisions
that test for short delays and return -ETIME to let the clockevent system
handle it. Then submit the DT data to make the ARM global timer available
for the SOCs we need, and move all this out of the I-pipe patch.


-- 
                    Gilles.


