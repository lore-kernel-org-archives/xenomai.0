Message-ID: <54aa3260-9a9b-dbdb-90a8-6395fd86fc28@siemens.com>
Date: Tue, 5 Apr 2022 17:38:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] xnthread_relax: Make sure wakework irq work has a stack
Content-Language: en-US
References: <20220405114052.7385-1-richard@nod.at>
 <94940f791d07b0f2e4f8594b26aa47680a024d0b.camel@siemens.com>
 <CAFLxGvzdJYiVd+ZsQ++PPcd_P1ajdDPgWe0Tpko0JAo3G5rb_A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvzdJYiVd+ZsQ++PPcd_P1ajdDPgWe0Tpko0JAo3G5rb_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "richard@nod.at" <richard@nod.at>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05.04.22 15:10, Richard Weinberger wrote:
> On Tue, Apr 5, 2022 at 3:02 PM Bezdeka, Florian via Xenomai
> <xenomai@xenomai.org> wrote:
>> I'm not sure if waiting is really what we want. I like the idea of
>> moving the work into struct xnthread as Jan already suggested
>> internally.
> 
> Well, the wait is cheap, it does not involve scheduling.
> I'm not sure whether further bloating struct xnthread is wise either.
> 

Let's not optimize before we are actually sure that the issue is what we
assume it to be.

I would like to have an explanation or prove points (traces, assertions)
that we actually see xnthread_relax overtaking the delivery of its own
wakework.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

