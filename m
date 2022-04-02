MIME-Version: 1.0
References: <20220402142127.944138-1-rpm@xenomai.org>
In-Reply-To: <20220402142127.944138-1-rpm@xenomai.org>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 2 Apr 2022 21:18:41 +0200
Message-ID: <CAFLxGvx7v5PyoxW0SaFaNLh6eO9i0k0Wo7nu+1Tjz1QU5LzbcQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched: dovetail: pass thread-info bits to
 arch_dovetail_switch_finish()
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
Cc: Xenomai <xenomai@xenomai.org>

On Sat, Apr 2, 2022 at 4:23 PM Philippe Gerum via Xenomai
<xenomai@xenomai.org> wrote:

> -       arch_dovetail_switch_finish(leave_inband);
> +       ti_work = READ_ONCE(current_thread_info()->flags);
> +       arch_dovetail_switch_finish(leave_inband, ti_work);

Why are you passing ti_work as parameter? AFAIU you can
use current_thread_info()->flags directly in arch_dovetail_switch_finish().

-- 
Thanks,
//richard

