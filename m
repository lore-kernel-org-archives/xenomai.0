Message-ID: <54E222D2.4010201@siemens.com>
Date: Mon, 16 Feb 2015 18:03:14 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
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

On 2015-02-16 17:18, Hays, Arthur (NIH/NEI) [E] wrote:
> Our application for laboratory automation and experimental control (for neurophysiology labs) runs on QNX on commodity x86 motherboards (when we can find ones that don't have the SMM issue).  We do this because our users are on tight grant money at universities.
> 
> With QNX we measure typical 4usec and worst case maximum 6usec latency from #INTA asserted on the PCI bus to entry of a service routine in user space.  This is when disk i/o, display updating, network activity all present.
> 
> We also execute another routine scheduled by a timer every 1msec that may involve updating the display and network communication to other machines.  The jitter for this routine is not crucial.
> 
> QNX has discontinued self-hosting on x86- they are embedded only now.  Photon/PhAB is no longer supported.  So we are looking to port to another environment that is self-hosted on x86 perhaps using Qt instead of Photon.
> 
> From what I've read on Xenomai the typical latency to entry of a routine in user space initiated by a hardware IRQ would stay the same as with QNX, but the maximum would be on the order of 20-40usec on x86?

Depends on your hardware, SMP vs. UP, the RT workload (how hot caches
are kept) etc. In general, SMP first of all increases latencies (also on
classic RTOSes) but you may benefit from it by isolating RT and non-RT
workloads on separate cores. From the numbers, I suspect you are on UP
so far.

Give it a try on your box, first via standard benchmarks (low effort),
then mimicking your workload by starting to port essential parts over.

BTW, if you extension card is MSI/MSI-X capable, better use that path
instead of legacy INTx - saves quite a few cycles and reduces contention
points, both in hardware and software.

> 
> Would the routine that is scheduled every 1msec be able to update displays and use TCP/IP?

Sure, that's a standard Linux task, maybe run with Linux real-time prio
and CONFIG_PREEMPT to boost it a bit over the rest as needed.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

