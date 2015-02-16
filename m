Message-ID: <54E227F5.7070700@xenomai.org>
Date: Mon, 16 Feb 2015 18:25:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <7E7E1F635323E543B04E7D69A4E262E7159C6AC4@msgb08.nih.gov>
In-Reply-To: <7E7E1F635323E543B04E7D69A4E262E7159C6AC4@msgb08.nih.gov>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting from QNX?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Hays, Arthur (NIH/NEI) [E]" <art@lsr.nei.nih.gov>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/16/2015 05:18 PM, Hays, Arthur (NIH/NEI) [E] wrote:
> Our application for laboratory automation and experimental control (for neurophysiology labs) runs on QNX on commodity x86 motherboards (when we can find ones that don't have the SMM issue).  We do this because our users are on tight grant money at universities.
> 
> With QNX we measure typical 4usec and worst case maximum 6usec latency from #INTA asserted on the PCI bus to entry of a service routine in user space.  This is when disk i/o, display updating, network activity all present.
> 
> We also execute another routine scheduled by a timer every 1msec that may involve updating the display and network communication to other machines.  The jitter for this routine is not crucial.
> 
> QNX has discontinued self-hosting on x86- they are embedded only now.  Photon/PhAB is no longer supported.  So we are looking to port to another environment that is self-hosted on x86 perhaps using Qt instead of Photon.
> 
>>From what I've read on Xenomai the typical latency to entry of a routine in user space initiated by a hardware IRQ would stay the same as with QNX, but the maximum would be on the order of 20-40usec on x86?

This range looks reasonable for a common atom-based dual core (64bit
mode), hammered with lots of disk i/o and VM activity. This is also
matching the results for an oldish 1.6Ghz centrino-based board, fitted
with a PIIX controller. Worst-case latencies below 15 us have been
observed on some high-end hardware, YMMV.

To sum up, it's really difficult if not impossible for me to discuss
typical worst-case latencies on x86, several issues may have a
significant influence there, which depend on the hardware.

This said, leaving aside the obnoxious SMI/SMM issue and the usual
recommendations about bus mastering, power management and so on, the
following observations also hold true:

- the more CPU cores, the more latency due to internal contention on
real-time resources. However, this only affects cores actually running
real-time load with Xenomai, e.g. a 64-way machine with Xenomai
configured to use only two of the CPU cores for handling real-time
duties should not experience more (rt) contention than a dual core
system fully dedicated to real-time.

- if the real-time load is implemented as a periodically-triggered work
loop, the longest the period, the highest the latency. Hot caches are
helping us when the regular linux activities are not allowed to trash
them for too long between two real-time events to process. Typically,
you should observe "latency -p 100" giving better results than "latency
-p 1000" with Xenomai.

- graphic acceleration does not always play well with worst-case latency
requirements. Whether the graphic card, with and without acceleration,
involves [un]acceptable latency would be among the first things I would
check.

> 
> Would the routine that is scheduled every 1msec be able to update displays and use TCP/IP?
> 

Yes, definitely not an issue. Provided the GPU _and_ its driver plays nice.

> Any advice would be appreciated.
> 
> Thanks,
> 
> Art Hays
> National Institutes of Health
> National Eye Institute
> Bethesda, MD  20892
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

