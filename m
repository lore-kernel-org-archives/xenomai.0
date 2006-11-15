Subject: Re: [Xenomai-core] [BUG] commit #1833 breaks rt_queue_create
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <455B82F3.702@domain.hid>
References: <455B82F3.702@domain.hid>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 23:17:57 +0100
Message-Id: <1163629078.4974.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
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

On Wed, 2006-11-15 at 22:13 +0100, Jan Kiszka wrote:
> As xnheap_size() changed, a sanity check in xnheap_mmap fails now, at
> least for SVN head, maybe also 2.2.x.
> 
> I would suggest the following patch to fix this, though I'm not 100%
> sure its correct in all cases

It's correct. xnheap_size() is sent back to user-space when creating the
queue, which forwards this in turn to the mmap handler.

>  (do we ever come across a heap of multiple
> extents in xnheap_mmap?).

Yes we do, particularly for ppc which needs this for the system heap.
However, we should not allow mmaping multi-extent heaps. Merged fixes
and added sanity check to prevent the latter issue. Thanks.

> 
> Jan
> 
> 
> PS: I'll spent a beer (or two...) for the one who starts writing a
> testsuite for the native skin - in user-space, please, to catch also
> issues like this one.
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



