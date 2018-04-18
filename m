References: <638350e7-cd56-9427-179a-a066d1e4ce75@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4bf678c4-d4b6-952d-997f-09acfe30477a@siemens.com>
Date: Wed, 18 Apr 2018 12:45:55 +0200
MIME-Version: 1.0
In-Reply-To: <638350e7-cd56-9427-179a-a066d1e4ce75@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Dropping pvalloc/pvfree/pvstrdup from
	libcopperplate
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2018-04-17 19:31, Philippe Gerum wrote:
> 
> -- the context
> 
> Non-POSIX APIs Xenomai 3 implements in user-space are all based on
> libcopperplate, a mediating layer which hides the real-time core from
> the real-time API implementation, so that the same API can run over
> Cobalt or native glibc services unmodified. libcopperplate also provides
> common building blocks for implementing real-time APIs.
> 
> libcopperplate can be built with support for sharing the main (real-time
> capable) heap memory between multiple processes when --enable-pshared is
> given to the configure script.  Objects stored in this heap can be
> accessed by all processes sharing the same session label (see the
> --session command line argument for applications), and any process which
> belongs to that session can issue allocation requests to this shared
> heap transparently.
> 
> The pvalloc(), pvfree() and pvstrdup() routines exposed by
> libcopperplate are wrappers to the internal (real-time capable)
> allocator delivering strictly private, process-local memory, by contrast
> to process-shared chunks returned by the main allocator.
> 
> Managing shared blocks requires a bit more CPU cycles per allocation
> requests, since all references to the shared memory are in essence
> offset-based. So the idea was to optimize the allocation of memory
> chunks which are in essence process-private by using a dedicated
> allocator dealing with plain memory references. Should an awful lot of
> private memory be allocated by some processes in the session, this
> separation would keep the pressure off of the main shared heap too.
> 
> In the Xenomai code base, xnmalloc() always refers to the main heap,
> which may be shared or not. If --enable-pshared was not given,
> xnmalloc() and pvmalloc() are strictly equivalent, pulling memory from
> the only allocator linked in, which delivers private memory.
> 
> -- the issue
> 
> When --disable-pshared is in effect (default), the --mem-pool-size
> argument sets the size of the main, process-local heap memory to which
> all of xnmalloc(), pvmalloc() and friends refer to. So far, so good.
> 
> When --enable-pshared is in effect, the --mem-pool-size argument sets
> the size of the main, shared heap memory. However, we currently have no
> mean to define the size of the private heap memory in this case, and a
> tiny default value of 8k is built in. This led to ugly side-effects
> reported recently when using the fuse-based registry for applications,
> causing some confusion with OOM errors [1].
> 
> To sum up, we need to make the size of the private heap configurable.
> Or, we may reconsider the usefulness of maintaining a separate private
> heap when --enable-pshared is set.
> 
> -- the observation
> 
> pvmalloc()/pvstrdup() are used only a very few times in the Xenomai
> libraries, and always for small bits. Those allocations are not supposed
> to happen in any time-critical phase of any application either. So the
> two conditions which led to adding the private memory allocator are not
> met by the current Xenomai code base, making that private allocation
> scheme useless in this context.
> 
> -- the cure
> 
> We have two options:
> 
> - considering that pvmalloc() and friends are not part of the public
> interface and drop them bluntly, turning the few existing calls to the
> xnmalloc() interface, solving the heap size configuration problem in the
> same move.
> 
> - keeping pvmalloc(), adding some option to set its size for fixing the
> original issue [1].
> 
> If you do depend on pvmalloc() today, you may want to make the case for
> keeping it.

I find it in some out-of-tree code, along with pvhash, but I assume we
can simply switch to the normal heap - specifically as pshared is off so
far.

Jan

> 
> Thanks,
> 
> [1] http://xenomai.org/pipermail/xenomai/2018-April/038595.html
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

