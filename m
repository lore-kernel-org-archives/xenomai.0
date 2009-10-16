Message-ID: <4AD8AA02.1050309@domain.hid>
Date: Fri, 16 Oct 2009 19:14:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AD8A87C.4040706@domain.hid>
In-Reply-To: <4AD8A87C.4040706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> our automatic object cleanup on process termination is "slightly" broken
> for the native skin. The inline and macro magic behind
> __native_*_flush_rq() blindly calls rt_*_delete(), but that's not
> correct for mutexes (we can leak memory and/or corrupt the system heap),

Hmm, xnheap_free is actually robust enough to cope with this invalid
release (sem_heap object to system heap), so no corruptions. Still, we
leak, and that's what made me stumble over these bugs.

> queues and heaps (we may leak shared heaps).
> 
> I'm in the process of fixing this, but that latter two are tricky. They
> need user space information (the user space address of the mapping base)
> for ordinary cleanup, and this is not available otherwise.
> 
> At the time we are called with our cleanup handler, can we assume that
> the dying process has already unmapped all its rtheap segments? In that
> case I could simply pass NULL as base address, and the deletion will
> succeed. If not, I would currently lack a good idea how to resolve this
> issue.
> 
> Jan
> 

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

