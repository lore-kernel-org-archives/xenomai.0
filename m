Message-ID: <53388F8A.6030403@xenomai.org>
Date: Sun, 30 Mar 2014 23:41:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5338834B.5090604@steinkuehler.net>
In-Reply-To: <5338834B.5090604@steinkuehler.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Dedicated Core?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/30/2014 10:49 PM, Charles Steinkuehler wrote:
> Is it possible to (easily) dedicate a CPU core to a single Xenomai
> user-space thread?
> 
> Background:
> I am running software based step/direction generation logic for motion
> control as part of LinuxCNC.  On the x86 platform, latency numbers are
> very good, and it's possible to run fast enough as a Xenomai user-space
> thread.
> 
> ARM systems have significantly worse latency numbers, but on the
> BeagleBone I have migrated the step/direction code to the PRU on-board
> co-processors so everything works fine (actually better than on most x86
> systems).
> 
> But most available ARM CPUs do not have the PRU co-processors found on
> the BeagleBone.  However, there are a number of systems that have
> multiple cores, and I'm particularly looking at the quad-core iMX6 parts.

First, the imx6 is reported to have high latencies, and it is mostly due
to cache effects, so isolating the cpus will not help.

Second, I would say relying on low user-space latencies to do in
user-space things that the kernel should do is a bad design. You would
have better success implementing the step motor control low level
details as a kernel driver, and only move the high level stuff in
user-space.

> 
> If it would be possible to simply keep a thread running full-time on one
> core, I could get really good step/direction performance without having
> to worry about interrupt latency, but I don't know if there's an (easy)
> way to do this using Xenomai, or if the 'dedicated' core would still be
> subject to hardware interrupts and if my running thread might be
> occasionally migrated to other physical cores.
> 

The latency you get in user-spâce are not interrupt latency, but
user-space scheduling latencies, which are significantly higher. See the
difference between latency -t 0 and latency -t 2 on your plaforms. If
you want to only depend on interrupt latencies, you should implement a
driver, and get user-space to interact with the driver.

As you may have already read on this list, Xenomai never migrates task
automatically, and you can change the task affinity to define on which
core it should run. That said, you probably want the processor to remain
interrupt triggered, and the real-time task to suspend from time to time
to let linux do its duty (like handling Linux domain timer interrupts).


-- 
                                                                Gilles.

