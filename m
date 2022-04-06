References: <CAPMj8Mu4mjjwxRrYAhrAc+9UHz6Cg9s2a=LqUGE8cohmVgU4fA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: alchemy_init: failed to initialize Alchemy clock
Date: Wed, 06 Apr 2022 15:11:00 +0200
In-reply-to: <CAPMj8Mu4mjjwxRrYAhrAc+9UHz6Cg9s2a=LqUGE8cohmVgU4fA@mail.gmail.com>
Message-ID: <87mtgy1hjh.fsf@xenomai.org>
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
To: Sam Daniel <daniel.jacob.samuel@gmail.com>
Cc: xenomai@xenomai.org


Sam Daniel via Xenomai <xenomai@xenomai.org> writes:

> I recently made several config changes to my Xenomai config (trying to
> move from dev to prod, essentially) and now rtcanrecv issues this
> error:
> # rtcanrecv <bus>
>    0"006.656| WARNING: [rtcanrecv] alchemy_init: failed to initialize
> Alchemy clock (res=1 ns)
>    0"006.804| WARNING: [main] setup call alchemy failed
>    0"006.938| BUG in __xenomai_init(): [main] initialization failed, EAGAIN
>
> I removed several debugging options:
> CONFIG_XENO_OPT_DEBUG_USER
> CONFIG_XENO_OPT_DEBUG_LEGACY
> CONFIG_XENO_OPT_DEBUG_TRACE_RELAX
> CONFIG_IPIPE_TRACE
> (and then added Linux's CONFIG_FUNCTION_TRACER=y)
>
> And I decreased the number of pipes and registry slots:
> CONFIG_XENO_OPT_PIPE_NRDEV: 2048 -> 64
> CONFIG_XENO_OPT_REGISTRY_NRSLOTS: 4096 -> (default)
>

OPT_REGISTRY_NRSLOTS is likely the issue, your application may be
creating lots of Cobalt core objects internally, at least more than 512
which is the default value.

-- 
Philippe.

