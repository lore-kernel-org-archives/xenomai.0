Message-ID: <5338A730.6010601@xenomai.org>
Date: Mon, 31 Mar 2014 01:22:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5338834B.5090604@steinkuehler.net> <53388F8A.6030403@xenomai.org>
 <533894D3.8090803@steinkuehler.net>
In-Reply-To: <533894D3.8090803@steinkuehler.net>
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

On 03/31/2014 12:04 AM, Charles Steinkuehler wrote:
> On 3/30/2014 4:41 PM, Gilles Chanteperdrix wrote:
>> 
>> First, the imx6 is reported to have high latencies, and it is
>> mostly due to cache effects, so isolating the cpus will not
>> help.
>> 
>> Second, I would say relying on low user-space latencies to do in 
>> user-space things that the kernel should do is a bad design. You
>> would have better success implementing the step motor control low
>> level details as a kernel driver, and only move the high level
>> stuff in user-space.
> 
> I am not looking to migrate something that should be a kernel
> service, instead I'm trying to replace having dedicated hardware.

This is better done in kernel-space than in user-space. At least, you
should give a try to a kernel driver before you decide to resort to
what you want to do.

Besides, notably the L2 cache issues on imx6, make it impossible for
the activity on one core to not influence the activity on other cores.

> 
>>> If it would be possible to simply keep a thread running
>>> full-time on one core, I could get really good step/direction
>>> performance without having to worry about interrupt latency,
>>> but I don't know if there's an (easy) way to do this using
>>> Xenomai, or if the 'dedicated' core would still be subject to
>>> hardware interrupts and if my running thread might be 
>>> occasionally migrated to other physical cores.
>> 
>> The latency you get in user-spâce are not interrupt latency, but 
>> user-space scheduling latencies, which are significantly higher.
>> See the difference between latency -t 0 and latency -t 2 on your
>> plaforms. If you want to only depend on interrupt latencies, you
>> should implement a driver, and get user-space to interact with
>> the driver.
>> 
>> As you may have already read on this list, Xenomai never migrates
>> task automatically, and you can change the task affinity to
>> define on which core it should run. That said, you probably want
>> the processor to remain interrupt triggered, and the real-time
>> task to suspend from time to time to let linux do its duty (like
>> handling Linux domain timer interrupts).
> 
> We already have hooks to set processor affinity.  What I am
> interested in is if I dedicate an entire core to running a tight
> code loop, can I avoid Xenomai and/or Linux "pulling the core out
> from under me" as a result of various hardware interrupts or
> general task scheduling?
> 
> I can live with the code not running for the duration of the
> Xenomai interrupt handler (that's happening now anyway), I just
> want to know if it is (easy) to keep Xenomai and Linux from
> grabbing the core running my tight loop after the interrupt event.
> It's similar to having one core running "bare metal" code, but I
> actually need Linux and Xenomai to manage setting up the shared
> memory regions used for IPC prior to launching my code.
> 

As I said, the answer is no, Linux needs to answer to some events on
all the cores that are not turned off, and Xenomai can not run on a
turned off core.



-- 
                                                                Gilles.

