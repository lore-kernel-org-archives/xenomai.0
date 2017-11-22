References: <023601d363ac$6ce04c40$46a0e4c0$@sepro-group.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d2a2bcaf-7cfb-78f9-55cb-b1cca9b4a0be@xenomai.org>
Date: Wed, 22 Nov 2017 17:46:24 +0100
MIME-Version: 1.0
In-Reply-To: <023601d363ac$6ce04c40$46a0e4c0$@sepro-group.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Strange scheduling behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Perles?= <cperles@sepro-group.com>, xenomai@xenomai.org

On 11/22/2017 05:10 PM, Cédric Perles wrote:
> Hi,
> 
> I’m working on an iMX6 based board with NXP kernel 4.1.15.

Vendor kernels for i.MX6 are creepy (another vowel comes to mind). A
recent mainline kernel is just fine if the SoC supports it. If not,
porting the SoC (and/or missing driver) to mainline is often much better
and faster than enduring a truckload of bugs.

> I would like to understand why latency max returned by cyclictest
> increases from 20µs to 100µs when dohell accesses to USB.
> 
> Since i-pipe tracer refuses to work,

Which means?

 I used ftrace to record cobalt,
> scheduling and irq events. Here is what I see on kernelshark:
> 
> As expected, cyclictest has 1 xenomai thread per core (I can see them on
> /proc/xenomai/sched/threads) that wakes up periodically after a 200µs
> nanosleep.
> 
> Sometimes, the wake up seems to be delayed (400µs instead of 200µs)
> because of an USB irq treatment followed by a call to usb-storage.
> Other times, the wake up seems to be delayed (400µs instead of 200µs) by a
> Linux call to ktimersoft, rcu and cat (see
> https://drive.google.com/file/d/18-B3WO2QH7PvBzJrt9tK5-TXvAkDxTPn/view?usp
> =sharing)
> 

The textual trace shows no issue. 40us are spent suspending a Cobalt
thread, which seems reasonable on i.MX6Q with ftrace enabled and the
slow PL310 L2 outer cache you have there. I likely missed your point then.

> Is it normal to delay a xenomai task wake up because of a Linux interrupt
> (I expected ipipe to act as a shield) ?
> How a simple Linux "cat" can delay a xenomai wake up ?
> 

For instance, if the Xenomai task in question dropped to secondary mode
earlier because the app is wrong somehow, then some work queue kernel
thread starts running funky driver code issuing usleep() to sync with
the hw. The rt thread running in non-rt mode will have to wait until the
driver stops busy-waiting for a bit to toggle, causing the next rt
operation for that task to appear as badly delayed. The point is, that
Xenomai is not in charge when the delay appears.

This case has been observed several times with MMC host and PCI host
drivers on fsl kernels; I would not be surprised if that happened with
other vendor-specific driver(s) too.

-- 
Philippe.

