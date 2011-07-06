Message-ID: <4E144591.6010906@domain.hid>
Date: Wed, 06 Jul 2011 13:22:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkDLimRNcf1xwnJoMCx=Q3a87Pp9=_bsuN5DizKoGs7Xzg@domain.hid>
In-Reply-To: <CAOiXNkDLimRNcf1xwnJoMCx=Q3a87Pp9=_bsuN5DizKoGs7Xzg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Communication between RT and non-RT thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrey Nechypurenko <andreynech@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 07/06/2011 11:25 AM, Andrey Nechypurenko wrote:
> Hi Folks,
> 
> In my application I have Xenomai thread which collects and process
> sensor data. In addition, I have non-RT thread which sends sensor data
> over the network for visualization (with much lower time resolution,
> picking let's say every 100th sample). Xenomai thread is the only one
> which access sensors so there is a need to pass some samples to the
> non-RT communication thread. Basically, It is a typical
> producer/consumer situation which could be solved with thread-safe
> queue. Obviously, introducing such queue with standard synchronization
> mechanisms such as mutexes, etc. is not an option since it will
> influence the RT thread which will be forced to wait for non-RT
> thread.

You can use mutexes with priority inheritance to avoid this issue. But 
Xenomai has ready made queues for rt/non-rt communication, the rtipcs:

http://www.xenomai.org/documentation/xenomai-head/html/api/group__rtipc.html



> While searching for the solution, I came to conclusion that lock-free
> [1] queue implementation is the way to go. Searching for such
> implementation which is also mature enough for real-life applications
> and works on ARM, the only one I found was boost_lockfree [2] . It is
> a great library, but it depends on boost, which in turns by default
> pulls Python and a lot of other things which are not necessary
> required on the embedded system (I am using BeagleBoard with Anstrom
> Linux distribution).
> 
> I think, the situation I have (RT supplier/non-RT consumer) is quite
> typical and I hope there should be a typical good solution for it.

A lockless solution for this (one consumer, one producer) is the good 
old fifo.

-- 
                                                                Gilles.

