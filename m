MIME-Version: 1.0
References: <20220408080401.22235-1-richard@nod.at>
 <20220408080401.22235-3-richard@nod.at>
 <54b7b6a9-de04-54e9-b8dc-c8053a64b060@siemens.com>
In-Reply-To: <54b7b6a9-de04-54e9-b8dc-c8053a64b060@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 14 Apr 2022 13:17:33 +0200
Message-ID: <CAFLxGvwxZ-Ycqa-8UXj1Kk0vHR8NqQ+5oy_8aqRGMP4zxk-GTQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] testsuite: Hook up alchemytests
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
Cc: Richard Weinberger <richard@nod.at>, Xenomai <xenomai@xenomai.org>

On Thu, Apr 14, 2022 at 1:12 PM Jan Kiszka via Xenomai
<xenomai@xenomai.org> wrote:
> With only up to here applied:
>
> make[2]: Entering directory 'xenomai/build/testsuite/alchemytests'
> make[2]: *** No rule to make target 'alchemytest_driver.c', needed by
> 'alchemytest_driver.o'.  Stop.

Ah, alchemytest_driver.c comes in a follow up patch.
Will be fixed in a later series.

> > +task10_SOURCES = task-10.c
> > +task10_CPPFLAGS = $(alchemycppflags)
> > +task10_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> > +task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
>
> Lots of repetitions. Can we use at least some macro for them, or can't

My automake-fu is weak. Does automake support something like that?

> we assign CPPFLAGS, LDADD and LDFLAGS globally (in this file)?

I can give this a try. So far I didn't use global variables because building
the tests and the test driver is slightly different and may change.

-- 
Thanks,
//richard

