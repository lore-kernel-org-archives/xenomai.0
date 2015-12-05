Date: Sat, 5 Dec 2015 15:45:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151205144506.GG29398@hermes.click-hack.org>
References: <tencent_3993D3B2716D21357806B8B3@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_3993D3B2716D21357806B8B3@qq.com>
Subject: Re: [Xenomai] Question about xnmalloc and xnheap_alloc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?44OL44Oj44Oz5pif5Lq6?= <1173264124@qq.com>
Cc: xenomai <xenomai@xenomai.org>

On Sat, Dec 05, 2015 at 05:11:02PM +0800, ニャン星人 wrote:
> Hi, I had read the source code of xenomai3.X. And I am curious
> about the difference between xnmalloc and xnheap_alloc.

The answer is in xnmalloc definition:
#define xnmalloc(size)     xnheap_alloc(&cobalt_heap, size)

> When using this two api, where the memory these api apply from.

The memory has been reserved prior to calling these functions, and
an "xnheap" object initialized with the xnheap_init call.

> What do the variable cobalt_heap use for?

cobalt_heap is the "global heap" object. You can use memory from
this heap object with xnmalloc, or use memory from another heap
object (initialized with xnheap_init) with xnheap_alloc.

> 
> 
>     How can I achieve shared memory function by use these two api
>     in kernel between xenomai and linux? 

Any memory obtained with Linux memory allocation function is shared
between Xenomai and Linux. The xnheap objects are just a way to
pre-allocate some memory and allow a kind of dynamic allocation for
real-time services without resorting to Linux services. But the
memory you pass to an xnheap object (and in particular the
cobalt_heap object memory) is generally some Linux memory that has
been allocated in advance.

-- 
					    Gilles.
https://click-hack.org

