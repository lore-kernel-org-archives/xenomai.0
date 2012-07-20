Message-ID: <5009A7DA.3010101@xenomai.org>
Date: Fri, 20 Jul 2012 20:47:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfdsiPqa_eV8fbMM9oZmNmwdvOpRs+eSXE1LPLCy0eg+Q@mail.gmail.com>
In-Reply-To: <CAKKWdtfdsiPqa_eV8fbMM9oZmNmwdvOpRs+eSXE1LPLCy0eg+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: rescheduling a blocked task
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

On 07/17/2012 11:26 AM, ali hagigat wrote:
> If a real time task is blocked for some real time object, does Xenomai
> guarantee the (re-)scheduling latency to be lower than a specific
> number?

As we already answered, I believe, Xenomai does not guarantee anything,
it just provides you with the tools to measure an empiric estimate of
the worst case scheduling latency. And the worst case scheduling latency
only make sense when the woken up task is the highest priority runnable
task, otherwise your task may be delayed for some time by higher
priority tasks.

> Does the task enter the Linux domain when it is blocked?

No, of course not.

> or when it is blocked it may be in the blocked state for arbitrary time lengths?

That just depends on what the unblocking does.

What about what I proposed you? Installing xenomai for real and asking
real questions about real issues you get when porting real applications?
Instead of asking questions in the void which you will find stupid when
you have got your feet wet with xenomai?

-- 
                                                                Gilles.

