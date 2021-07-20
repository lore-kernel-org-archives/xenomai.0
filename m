MIME-Version: 1.0
References: <cover.1625777265.git.jan.kiszka@siemens.com>
 <CAFLxGvw34vnYx57bP7cYv5HgRCbmPaGNBQzeQudyU-upq+u_-w@mail.gmail.com>
 <5185508f-d8b7-fb49-de71-65c70eb33f8a@siemens.com>
 <CAFLxGvyKL0gW4Nz41vwDFG6JRWb9YMQxtuB81=24B677mVebdQ@mail.gmail.com>
 <bd64f2a7-f81a-5121-d428-54e3dde17f37@siemens.com>
 <CAFLxGvxqpKLF5xE3-D-b_kQoUtZOcpfk-MK8DAo94Sz8VCOoog@mail.gmail.com>
 <7daf0026-aab0-0d32-b52f-3f5ce993a7ac@siemens.com>
In-Reply-To: <7daf0026-aab0-0d32-b52f-3f5ce993a7ac@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 20 Jul 2021 13:17:20 +0200
Message-ID: <CAFLxGvwxCyhxVAFP6nRBgi5riFVTxHWPZ7H0gisL=6trWeMhuA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add callback-like mechanism before/after ptrace
 stops
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>

On Tue, Jul 20, 2021 at 12:53 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > I've heard that with dovetail Xenomai no longer sees exceptions.
> > So this is a set in stone concept?
>
> Xenomai can no longer declare exceptions resolved. It still sees them.

Understood.

> If we come up with a reasonable use case, I can't imagine that this is
> set in stone.

I can understand that dovetail doesn't want to offer something super generic
as ipipe_trap_hook().
But maybe it can offer enough to implement signal delivery for exceptions?

The signal approach also allows us to use the very same signal
handlers in userspace
for realtime as provided by Xenomai and PREEMPT_RT.

-- 
Thanks,
//richard

