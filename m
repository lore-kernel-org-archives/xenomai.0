References: <5224b3e2-d316-d61b-347f-6a6cac8d6360@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6e81235e-95bb-b169-d2ed-4dd26a33c126@xenomai.org>
Date: Tue, 3 Jul 2018 19:23:20 +0200
MIME-Version: 1.0
In-Reply-To: <5224b3e2-d316-d61b-347f-6a6cac8d6360@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cobalt __SIGPOOL_SIZE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 07/02/2018 03:18 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> The comment for __SIGPOOL_SIZE in kernel/cobalt/posix/signal.c suggests
> that there can't be many signals in pending state at the same time, but
> I think it is wrong: Signal are collected per thread, and each of it can
> pile up multiple of them. Even if we assume that typical threads will
> not queue those for long and will not wait for many of them, the fact
> that the system-wide(!) number of threads is a scaling factor and the
> pool is system-wide as well makes me wonder if __SIGPOOL_SIZE shouldn't
> become a tunable.
> 

Still pondering the idea here. A static tunable would be a way of
postponing the issue until after the point it should not happen anymore,
but picking a safe value would still be guess work.

We could pre-allocate a pool from the core heap, then pull extra
sigpending blocks from the same place upon starvation if need be. But
then, we'd need a way to figure out when a sigpending struct comes from
the pool, when it has been allocated elsewhere. I don't see any elegant
way to do that at the moment (meaning: without stuffing that struct with
some ugly boolean).

-- 
Philippe.

