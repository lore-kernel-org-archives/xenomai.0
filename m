MIME-Version: 1.0
References: <20220405114052.7385-1-richard@nod.at>
 <94940f791d07b0f2e4f8594b26aa47680a024d0b.camel@siemens.com>
In-Reply-To: <94940f791d07b0f2e4f8594b26aa47680a024d0b.camel@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 5 Apr 2022 15:10:54 +0200
Message-ID: <CAFLxGvzdJYiVd+ZsQ++PPcd_P1ajdDPgWe0Tpko0JAo3G5rb_A@mail.gmail.com>
Subject: Re: [PATCH] xnthread_relax: Make sure wakework irq work has a stack
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "richard@nod.at" <richard@nod.at>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Apr 5, 2022 at 3:02 PM Bezdeka, Florian via Xenomai
<xenomai@xenomai.org> wrote:
> I'm not sure if waiting is really what we want. I like the idea of
> moving the work into struct xnthread as Jan already suggested
> internally.

Well, the wait is cheap, it does not involve scheduling.
I'm not sure whether further bloating struct xnthread is wise either.

> ifdef is only necessary for the stable branches. ipipe support has
> already been removed from master/main branch.

Ok!

-- 
Thanks,
//richard

