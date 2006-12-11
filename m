Message-ID: <457D609F.8030301@domain.hid>
Date: Mon, 11 Dec 2006 14:43:59 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1165537720.4578b1b879da9@domain.hid>
	<45795320.5060806@domain.hid>
	<1165595720.45799448b0adc@domain.hid>
	<4579CD41.6060102@domain.hid>
	<1165665886.457aa65e2c26e@domain.hid>
	<457AAEB9.20403@domain.hid>
	<1165834501.457d390514d36@domain.hid>
	<457D57B4.3000802@domain.hid>
	<1165843368.457d5ba8692bd@domain.hid>
In-Reply-To: <1165843368.457d5ba8692bd@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: [Adeos-main] [PATCH] ppc mvme5500
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
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main@gna.org

Hi Antonio,

I re-added the ADEOS and Xenomai mailing lists to CC because others 
might be able to help better.

barbalace@domain.hid wrote:
>> Thanks for testing. And please read the complete thread at
>> http://ozlabs.org/pipermail/linuxppc-embedded/2006-December/thread.html#25455
>> containing some more infos.
> 
>  Ok, so when you deciding the right way for the patch let me know it.

I will use the patch with the spin*_hw functions.

>>> I've another question from you: I'm doing a data acquisition loop with my
>>> hardware; I register an interrupt handler and on it (or on a task waiting
>> on a
>>> sem/mutex) read the data over a VME bus. Result over some tests are:
>>> linux interrupt handling (with ipipe and Xenomai loaded) : 75,763uS
>>> xenomai interrupt handling (obiouvsly with ...): 75,489uS
>> In user- or kernel-space? Under what load? And what processor, clock,
>> memory, cache, etc. are you using?
> 
>  Tests are in kernel-space, there is only network load: pings, ICMP, DHCP, NFS
> server: not very loaded. The processor is a MPC7455@domain.hid, 512MB RAM, L2 and L3
> cache enabled (maybe, I'm not sure at 100%)... is a MVME5500 board!

Ah, this system is really fast. Then the 75 us are not really the 
interrupt latency but include some further latencies (reading the data, 
etc.), am I right?. And what does the latency test of the test suite report?

> Testing with the native skin I notice (Xenomai2.2.0) that mutex doesn't behave
> like I think:
> 1. create a mutex
> 2. lock the mutex (infinite)
> 3. start a RT task
> 4. lock the mutex in the RT task (infinite)
> 5. register an interrupt
> 
> 6a. ...wait...
> 6. reach an interrupt and unlock the mutex
> 6b. ...then...
> 
> 7. start 2-times the code after the previous rt_mutex_lock [this is not
> correct!!!]
> 8. goto 6a.
> 
> the rt_mutex_lock is clearly in a for loop.
> Probably I'm in truble. Using a semaphore resolve my problems.
> When using mutex I lose the machine control.

I don't have a quick answer but maybe somebody else can help.

>> It's a long time ago that I have done something for RTAI and I'm not
>> up-to-date with recent RTAI implementations. Please ask this question on
>> the RTAI mailing list.
> 
> Ok, so I must ask to them.
> 
> Thanks a lot,
> Antonio

Wolfgang.

