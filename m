Message-ID: <4411580C.4090501@domain.hid>
Date: Fri, 10 Mar 2006 11:42:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-core] Fundamental Questions
References: <20060308171327.17712.qmail@domain.hid>
In-Reply-To: <20060308171327.17712.qmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: chris@domain.hid
Cc: xenomai@xenomai.org

Christopher Stone wrote:
> In light of the desire for support below, would the Xenomai team 
> consider listing companies capable of commercial support on their 
> website, or create another mailing list for us to announce commercial 
> offerings around Xenomai. I am prepared to contribute to Xenomai in 
> order to receive this privilege.  
>  
> Sorry for discussing commercial issues on your mailing list. If it makes 
> it any better, we are a very small company, just trying to make a 
> living, not a big corporate conglomerate.
>  

We are about to start such listing on xenomai.org. Requests for inclusion should
be sent to Bruno who manages the website. He will likely ask for the graphical
elements needed to add the link (i.e. a logo of the proper size), and a short 
description of the services being advertised.

> As a final point, I believe Xenomai is very well positioned to become 
> very popular and "future proof". I believe the next frontier for Linux 
> is industrial grade Linux, or Linux on the factory floor and Xenomai 
> will end up the technology of choice to make that happen. Contrary to 
> many opinions I have heard, I beleve the rt-preempt work done by Ingo 
> Molnar will enhance Xenomai and not replace it.

My comments about this issue will likely be much longer than needed, but it's an
opportunity I'm going to take in order to clarify a few things, as an attempt to
explain why Xeno is Xeno, and which evolution process has led to the current
implementation.

Xenomai attempts to address four basic use cases:

- situations where revalidating the entire Linux stack, with the proper level of
confidence with respect to reliability and worst-case latency, regardless of the 
set of drivers or sub-systems one might use in a setup during the project 
lifetime, is not an option. A Xenomai-based application relying on the primary 
mode for getting determinism won't be impacted by some hidden piece of Linux 
kernel code which happens not to conform with the new locking semantics preempt_rt 
enforces. This advantage will last at least until all vanilla kernel code, and all 
vendor-supplied drivers one might want to use in her design, have been made 
conformant to such requirements. Of course, one could argue that "rogue" drivers 
could also mask off interrupts at hw level and thus impact Xenomai too, but the 
main difference there is about how complex it is to locate and fix the culprit in 
a short time, without adverse side-effects on the rest of the system. Debugging 
and fixing a tiny RTOS core is easier than chasing priority inversions in a 
full-blown GPOS kernel trying to cope with real-time issues.

- situations where real-time application duties tend to become more complex as the 
hardware improves, i.e. when applications need to cope at the same time with a 
broad spectrum of real-time constraints and non real-time duties, ranging from 
fast data acquisition to deterministic networking, and/or FFT crunching, while 
still being able to get a decent throughput for moving large amount of data over 
various storage/network devices without adverse effect on latencies.

- situations where the hardware the application needs to run on is fairly
limited. In such a case, a safe approach is to handle the most time-critical tasks
over a context which does not depend on the reserve of CPU power Linux has at hand
to complete its current unpreemptable duties, before turning its head to the
critical stuff. On the other hand, dealing with real-time principles at the core
level of a GPOS for all kernel activities - including those who have no real-time
constraints - is expensive in terms of CPU horsepower, and engineering complexity.

- situations where legacy code exists, that used to run over a non-POSIX API,
and/or over a non-Linux real-time environment.

So far, I've seen the following approaches implemented for addressing some of 
those issues:

1) pretending that anything that doesn't fall into the low microsecond-range
real-time constraint has no real-time constraint, enforcing a complete isolation
between the real-time core and Linux, so one has the only option to ask Linux its
"best effort" for dealing with "trivial" (i.e. "non ultra-low latency real-time")
duties. This just does not scale with the increasing complexity of applications,
and has the additional downside to lower the incentive to keep the regular Linux
programming model available to the real-time developer (i.e. "who cares for
user-space, GDB and/or Valgrind since we are only interested in coding data
acquisition loops!". This one is also known as the REMBO syndrom, as in "REal Men
only Bring an Oscilloscope").

2) pretending that burying the real-time principles deep enough inside the vanilla
Linux core will solve all problems for all real-time configurations, with high 
performances and stability, for every use, on every platform. Frankly, I have no 
clue whether the preempt_rt effort will eventually succeed or fail, the way it is 
currently advertised, that is (i.e. high reliability with ultra-low worst-case 
latencies, in the range of what the co-kernels/co-schedulers can do right now, 
regardless of the hardware in question).

This said, I have no doubt that this effort will succeed (and possibly get merged
eventually) to provide reliable real-time support for strictly defined
configurations. It's also obvious that it already brought some positive updates to
the vanilla kernel, by uncovering synchronization bugs and latency spots, because 
common issues are shared between SMP and real-time architectures. However, 
something looks like almost certain: making an RTOS from a GPOS like Linux will 
always carry the additional cost of dealing with the new set of real-time 
semantics and constraints when designing new drivers or sub-systems.
This raises the following question in turn: how and by whom, these pieces of 
software - which would need to be "real-time blessed" so that they don't break the 
whole kernel determinism - are going to be contributed?

