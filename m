Date: Thu, 9 Oct 2014 04:36:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141009023600.GE30368@sisyphus.hd.free.fr>
References: <D059B455.193D3%shartmann@cnt.canon.com>
 <20141007203650.GC1685@sisyphus.hd.free.fr>
 <20141007204510.GD1685@sisyphus.hd.free.fr>
 <D05AE639.193F6%shartmann@cnt.canon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D05AE639.193F6%shartmann@cnt.canon.com>
Subject: Re: [Xenomai] SIGXCPU on pthread_mutex_unlock()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Hartmann <shartmann@cnt.canon.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Oct 08, 2014 at 06:48:00PM +0000, Steve Hartmann wrote:
>
>
> On 10/7/14 3:45 PM, "Gilles Chanteperdrix"
> <gilles.chanteperdrix@xenomai.org> wrote:
>
> >On Tue, Oct 07, 2014 at 10:36:50PM +0200, Gilles Chanteperdrix wrote:
> >> On Tue, Oct 07, 2014 at 08:16:39PM +0000, Steve Hartmann wrote:
> >> > Hi folks,
> >> >
> >> > I'm having an issue I hope someone here might be able to shed some
> >>light on.
> >> >
> >> > I am running Xenomai 2.6.4 on linux 3.4.6.  The application has a
> >>very large source base which was not originally designed for xenomai.
> >>I am using xenomai because of some new requirements and the addition of
> >>EtherLabs Ethercat master.
> >> > So in one of the original threads, which is running at PRI 0,  I have
> >>two mutexes which when unlocked throw a SIGXCPU signal.  These mutexes
> >>are only locked/unlocked in this same thread.  I have seen this happen
> >>when a mutex which is not locked has an unlock attempt.  This is not the
> >>case for this issue.
> >> >
> >> > What could I be doing which would cause a pthread_mutex_unlock to
> >>throw the SIGXCPU signal?  Any suggestions for troubleshooting
> >>techniques?
> >>
> >> When you receive the SIGXCPU signal, you should check the reason as
> >> demonstrated in the examples/native/sigdebug.c program.
> >
> >Or see:
> >http://xenomai.org/2014/06/finding-spurious-relaxes/
> >
>
> Thanks for the hints.  I probably would have found it myself had I been
> searching for SIGDEBUG instead of SIGXCPU.
>
> Anyway, the reason I am getting a SIGDEBUG_RESCNT_IMBALANCE.  I did a
> search and saw there were some changes between 2.6.2.1 and 2.6.4 regarding
> the rescnt imbalance.  I just so happen to have two machines running this
> same code - one on 2.6.2.1 and one on 2.6.4.  Only the one on 2.6.4
> machine is throwing this signal.  Either the xenomai change introduced a
> new bug, or the change in xenomai has exposed a bug in our code.

Indeed.

>  I have reviewed our code and it seems to be correct.  I even
> threw in an extra pthread_mutex_trylock (for troubleshooting) just
> before the pthread_mutex_unlock and checked the return code just
> to make sure that it is locked.  There are no instances where the
> extra trylock() actually succeeded, which made me more confident
> that our code is correct.  The mutex is not recursive.

The imbalance is not in the mutex lock count, it is an imbalance in
a reference counter Xenomai maintains for tasks running with the
SCHED_OTHER scheduling policy when then lock and unlock
mutexes. Now, as you said, this imbalance means that either we have
a bug in Xenomai, or the application does something which does not
work with Xenomai, because this reference counter has some
shortcomings. One of them being that it does not work correctly if
you change scheduling policy (from SCHED_OTHER to SCHED_FIFO or
SCHED_RR or the other way around) while holding a mutex.

A way to know for sure is to reduce your test case to a simple
self-contained test case that we can run to reproduce the issue.

Regards.

--
					    Gilles.

