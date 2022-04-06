MIME-Version: 1.0
From: Sam Daniel <daniel.jacob.samuel@gmail.com>
Date: Wed, 6 Apr 2022 12:11:10 +0200
Message-ID: <CAPMj8Mu4mjjwxRrYAhrAc+9UHz6Cg9s2a=LqUGE8cohmVgU4fA@mail.gmail.com>
Subject: alchemy_init: failed to initialize Alchemy clock
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I recently made several config changes to my Xenomai config (trying to
move from dev to prod, essentially) and now rtcanrecv issues this
error:
# rtcanrecv <bus>
   0"006.656| WARNING: [rtcanrecv] alchemy_init: failed to initialize
Alchemy clock (res=1 ns)
   0"006.804| WARNING: [main] setup call alchemy failed
   0"006.938| BUG in __xenomai_init(): [main] initialization failed, EAGAIN

I removed several debugging options:
CONFIG_XENO_OPT_DEBUG_USER
CONFIG_XENO_OPT_DEBUG_LEGACY
CONFIG_XENO_OPT_DEBUG_TRACE_RELAX
CONFIG_IPIPE_TRACE
(and then added Linux's CONFIG_FUNCTION_TRACER=y)

And I decreased the number of pipes and registry slots:
CONFIG_XENO_OPT_PIPE_NRDEV: 2048 -> 64
CONFIG_XENO_OPT_REGISTRY_NRSLOTS: 4096 -> (default)

Am I missing something obvious in my Xenomai/Linux configuration? Or
is there a deeper issue with my configuration? or possibly even my
custom RTCAN driver?

