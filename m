References: <CADXNiGUL514kD3+aHJRRcru8E8Lz3XUd3mDF=ng4xTm4QnoKFA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b16ed60f-31f2-3ef0-f7bc-a35de9629b51@xenomai.org>
Date: Sat, 21 Jul 2018 10:47:00 +0200
MIME-Version: 1.0
In-Reply-To: <CADXNiGUL514kD3+aHJRRcru8E8Lz3XUd3mDF=ng4xTm4QnoKFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cobalt Scheduling tasks on a single core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>, xenomai@xenomai.org

On 07/21/2018 01:28 AM, Jackson Jones wrote:
> We are running against xenomai 3.0.7 on a quad core arm (i.mx6).  Xenomai
> was configured with these arguments:
> 
> #export CFLAGS=-O2 LIBS=-lposix
> ./configure \
>     --with-core=cobalt \
>     --enable-smp \
>     --enable-registry \
>     --enable-pshared \
>     --enable-dlopen-libs \
>     --enable-sanity \
>     --disable-tls \
>     --enable-valgrind-client \
>     --disable-assert
> 
> The main app spawns off several real time tasks. Cobalt is scheduling all
> the real-time tasks on one core. Is this normal behavior for Cobalt? I
> would expect it to take advantage of the multiple cores.

Your application has to decide for this, CPU migration is costly in many
ways, increases latency. For this reason, no Xenomai co-kernel ever has
implemented any load balancing of any sort. On the contrary, it does pin
each emerging thread to its current CPU precisely to prevent unexpected
migration while the threads runs in secondary mode, before entering the
rt processing loop - this CPU may of course be changed by the
application afterwards.

What you are seeing here is the default assignment of threads to CPUs:
the regular kernel picked a base CPU for each newly created thread, then
Cobalt pinned it there.

The idea is to figure out the best placement of the rt threads among the
CPUs available for rt processing, moving them accordingly using
sched_setaffinity() during the init phase. This placement could be
paired with setting xenomai.supported_cpus for restricting the CPUs
dedicated to real-time duties to a subset of the available cores.

-- 
Philippe.

