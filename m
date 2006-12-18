Message-ID: <4586520E.7010601@domain.hid>
Date: Mon, 18 Dec 2006 09:32:14 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: RTAI porting to ppc
References: <20061122151901.29256.9846.Mailman@domain.hid>	<1166273496.4583ebd839182@domain.hid>	<45840394.6050004@domain.hid>	<1166286924.4584204ca04e9@domain.hid>	<4584347F.1020602@domain.hid>
	<1166294491.45843ddb59d3d@domain.hid>
In-Reply-To: <1166294491.45843ddb59d3d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: barbalace@domain.hid
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

barbalace@domain.hid wrote:
>> barbalace@domain.hid wrote:
>>> Quoting Jan Kiszka <jan.kiszka@domain.hid>:
>>>
>>>> I interpret this as "too slow for me", correct? Do you mind posting your
>>>> test scenario (board/CPU, ipipe/Xenomai/kernel versions, test program,
>>>> etc.) and your requirements to a related list? You will be welcome. Just
>>>> make sure that you test under adequate load, because anything else is of
>>>> limited use for a hard RT benchmark. See also xenomai/TROUBLESHOOTING.
>>> test scenario is MVME5500/MPC7455, ADEOS/ipipe ppc-1.3-05 Xenomai2.2
>>> kernel2.6.14, test program consist in a simple real-time interrupt handler
>> in
>>> kernel space registered with Xenomai/native skin. The interrupt is
>> generated
>>> from a VME board (with know response time) on an clock signal. The
>> interrupt
>>> handler simple write a VME location generating a square clock where the
>> level
>>> of the output change every interrupt.
>> OK.
>>
>> Why not Xenomai 2.2.5 with pipe-1.5? Moreover, current development head
>> is 2.6.18, soon .19 (Wolfgang is currently preparing the first PowerPC
>> tree ports). Just to avoid that some micros got optimised meanwhile.
> 
> The BSP for my board is for kernel 2.6.14 ;-) , I've patched with Wolfgang
> gt64260 pic code for ipipe, some ipipe patch >2.6.14 write on flash memory and
> the board must be send to Motorola. So I prefer to stay to 2.6.14 for the
> moment.
> 
>>> Is a very simple scenario. I only want to measure the interrupt dispatching
>> time
>>> to compare between Linux/Xenomai/RTAI/VxWorks. The jitter in scheduling and
>> in
>>> the interrupt dispatching I compare too. I know that under high load system
>>> lost  a deterministic beahavior.
>> A hard real-time system doesn't lose determinism, but it will surely
>> expose worse numbers. Still, even lightly unloaded boxes can show high
>> latencies - it just takes much longer to happen.
> Ok
> 
>>> I made some test with system load and unload.
>>> With a loaded system the same test in Linux-kernel on Linux/ipipe Xenomai
>>> mounted are very slowly compared to Xenomai registered ones.
>> And I have to understand what you mean. What are the two scenarios
>> precisely that you compare under load here?
>>
>>> I read the xenomai/TROUBLESHOOTING but latency killers are off in my
>> kernel. Now
>>
>> I was referring to TROUBLESHOOTING for appropriate load like the cache
>> calibrator. People often think that ping -f or similar tight loops are
>> already triggering the worst case.
> 
> A... under load for me is intended with data transfer on (ethernet transefers)
> or/and some data intesive calculation (matrix transpose with altivec and
> without).
> I use the same C code (with they API) for Linux, Xenomai and VxWorks. (For the
> moment I don't try VxWorks skin)
> 
> I've not think at the cache calibrator issue... This could be a very interesting
> thing.
> 
>>> the situation is: VxWorks 73uS, Linux pure 79uS and Xenomai 78uS, all
>> results
>>
>> Well, I heavily doubt that those 79 us over vanilla Linux remain stable
>> if you let your test run for an hour or longer and keep the system
>> loaded. Or are you testing with some -rt patch applied?
> 
> Test doesn't remain stable under load neither for one minute, you are right.
> I don't use rt patch.
> 
>>> all well. This test use a semaphore to start data acquisition on VME, the
>>> semaphore is signaled in the interrupt handler. This result are the same if
>> the
>>> system is loaded for VxWorks and Xenomai but not for Linux, it depends on
>> the
>>> load the acquisition could be 100uS or more.
>> IIRC, VxWorks is MMU-less. Did you configure Xenomai without user-space
>> support as well (.config would be interesting, also when posting to the
>> list)? Of course, this only makes sense of you plan to push everything
>> RT-wise into kernel, and this is not recommended (fault confinement,
>> debugging, legal issues, ...).
> 
> For the moment I'm only in kernel space, but I think to go user-space in
> january.
> Do you think MMU overhead is about a 1uS?

For user space RT applications an extra context switch and the syscall 
interface will introduce some additional overhead. As your system is 
very fast, 1us would also be my guess for the overhead.

> 
>>> Another detail: a read/write operation on the VME bus take between 1 and
>> 2uS. I
>>> need 32  read and one write. The IRQ chain 'round' take some time... I plan
>> to
>>> review VME/VITA specification jet to determin a possible required time.
>> Means that most of your ~80 us could be VME access?
> 
> Yes, this could be true. Some test tell me that a read (that required VME bus
> access and handshaking) require (1,5 - 2)uS; get_tlb() from the first read to
> the first write tell me values in the range [53 - 58]uS (more or less). With
> Linux. Some tests with VxWorks are not jet done. Interrupt acknowledge
> daisy-chain I think require a couple of uS.
> 
>>> With RTAI immediate dispatching I want to see if we can go below the
>> VxWorks
>>> required time.
>> Already tried the latency tracer with Xenomai? It can show you roughly
>> what latency some part of the IRQ path causes ("roughly", because the
>> tracer comes with an overhead and cache disturbances). I will also give
>> you a clue what RTAI may improve and what is hardware related (before
>> writing a single painful line of code). See, once again, irqbench on how
>> to trigger a back-trace on the longest delay.
>>
> A... Another interesting idea! I plan to try it.
> 
>>> Do you think I must change some settings? From my point of view results are
>> ok.
>>
>> I personally cannot comment on your PPC board, but on the general
>> picture: I once measured 10% better worst-case with RTAI on low-end x86
>> (user-space loop), so you /may/ get below current Xenomai numbers and
>> save a few micros. The cons are that you have to port, stabilise, and
>> maintain quite some code unless you plan this as a disposable
>> development. Something you should look at from both sides. Still,
>> design-wise sane optimisations are welcome at any time, and I also
>> pushed several patches of this kind into I-pipe and Xenomai over the
>> last year.

Antoni posted some figures on the Adeos-main ML (subject: [PATCH] ppc 
mvme5500). He has a _high-end_ MPC7455@domain.hid, 512MB RAM with L2 and L3
cache and reported latencies (-t0) without load of around 10 us. The 
interesting figure would be with system load, of course, but due to the 
L2 and L3 cache I think it would be quite close.

>>
>> Jan
> 
>>From this point I agree to you that I feel Xenomai community more open to ppc
> architecture then RTAI.
> 
> Thanks a lot,
> Antonio
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 
> 


