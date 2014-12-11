Date: Thu, 11 Dec 2014 11:47:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141211104713.GC21808@hermes.click-hack.org>
References: <8119909587ec45d1ba5696722a1b0945@EX132MBOX1A.de2.local>
 <20141210190114.GQ1524@hermes.click-hack.org>
 <6f637a6b60964c49bbc08e3204c8eae3@EX132MBOX1A.de2.local>
 <20141211100520.GA21808@hermes.click-hack.org>
 <88cb5162a0ca44fb8251aa8161a8d8d8@EX132MBOX1A.de2.local>
 <20141211102249.GB21808@hermes.click-hack.org>
 <14309ee2cb7e45c9a01e6e1504c5bed5@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14309ee2cb7e45c9a01e6e1504c5bed5@EX132MBOX1A.de2.local>
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

On Thu, Dec 11, 2014 at 10:29:58AM +0000, Stoidner, Christoph wrote:
> >> >> RT drivers are also not installed on our system.
> >> >
> >> > Maybe I look wrong at nucleus/shadow.c, but I see only two reasons
> >> > for for xnshadow_relax being called for a secondary mode syscall:
> >> >
> >> > - a call requiring primary mode was made and the switchback flag is
> >> > set (which itself can have two reasons, either the fact that the
> >> > syscall uses it, the only one being currently rt_timer_set_mode, or
> >> > the fact that the caller runs with the SCHED_OTHER policy and does
> >> > not hold a mutex)
> >> >
> >> > - a call with the adaptive flag was made, handled in primary mode,
> >> > but returned -ENOSYS, which means the call needs to be retried in
> >> > secondary mode.
> >> >
> >>
> >> You are right. We have implemented some syscalls the require primary mode (since they could block) but should switch back to secondary. These syscalls are using attributes
> >>
> >>     __xn_exec_primary | __xn_exec_switchback
> >
> > Well then the tasks blocked with a stack trace like what you showed
> > are blocked when coming back from such syscalls. Does this happen
> > often, or are these syscall seldom used?
> 
> In this application the switchback syscalls are used rather often. 

Two things to note:

- mode switches do not go without some overhead, it is almost never
a good idea to force the switchback, since the nucleus will switch
the target thread to secondary mode when needed anyway, all that you
risk is to introduce useless mode switches, so, if you do it, you
must have a good reason for it;

- there is a risk of overflowing the nucleus queue for relax
requests, you will see a message in the kernel logs when this
happens if you enable debugging of the nucleus
(CONFIG_XENO_OPT_DEBUG_NUCLEUS).



-- 
					    Gilles.

