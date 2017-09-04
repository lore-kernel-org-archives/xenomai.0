MIME-Version: 1.0
In-Reply-To: <mailman.3.1504346402.23923.xenomai@xenomai.org>
References: <mailman.3.1504346402.23923.xenomai@xenomai.org>
From: Jim Langston <jim.langston@gmail.com>
Date: Mon, 4 Sep 2017 07:28:28 -0400
Message-ID: <CAF06wtgmdp=pY5AVGpT4mvo6iG0PwQO5rSn40A6c7GRrkm0aLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Xenomai Digest, Vol 65, Issue 2
Reply-To: jlangston@panurgyinc.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Steve,

Thanks for the tip, that helped a lot.  What led me a astray was that there
is a set of APIs used to allocate/deallocate that block of memory that gets
passed to xnheap_init(); I stupidly assumed that the xnheap_init() function
was the starting point.  Silly me!

The following aren't even mentioned in the DOxygen documents for the Cobalt
API:

u32 xnheap_get_size(const struct xnheap *heap)
u32 xnheap_get_free(const struct xnheap *heap)
void *xnheap_get_membase(const struct xnheap *heap)

u32 xnheap_rounded_size(u32 size)
void *xnheap_vmalloc(size_t size);
void xnheap_vfree(void *p);

The last three are pretty important, with the 'xnheap_rounded_size()' being
quite useful to get the block with the right size requirements. Time to go
debug...

Thanks again for the tip!

Jim

On Sat, Sep 2, 2017 at 6:00 AM, <xenomai-request@xenomai.org> wrote:

>
> Message: 2
> Date: Sat, 02 Sep 2017 03:43:56 +0000
> From: "Stephen D. Cohen" <steve@uscohens.com>
> To: jlangston@panurgyinc.com, Philippe Gerum <rpm@xenomai.org>
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Issues building old drivers under Xenomai 3.0.5
> Message-ID:
>         <CAO460__UFSJ4MMGsMthASEmxWQZeEcoUkX9Nk
> MfOGQiQYuOaqA@mail.gmail.com>
> Content-Type: text/plain; charset="UTF-8"
>
> Mr. Langston,
>
>      You have to provide the memory block which conforms to the
> requirements outlined in the documentation for xnheap_init. One place you
> can find an example of using an xnheap is in the ipc drivers. The bind
> routines in those drivers all use xnheap to manage private heaps for the
> interfaces.
>
> Regards,
>
> Steve Cohen
>
