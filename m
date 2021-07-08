MIME-Version: 1.0
References: <CAFLxGvy9BSEiRwzJximQLEqn_n=OfgaQcvKpxWSSRYPeeGn-yA@mail.gmail.com>
 <2c2f612c-5a56-0bb7-735c-4d3c4fe13aaa@siemens.com>
 <CAFLxGvzDE0NpXGjxEyGhnjC__3oEq4iSkcDJzFPWB68S6wF2dA@mail.gmail.com>
 <aa766270-994e-2cc4-1e37-52b3dc55e132@siemens.com>
 <878s2hi0b9.fsf@xenomai.org>
 <fdb021ad-034e-8fd5-7c0f-44a153c7a55c@siemens.com>
 <874kd5hsu6.fsf@xenomai.org>
In-Reply-To: <874kd5hsu6.fsf@xenomai.org>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 9 Jul 2021 00:05:52 +0200
Message-ID: <CAFLxGvxaU8YeOrgMfGqfguvBpexiJcO6t12_bXd3Ot9f5a-eoA@mail.gmail.com>
Subject: Re: rt_task_shadow() secondary mode
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Thu, Jul 8, 2021 at 2:51 PM Philippe Gerum <rpm@xenomai.org> wrote:
> > Then it needs to be understood what technically triggers this and
> > resolved, likely via an explicit migration.
> >
>
> Sure, good exercise for the reader to get ones feet wet with libalchemy.
> If somebody wants to tackle this: check callers of
> threadobj_run_corespec() in libcopperplate.
>
> The common case in this routine is to force a switch back to primary
> mode for the caller, on exit from threadobj_shadow(). We may want to
> make this conditional to the scheduling policy and priority. Following
> threadobj_init() for the content of idata may help too.

Hmm.
I see cobalt_thread_harden() being called long before threadobj_init().
cobalt_thread_trampoline() calls it too.
Same for pthread_setschedparam_ex() if the task in question is main().

-- 
Thanks,
//richard

