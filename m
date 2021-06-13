References: <20210613155522.1851338-1-rpm@xenomai.org>
 <20210613155522.1851338-2-rpm@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 2/2] ARM: irq_pipeline: preserve lockdep irq state
 across kernel entries
In-reply-to: <20210613155522.1851338-2-rpm@xenomai.org>
Date: Sun, 13 Jun 2021 17:58:55 +0200
Message-ID: <87wnqx7o3k.fsf@xenomai.org>
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
To: xenomai@xenomai.org


Philippe Gerum <rpm@xenomai.org> writes:

> From: Philippe Gerum <rpm@xenomai.org>
>
> When lockdep is enabled, per_cpu(hardirqs_enabled) may not be in sync
> with the in-band stall bit on kernel entry upon preemption by an
> IRQ. This may happen since the relevant local_irq_* calls do not
> manipulate the stall bit and the lockdep irq state atomically (for a
> good reason). In addition, the raw_local_irq API may be used directly,
> without lockdep tracking whatsoever (e.g. when manipulating raw
> spinlocks).

A similar fix may be needed for x86 in the generic entry code when
pipelining interrupts.

-- 
Philippe.