The technical barrier on entry for contributing to a 15-years old kernel is
already fairly high, which de facto reduces the number of potential contributors;
not all patch reviewers on the LKML are interested in real-time issues, some
sub-system maintainers already expressed their reluctance to consider those issues
as fundamental Linux ones, and the cursor between throughput/fairness and
responsiveness might not always be set to favour the latter. Add to this the
requirement that each piece of contributed software does not mess up with the
real-time semantics imposed by preempt_rt (e.g. new locking scheme), and you will
get to a potential issue: either the barrier on entry for pushing code to the
kernel is kept as it is, and only a limited portion of the drivers making their
way to the vanilla kernel would be real-time conformant, hence making the task of
validating a configuration initially picked from kernel.org for an industrial
use, a nightmare. Or, raise the barrier so that real-time requirements are always
encompassed, but dry up the common contribution path doing so, then resort to only 
asking real-time Linux vendors for getting "certified" new kernels, drivers or 
updates (which those vendors might not consider as a downside though...).

3) providing foreign API emulation layers based on simple POSIX remapping in 
regular user-space, which don't fully conform to the actual dynamic behaviour of 
the original RTOS, when they ever provide real-time support at all. Those are 
often advertised as tools for making first order ports to Linux, before eventually 
going for the "big jump" to the native Linux API, which de facto implies that 
changing the API the application is written over, would represent any desirable 
value in the end. But, it may happen that switching APIs from e.g. VxWorks's WIND 
kernel to POSIX would be a deliberate waste of time and resources, depending on 
maintenance considerations, albeit moving to Linux still has a value. Legacy code 
has by essence sedimentation issues, with various engineers having made lots of 
assumptions over time, regarding the way the underlying API behaves. Therefore, 
switching APIs is not such a trivial operation, especially for large industrial 
applications which have been in the field for several years.

The way Xenomai has evolved since 2001 attempts to capture the essentials of the
above matters:

- first a generic real-time core has been devised, in order to exploit the 
numerous commonalities existing in the vast majority of traditional RTOSes. 
Properly emulating foreign APIs from traditional RTOSes could then be done 
efficiently and reliably, using simple building blocks, without reinventing the 
wheel API after API. One bug fixed in the core strengthens all APIs relying on it. 
This core includes a scheduling and synchronization system which is manageable in 
size and complexity, and immune to any Linux locking and preemptability issues, so 
it's cheaper to validate, and easier to fix without incurring collateral damages 
on other sub-systems. This is likely the only but important gift of the entire 
co-kernel legacy.

- step two was Adeos for replacing the old and unfortunately patented interrupt
interception mechanism, so that we could build over an arch-independent interface,
which in turn would deal with all the nitty-gritty details regarding interrupt and
event prioritization within the Linux kernel. The abstraction brought by Adeos 
also explains why Xenomai can be fairly easily ported to other architectures.

- then came the user-space support, with the fundamental choice of cooperating
with Linux on the domain boundaries (Xenomai / Linux). Cooperating with it,
seeking integration, neither fighting it nor seeking isolation unless absolutely 
required for keeping a high degree of determinism. For instance, properly dealing 
with Linux signals - at the core and API levels - is instrumental in enabling GDB 
for all real-time applications. Uniformizing the priority scales between the core 
Xenomai APIs and Linux by using the common SCHED_FIFO scale allows real-time 
threads to migrate between both domains, without losing the priority information. 
Keeping a common priority scheme between both domains makes the applications see 
an unified execution space for real-time threads, providing a gradual scale of 
real-time guarantees by means of migration between domains. Generally speaking, 
cooperating with Linux means that, each progress vanilla Linux makes toward 
deterministic response time, is immediately available to Xenomai-based 
applications would they need to rely on the secondary mode for accessing the rich 
set of services Linux provides. As soon as preempt_rt provides the same level of 
performances, stability and maintainability than Xeno, the time will have come to 
rebase the scheduler innards of the Xenomai nucleus over native POSIX services, 
for configurations that support preempt_rt, and solely focus on Xenomai's core 
value there: i.e. API abstraction.

- step four has been the integration and deep coupling with RTDM for supporting 
real-time device drivers in Xenomai-based systems. Aside of providing a 
well-thought framework, RTDM has the major advantage of normalizing the 
interactions between the application, the real-time core and the Linux kernel when 
dealing with hardware devices, around the use of a POSIXish interface in 
user-space. In other words, it prevents most changes occurring in the real-time 
core, and between this core and Linux, to impact both application and device 
driver sides.

To sum up, I definitely agree that preempt_rt and Xenomai could be a
perfect match when it comes to providing a broad spectrum of real-time services
with different levels of determinism on a single system with enough CPU power and
efficient hardware. And the integration between both will be pursued by the 
Xenomai project. But for the time being, we still need the Xenomai nucleus to 
guarantee ultra-low scheduling latencies for low maintenance costs, and Adeos to 
guarantee ultra-low interrupt latencies, at the very least.

This said, a lot of steps remain to be reached in order for Xenomai to take its 
part in building a complete, free as in free speech, industrial-grade environment 
for building real-time systems, regardless of the preempt_rt situation.

Aside of this, I might be awfully wrong since the very beginning too, which in 
such a case, and to refer to a precedent post on this list, would be the sign that 
time has come for me to consider growing flowers as a better occupation than IT. :o>

> I also think the break 
> from RTAI was very smart as it has given you the flexibility to move 
> Xenomai in the direction it needs to go.
> The recent releases have made 
> Xenomai ready for the commercial world. So, kudos to the Xenomai team. 
> You guys are proving to be great leaders with the right technology at 
> the right time.
>  
> Cheers,
>     Chris Stone.
> 

-- 

Philippe (the unsuspected gardener).

