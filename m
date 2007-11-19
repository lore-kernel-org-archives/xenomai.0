Message-ID: <4741D0AC.40308@domain.hid>
Date: Mon, 19 Nov 2007 19:06:36 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2AE09170@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AE09170@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write error: "Cannot allocate memory ";
 bug or feature ?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik.Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik.Wildenburg@domain.hid wrote:
> 
> But the allocated block keeps bounded to a spezial block size and if
> some other
> blocksize is needed an other block is alloctated ?
>

No more than one block is allocated at any given time in your example.
This is expected due to the priority scheme your test undergoes. In any
case, 282 bytes (+ a few bytes message header) should grab one 512-byte
buffer here. For anything below the size of a logical page (4k in
2.3.x), the allocator picks the next power of 2 greater or equal to the
requested size.

2.3.x is known to suffer a sub-optimal setting for the page size used in
various internal heaps which has been fixed in v2.4, sometimes leading
to a useless overhead caused by the heap's internal header. Still, in
your case, and even with a 10k setting, you should have two 4k pages
available, one being split in 8 x 512 byte blocks due to
rt_queue_write() queuing a 282-byte block. And no more than one block
among the eight available should be busy at any given time.

What if you don't set any limit to the queue elements, i.e. passing
Q_UNLIMITED instead of 10. Does this change the behaviour?

-- 
Philippe.

