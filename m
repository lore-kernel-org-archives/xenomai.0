From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46EB8F11.2010009@domain.hid>
References: <46EB8F11.2010009@domain.hid>
Content-Type: text/plain
Date: Thu, 04 Oct 2007 10:13:17 +0200
Message-Id: <1191485597.20623.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [Resent][RFC-PATCH] Instrument smp_processor_id
	/wrt illicit	usage
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Sat, 2007-09-15 at 09:51 +0200, Jan Kiszka wrote:
> This is still in my local queue, don't recall anymore when we last
> discussed it and if there was some issue remaining.
> 
> Anyway, here is a rebased set to detect calls of smp_processor_id() from
> illicit contexts (non-root) on archs that bother about this. Only i386
> is cared about so far, x86_64 and PowerPC should be treated similarly,
> other (future) SMP-arch would arm the check automatically. Yet another
> safety bag for porting I-pipe.

Last time, the ancestor of this patch badly broke my x86_84 setup,
causing hell in the NMI path for instance. A number of fixes you sent
lately have improved the situation since then for sure, so I will hold
those patches until the pending 2.6.22 issues are fixed, but will merge
in the end.

> 
> Jan
-- 
Philippe.



