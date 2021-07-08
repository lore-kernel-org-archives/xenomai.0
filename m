MIME-Version: 1.0
References: <CAFLxGvy9BSEiRwzJximQLEqn_n=OfgaQcvKpxWSSRYPeeGn-yA@mail.gmail.com>
 <2c2f612c-5a56-0bb7-735c-4d3c4fe13aaa@siemens.com>
 <CAFLxGvzDE0NpXGjxEyGhnjC__3oEq4iSkcDJzFPWB68S6wF2dA@mail.gmail.com>
 <aa766270-994e-2cc4-1e37-52b3dc55e132@siemens.com>
 <878s2hi0b9.fsf@xenomai.org>
 <fdb021ad-034e-8fd5-7c0f-44a153c7a55c@siemens.com>
 <874kd5hsu6.fsf@xenomai.org>
 <CAFLxGvxaU8YeOrgMfGqfguvBpexiJcO6t12_bXd3Ot9f5a-eoA@mail.gmail.com>
In-Reply-To: <CAFLxGvxaU8YeOrgMfGqfguvBpexiJcO6t12_bXd3Ot9f5a-eoA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 9 Jul 2021 00:14:30 +0200
Message-ID: <CAFLxGvyagPjboSCZS5kksNFAOrbjxutDS+kc4y_xhprZ6dGaZA@mail.gmail.com>
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

On Fri, Jul 9, 2021 at 12:05 AM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> Hmm.
> I see cobalt_thread_harden() being called long before threadobj_init().
> cobalt_thread_trampoline() calls it too.
> Same for pthread_setschedparam_ex() if the task in question is main().

Correction: It is always pthread_setschedparam_ex().
I forgot that I had pthread_create wrapping enabled in one test...

-- 
Thanks,
//richard

