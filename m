Date: Mon, 23 May 2016 14:44:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160523124443.GC27631@hermes.click-hack.org>
References: <E1b4nHE-0003qK-1y@sd-51317.xenomai.org>
 <20160523120749.GB27631@hermes.click-hack.org>
 <5742F5F4.2020402@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5742F5F4.2020402@siemens.com>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Introduce
 __SCHED_CURRENT policy to setschedparam_ex
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Mon, May 23, 2016 at 02:22:12PM +0200, Jan Kiszka wrote:
> On 2016-05-23 14:07, Gilles Chanteperdrix wrote:
> > On Mon, May 23, 2016 at 12:40:00PM +0200, git repository hosting wrote:
> >> Module: xenomai-3
> >> Branch: next
> >> Commit: c821cbaa31c4a816615a82d7cbbd049987da6f1a
> >> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=c821cbaa31c4a816615a82d7cbbd049987da6f1a
> >>
> >> Author: Jan Kiszka <jan.kiszka@siemens.com>
> >> Date:   Tue Mar  8 14:41:28 2016 +0100
> >>
> >> cobalt/kernel: Introduce __SCHED_CURRENT policy to setschedparam_ex
> >>
> >> Define the internal scheduling policy "current": it shall refer to the
> >> target thread's current scheduling policy. This will allow to model
> >> pthread_setschedprio on top of pthread_setschedparam_ex with only a
> >> single syscall.
> > 
> > I am not sure I understand the use of __SCHED_CURRENT all that well.
> > Since different scheduling policies have different priority ranges,
> > a particular priority may only make sense for a couple of scheduling
> > policies. This, means, to use __SCHED_CURRENT, the programmer has to
> > know the scheduling policy of the current thread anyway. So, since
> > he knows it, why not specifying it clearly? This will make the
> > application code more readable, will not change anything with regard
> > to the number of calls, and avoid to have to change Xenomai core.
> 
> See "Wrap pthread_setschedprio for proper real-time support" for the use
> case. I'm open to address that one differently, via a separate syscall
> or whatever, if preferred. This one was just most simple.

Ok, my point shift to: de we need to support pthread_setschedprio()?
The programmer has to know the target thread scheduling policy to be
able to call that function sanely, so why not using
pthread_setschedparam instead, which has a "self documenting" effect
on indicating clearly which policy the target thread is using?

-- 
					    Gilles.
https://click-hack.org

