References: <cover.1625777265.git.jan.kiszka@siemens.com>
 <CAFLxGvw34vnYx57bP7cYv5HgRCbmPaGNBQzeQudyU-upq+u_-w@mail.gmail.com>
 <5185508f-d8b7-fb49-de71-65c70eb33f8a@siemens.com>
 <CAFLxGvyKL0gW4Nz41vwDFG6JRWb9YMQxtuB81=24B677mVebdQ@mail.gmail.com>
 <bd64f2a7-f81a-5121-d428-54e3dde17f37@siemens.com>
 <CAFLxGvxqpKLF5xE3-D-b_kQoUtZOcpfk-MK8DAo94Sz8VCOoog@mail.gmail.com>
 <7daf0026-aab0-0d32-b52f-3f5ce993a7ac@siemens.com>
 <CAFLxGvwxCyhxVAFP6nRBgi5riFVTxHWPZ7H0gisL=6trWeMhuA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v2 0/3] Add callback-like mechanism before/after ptrace
 stops
In-reply-to: <CAFLxGvwxCyhxVAFP6nRBgi5riFVTxHWPZ7H0gisL=6trWeMhuA@mail.gmail.com>
Date: Tue, 20 Jul 2021 15:56:45 +0200
Message-ID: <87r1ftqeaq.fsf@xenomai.org>
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Richard Weinberger via Xenomai <xenomai@xenomai.org> writes:

> On Tue, Jul 20, 2021 at 12:53 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> > I've heard that with dovetail Xenomai no longer sees exceptions.
>> > So this is a set in stone concept?
>>
>> Xenomai can no longer declare exceptions resolved. It still sees them.
>
> Understood.
>
>> If we come up with a reasonable use case, I can't imagine that this is
>> set in stone.
>
> I can understand that dovetail doesn't want to offer something super generic
> as ipipe_trap_hook().

Just like the I-pipe, Dovetail implements a way to tell the companion
core that "something happened", including a fault for the current task,
by calling handlers with weak bindings the core can
override. For faults, this would be oob_trap_notify().

> But maybe it can offer enough to implement signal delivery for exceptions?
>
> The signal approach also allows us to use the very same signal
> handlers in userspace
> for realtime as provided by Xenomai and PREEMPT_RT.

You may want to post a proposal of such a feature for a recent Dovetail
release, so that we can discuss it, and figure out whether it can be
easily maintained for all the supported architectures in the long
run. This is the key issue to me.

-- 
Philippe.

