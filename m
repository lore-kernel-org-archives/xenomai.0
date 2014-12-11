Date: Thu, 11 Dec 2014 11:05:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141211100520.GA21808@hermes.click-hack.org>
References: <8119909587ec45d1ba5696722a1b0945@EX132MBOX1A.de2.local>
 <20141210190114.GQ1524@hermes.click-hack.org>
 <6f637a6b60964c49bbc08e3204c8eae3@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f637a6b60964c49bbc08e3204c8eae3@EX132MBOX1A.de2.local>
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Dec 11, 2014 at 10:00:16AM +0000, Stoidner, Christoph wrote:
> 
> >> > That is strange, are these tasks
> >> > running with the SCHED_OTHER policy ?
> >> No, they are running with sched fifo.
> >
> >Ok, next, are they using
> >rt_timer_mode_set
> >or
> >RT drivers which return -ENOSYS in their rt handlers ?
> 
> Assumedly you mean rt_timer_set_mode() instead of rt_timer_mode_set(). This function is not called since we are using our own skin. Also our own skin does not use xntbase_switch(). Maybe it is interesting to know that our skin is configured with periodic timing (1ms). 
> 
> RT drivers are also not installed on our system. 

Maybe I look wrong at nucleus/shadow.c, but I see only two reasons
for for xnshadow_relax being called for a secondary mode syscall: 

- a call requiring primary mode was made and the switchback flag is
set (which itself can have two reasons, either the fact that the
syscall uses it, the only one being currently rt_timer_set_mode, or
the fact that the caller runs with the SCHED_OTHER policy and does
not hold a mutex)

- a call with the adaptive flag was made, handled in primary mode,
but returned -ENOSYS, which means the call needs to be retried in
secondary mode.

-- 
					    Gilles.

