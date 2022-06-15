References: <PH1P110MB10509BB57F61B3162A85688BE2AA9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: EVL Heap Clarification
Date: Wed, 15 Jun 2022 08:35:56 +0200
In-reply-to: <PH1P110MB10509BB57F61B3162A85688BE2AA9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87o7yupdlo.fsf@xenomai.org>
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
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: xenomai@xenomai.org


Russell Johnson via Xenomai <xenomai@xenomai.org> writes:

> Am I correct in assuming that any dynamic allocation in an EVL thread needs
> to use the EVL heap in order to avoid in-band context switching?
>
>  
>
> There are 4 calls in particular that I am using from the EVL heap API:
> evl_init_heap (on startup), evl_alloc_block (may be called during realtime
> processing to expand a data structure), evl_free_block (on shutdown),
> evl_destroy_heap (on shutdown). The question is are all 4 of these calls
> expected to only ever be called by an EVL thread? Looking at the source
> code, I see that the alloc and free functions lock/unlock an EVL mutex so I
> assume those can only be called from an EVL thread? Though the error codes
> are not checked on those mutex calls, so if you call alloc or free from a
> Linux thread, they do not fail. Can init and destroy be called from a Linux
> thread? I was looking at the test code in libevl for heap-torture, and it
> appeared that all 4 of these functions were being called from an EVL
> attached thread.
>

Please check this documentation, the 3rd column gives the answer:
https://evlproject.org/core/user-api/function_index/#memory-heap-services

-- 
Philippe.

