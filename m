Message-ID: <53C7AB52.609@xenomai.org>
Date: Thu, 17 Jul 2014 12:54:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140704092736.GC13487@lukather> <53B7B3BF.3090807@xenomai.org>
 <20140707160239.GF13423@lukather> <53BAC5C4.5060704@xenomai.org>
 <20140708125505.GN13423@lukather> <53BC2AB5.4050801@xenomai.org>
 <20140710150540.GE27469@lukather> <53BEC794.6090208@xenomai.org>
 <20140716161801.GA20328@lukather> <53C6D6DA.3060303@xenomai.org>
 <20140717101807.GC20328@lukather>
In-Reply-To: <20140717101807.GC20328@lukather>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] AT91: SAMA5D3: Adapt Ipipe for AIC5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Thomas Petazzoni <thomas@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/17/2014 12:18 PM, Maxime Ripard wrote:
> On Wed, Jul 16, 2014 at 09:47:38PM +0200, Gilles Chanteperdrix
> wrote:
>>>>> I don't think latency fits both these criterias, that are 
>>>>> quite essential for us. But if you have any better
>>>>> solution that might, we're definitely open to suggestions
>>>>> :)
>>>> 
>>>> Xenomai forge's latency is based on timerfd, so will be
>>>> usable on Linux, preempt-rt and xenomai. But that is for the
>>>> future.
>>> 
>>> Ah, good to know.
>>> 
>>>> I suggest you fix the issue with negative latencies, and see
>>>> if it avoids the large latencies you observe.
>>> 
>>> So, I tested it today with the latency calibration disabled.
>>> 
>>> It doesn't change anything. I slightly modified it to dump the 
>>> time1 and time2 variables to see if we're observing negative 
>>> latencies.
>>> 
>>> The code is here: http://code.bulix.org/y7f8tc-86530?raw And
>>> here is the output of a single run: 
>>> http://code.bulix.org/ciamlo-86531?raw
>>> 
>>> So, if you look at it, we can see that we have around half a
>>> dozen of these huge latency spikes, while we gather 180k
>>> samples, but these spikes are not actually caused by some
>>> negative latencies. There actually is such a different of a few
>>> 100's of ms between our two timespec structures.
>>> 
>>> And it's not due to an error reported by any of the clock 
>>> functions either.
>> 
>> Ok, you do not call pthread_setschedparam to make the task run
>> with the SCHED_FIFO policy, do you set the policy by running the
>> program with chrt? Because starting with Xenomai 2.6.0, threads
>> with the SCHED_OTHER policy automatically return to secondary
>> mode after a primary mode syscall, so your task is essentially a
>> plain linux task. If you do run the program with chrt, I suggest
>> checking in /proc/xenomai/stat or /proc/xenomai/sched that the
>> task runs with the intended priority.
> 
> /me hides...
> 
> Yes, it was just that stupid mistake... Erm. I guess I owe you a
> drink if we ever meet :)
> 
> And now, I indeed get some negative latency values.
> 
> Which brings an extra question about this. Is the timer
> calibration supposed to get a minimum latency to 0 (meaning that
> with a properly calibrated timer, we would only get positive
> latencies), or that the average latency should be around 0 (which
> would mean that negative latencies would actually be frequent, but
> would break the clock_nanosleep documented behaviour).
> 
> I'm actually seeing the former, but trying the latter only brings
> us quite close to having the calibration disabled entirely.

The calibration is left entirely to the user, so, you choose what is
best for your application. But indeed, if your application relies on
clock_nanosleep documented behaviour (should never wake-up early
except in case of signal), you want to set /proc/xenomai/latency value
to the minimum value measured by the latency test, minus a safety margin.

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTx6tSGpcgE6m/fboRAr2DAJ47ysURGA5T27Sq4FrNpFfs59sySQCeMfTR
8XCWDd+NWn5d6VKP+Nh4t/A=
=sYTn
-----END PGP SIGNATURE-----

