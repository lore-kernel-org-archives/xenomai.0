From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17588.60046.972123.383913@domain.hid>
Date: Wed, 12 Jul 2006 14:26:54 +0200
Subject: Re: [Xenomai-core] [PATCH] fix xnheap_alloc rounding
In-Reply-To: <44B3AF69.4050100@domain.hid>
References: <44B3AF69.4050100@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Hi,
 > 
 > playing a stupid rt_heap user (actually I didn't just play this...), I
 > stumbled over this undocumented oddity:
 > 
 > rt_heap_create(&heap, name, 10000, H_PRIO|H_MAPPABLE);
 > rt_heap_alloc(&heap, 10000, TM_NONBLOCK, &ptr);
 > 
 > Creation is successful, allocation fails. The reason: while during
 > creation the net heap size is rounded down to page boundaries, the
 > allocation of memory > PAGE_SIZE is rounded up. One could add H_SINGLE
 > to the flags, but this may even result in allocating less memory than
 > the user expected, causing severe problems later.
 > 
 > How to resolve this best? I thought about rounding twice in
 > rt_head_create (one time the net size, the second time including the
 > overhead), but this encodes characteristics of the underlying heap
 > allocator into the skin (I have a generic heap allocator framework in
 > mind for 2.3). So I decided to do this rounding in xnheap_overhead()
 > instead, see attached patch. Hope I didn't skewed up any calculation. At
 > least the scenario above now works fine.

The problem I see with this patch is that you are counting 
(rounded_hsize - hsize) as part of the overhead, whereas you would like to
count it as free space. Would not it make more sense to do the rounding
in xnheap_init_mapped ?

-- 


					    Gilles Chanteperdrix.

