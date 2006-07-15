Subject: Re: [Xenomai-help] Xenomai heap services
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F912B@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F912B@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 03:14:08 +0200
Message-Id: <1152926048.5027.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Mon, 2006-07-10 at 13:56 +0200, Roderik_Wildenburg@domain.hid wrote:
> - why rt_heap_alloc fails

Because nucleus heaps the native ones are based on, are given the start
address of the memory segment to use, from which they borrow a certain
portion for housekeeping data. IOW, heaps give no guarantee that the
full size of the memory segment will be available for user allocation.
The fact that native heaps could hide this by passing a larger memory
segment to encompass the internal overhead is another issue. They
attempt to actually, but fail on rounding errors.

> - what the error -EAGAIN means

You passed TM_NONBLOCK telling Xenomai that your task could not be
suspended to wait for more memory to be available, and your allocation
request could not be fulfilled immediately, so -EWOULDBLOCK has been
returned. EAGAIN and EWOULDBLOCK are the same value.

> - why heaps are limited to 16MB

Nucleus heaps are not limited to 16Mb, heap extents are, and heaps may
have several active extents, albeit the native skin only uses a single
(initial) one, because we want the entite heap space to be contiguous
for the native skin, due to the H_MAPPABLE property. This said, this
16Mb limit looks pretty useless.

-- 
Philippe.



