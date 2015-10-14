References: <2122790682.242206.1444818142434.JavaMail.yahoo@mail.yahoo.com>
 <2122790682.242206.1444818142434.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <561E31CA.1080008@xenomai.org>
Date: Wed, 14 Oct 2015 12:43:22 +0200
MIME-Version: 1.0
In-Reply-To: <2122790682.242206.1444818142434.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_heap_alloc size 0 - syscall 7 denied
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/14/2015 12:22 PM, Frederik Bayart wrote:
> Hallo,
> I'm using xenomai 3.0 on kernel 3.18.20 (64 bit).
> 
> When using single block heap, I'm getting memory allocation problem when calling rt_heap_alloc with size 0. I don't get the error when calling the function with size used in rt_heap_create.
> On the mailing list, I found there has been an issue with this in May : http://www.xenomai.org/pipermail/xenomai/2015-May/034165.html
> Is this still an issue ?

No, this one is long gone.

> 
> In attachment a test program htest.c + makefile to generate the problem :
> 
> $ sudo ./htest 1  ==> use 0
> htest.c:69: heapsize = 70000, usablemem = 70144, usedmem = 0
> htest.c:79 ERROR: rt_heap_alloc(-12): Cannot allocate memory
> 
> $ sudo ./htest 1  ==> use same size as in create
> htest.c:69: heapsize = 70000, usablemem = 70144, usedmem = 0
> htest.c:92: heapsize = 70000, usablemem = 70144, usedmem = 70144
>

Does this help?

diff --git a/lib/alchemy/heap.c b/lib/alchemy/heap.c
index 20531e3..146bfa1 100644
--- a/lib/alchemy/heap.c
+++ b/lib/alchemy/heap.c
@@ -442,7 +442,9 @@ int rt_heap_alloc_timed(RT_HEAP *heap,
 		p = __mptr(hcb->sba);
 		if (p)
 			goto done;
-		if (size > 0 && size != hcb->size) {
+		if (size == 0)
+			size = heapobj_size(&hcb->hobj);
+		else if (size != hcb->size) {
 			ret = -EINVAL;
 			goto done;
 		}

> However, I both cases, I get a trace in dmesg :
> 
> [Xenomai] syscall <7> denied to sysregd
> 

That one is a different issue. Does your application have supervisor or
user privileges?

-- 
Philippe.

