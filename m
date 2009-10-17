From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AD8A87C.4040706@domain.hid>
References: <4AD8A87C.4040706@domain.hid>
Content-Type: text/plain
Date: Sat, 17 Oct 2009 19:15:37 +0200
Message-Id: <1255799737.2862.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Native: Fixing auto-cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2009-10-16 at 19:08 +0200, Jan Kiszka wrote:
> Hi,
> 
> our automatic object cleanup on process termination is "slightly" broken
> for the native skin. The inline and macro magic behind
> __native_*_flush_rq() blindly calls rt_*_delete(), but that's not
> correct for mutexes (we can leak memory and/or corrupt the system heap),
> queues and heaps (we may leak shared heaps).

Please elaborate regarding both queues and heaps (scenario).

> 
> I'm in the process of fixing this, but that latter two are tricky. They
> need user space information (the user space address of the mapping base)
> for ordinary cleanup, and this is not available otherwise.
> 
> At the time we are called with our cleanup handler, can we assume that
> the dying process has already unmapped all its rtheap segments?

Unfortunately, no. Cleanup is a per-skin action, and the process may be
bound to more than a single skin, which could turn out as requiring a
sequence of cleanup calls.

The only thing you may assume is that an attempt to release all memory
mappings for the dying process will have been done prior to receive the
cleanup event from the pipeline, but this won't help much in this case.
This attempt may fail and be postponed though, hence the deferred
release callback fired via vmclose.

>  In that
> case I could simply pass NULL as base address, and the deletion will
> succeed. If not, I would currently lack a good idea how to resolve this
> issue.
> 
> Jan
> 
-- 
Philippe.



