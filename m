Date: Wed, 22 Oct 2014 07:17:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141022051722.GB29673@sisyphus.hd.free.fr>
References: <D06C2B92.195DA%shartmann@cnt.canon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D06C2B92.195DA%shartmann@cnt.canon.com>
Subject: Re: [Xenomai] /proc/xenomai/sched
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

On Tue, Oct 21, 2014 at 08:29:26PM +0000, Steve Hartmann wrote:
> 
> 
> On 10/21/14 3:11 PM, "Steve Hartmann" <shartmann@cnt.canon.com> wrote:
> 
> >Can someone please point me in the direction of a writeup of how to
> >interpret /proc/xenomai/sched?  I have searched around, but cannot find
> >what I am looking for.  Specifically, I want to know what it means when I
> >see a "D" in the "STAT" column, and what the number in the "TIMEOUT"
> >column means.
> >
> >I did find one post that said the "D" means "Delayed (without any other
> >wait condition).". Maybe I'm just dense, but I'm not positive on what
> >that means.  I think it might mean that the task should be running, but
> >it is delayed because it could not be scheduled because of some reason
> >perhaps another higher priority task is bumping it?  Or am I way off base?
> >
> >Also, in xenomai 2.4.7, the TIMEOUT column is expressed in a number with
> >no units; what is the unit?

Probably nanoseconds. Would need to check the sources to see that.

> 
> 
> So one other observation Š the tasks which seem to very often show a "D"
> status, are periodic tasks.  Perhaps this is just a state where it is
> simply waiting on nothing other than time to pass before it gets scheduled
> to run?

"Delayed" means that the task voluntarily suspended and waiting for a timer
to wake it up. And yes, rt_task_wait_period/pthread_wait_period_np
do that, as do rt_task_sleep/nanosleep.

-- 
					    Gilles.

