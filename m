Message-ID: <4FEED882.9070307@xenomai.org>
Date: Sat, 30 Jun 2012 12:44:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdte1Yg5fEUN=jqVgyTkRTHwY62WrMdw99ZgqOZZdAnAm+w@mail.gmail.com>
In-Reply-To: <CAKKWdte1Yg5fEUN=jqVgyTkRTHwY62WrMdw99ZgqOZZdAnAm+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: XENO_OPT_TIMING_SCHEDLAT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 06/30/2012 12:39 PM, ali hagigat wrote:
> Does this kernel config variable,  CONFIG_XENO_OPT_TIMING_SCHEDLAT,
> indicate the scheduling latency? If i specify 1 nano second, so all
> the real time tasks will be scheduled below 1 nano second?
> 
> It seems impossible!
> 
> If it is the time when a timer interrupt comes and preempts a real
> time task till that real time task is scheduled again ( is this the
> definition of the scheduling latency?). Again this definitions seems
> not OK because it can not be 1 nano second!! It is too fast to do any
> thing.
> 
> This configuration variable does not seem to have any range....

CONFIG_XENO_OPT_TIMING_SCHEDLAT is the value of /proc/xenomai/latency at
boot time.

/proc/xenomai/latency is an estimation of the minimum scheduling latency
on your system. In order to know what to put there you should do:

echo 0 > /proc/xenomai/latency

Run latency under load for several hour

echo minimum_latency > /proc/xenomai/latency

The value put there is then subtracted to timers deadline, so that
timers wake up a little bit early to compensate for the time it takes to
return to user-space.

-- 
                                                                Gilles.

