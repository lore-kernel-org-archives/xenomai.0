Message-ID: <b647ffbd0702040554m4f9569f1u4b976bc292c6f94c@domain.hid>
Date: Sun, 4 Feb 2007 14:54:21 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
In-Reply-To: <1170529586.8282.38.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170415388.4981.36.camel@domain.hid> <1170420270.4981.58.camel@domain.hid>
	<Pine.LNX.4.64.0702021456170.12191@domain.hid>
	<1170426719.4981.66.camel@domain.hid>
	<Pine.LNX.4.64.0702021635150.12191@domain.hid>
	<Pine.LNX.4.64.0702031807260.22251@domain.hid>
	<1170520703.8282.6.camel@domain.hid>
	<b647ffbd0702031020u2d02d234k309e5fa830c79d21@domain.hid>
	<1170529586.8282.38.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai help <xenomai@xenomai.org>

>
> Really, what I see here very much looks like a constant leakage on an
> otherwise idle system, not some artefact from the mm; albeit the cached
> mem seems stable, the free memory goes down irremediably.

"Slab" counter of /proc/meminfo?

As I can see, seqfile makes use of kmalloc()-ed memory so it should be
accounted by "Slab" if we think of it as a source of the leak.

I suppose, if "MemFree" goes down and non of the other counters (Slab,
Cached, Buffers, Vmalloced,...) get proportionally up, it might mean
something gets memory directly from the buddy allocator - e.g. by
using get_free_pages() for the purpose that's (again) not covered by
any counters..


-- 
Best regards,
Dmitry Adamushko

