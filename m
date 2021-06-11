References: <f5a5c0eb-444d-2af3-b493-ec0c9b9ee428@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Moving inband work off stack - remaing cases
In-reply-to: <f5a5c0eb-444d-2af3-b493-ec0c9b9ee428@siemens.com>
Date: Fri, 11 Jun 2021 17:35:32 +0200
Message-ID: <875yykbeij.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> I'm trying to understand the reasoning for moving inband work struct for
> the remaining cases of the triggering stack.
>
> To my understanding, this is not needed for xnthread_map (to be
> privatized soon, so only for the in-tree case) because the caller
> providing the struct waits for the completion which will be triggered
> via the inband handler.
>

Correct.

> Looking at xnthread_relax(), the same should apply to post_wakeup -
> provided it is inlined into xnthread_relax - because, again, we won't
> leave that function before the signal was sent, thus the work consumed.
>

Correct.

> Am I missing something?
>

Nope.

-- 
Philippe.

