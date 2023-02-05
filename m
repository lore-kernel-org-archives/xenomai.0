Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B64633C1
	for <xenomai@lists.linux.dev>; Sun,  5 Feb 2023 17:50:51 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id BE7D6CD648
	for <xenomai@lists.linux.dev>; Sun,  5 Feb 2023 17:44:46 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E6502C0006;
	Sun,  5 Feb 2023 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1675619079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aH1HLQOFd/AizN+9GkQUbjiCmKBHkcBSJ6A6P6xeDWo=;
	b=gCSGEnFQ5Axlqah3oYptkiCle36nPf5hY3tgCnGo+shWJ6R61d61ET0TpZKYc2rkFso9rR
	UkeZHqqBSeVtvrY5qiE3HXUqyPN4usY8plDbRibnqsvUsS4lsZBHVjjOoEkOpEstE73Xyc
	zGHRUSwHGlkb7Ft67qcAFqaPqRrvsrdsehuTt2xncZzpM/TCPPu8Pebf1f6x4TcwXPYHgs
	IRjSJx2g1vGDEzY19v9kJn8KbLYXfsf2iHaku21gXhcSOJyxW/bof3FkoniCLr2eaJoJKf
	g4r4WvT6jyCXdxxK7JU3ruuM24OMgyYewYjjISVvD6p3Jqjc3cWjA4ZW4fvfTg==
References: <PH1P110MB105032AE6426F4599E6A080CE2F59@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10507C980109C793A20E6910E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10507AF7439E0794AC183597E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050C8C197F9CF9FC17F84B1E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87fscfboox.fsf@xenomai.org>
 <PH1P110MB1050E0B3A0465A0D0911F171E2D69@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>
Subject: Re: [External] - Re: Conflicting EVL Processing Loops
Date: Sun, 05 Feb 2023 18:29:16 +0100
In-reply-to: <PH1P110MB1050E0B3A0465A0D0911F171E2D69@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87wn4w57ne.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Philippe,
>
> An update and question for you.
>
> First, as you know, we found that the built-in heap management in Xenomai
> 4/EVL was causing us substantial performance problems, due to the need to
> perform locking on all memory allocations. The nolock API is not an option
> for us since we perform memory operations in most of our threads. We also
> tried the TLSF manager, but saw similar performance issues.
>
> The good news is that we've adapted the mimalloc memory management library,
> which I believe implements something like the fast bins you mention in your
> earlier email. The performance of mimalloc looks to be very good, and we are
> able to get our dual processing loop system running within our real-time
> constraints. The current implementation is still a bit "hackish", and we're
> continuing to test it and clean it up. I am hoping to get you the specifics
> about what we had to do to implement it, since I think it could be a good
> option for other X4/EVL users. At a high level, it is essentially a
> "go-between" with the Xenomai heap management at the bottom layer, replacing
> the low-level sbrk() used to get memory in a Linux run-time environment.
>
> One nagging problem is that we're still plagued by occasional page faults.
> We have tried to prefault everything we can think of, but we're obviously
> missing something. I go through each accessible section in the
> /proc/self/maps file, prefaulting each one (this includes all code and data
> segments). I have also added a hack to the kernel so that when the "switched
> inband (fault)" occurs, the faulting address is displayed in dmesg. So far,
> all of the runtime page faults we see are in the heap section, which I have
> attempted to prefault completely, even doing it multiple times during
> startup, since the heap section seems to be growing as we start up our real
> time threads. 
>
> So, I'm looking at one of 2 possibilities:
> 1. My prefaulting code, which touches one memory location in each page, is
> not actually doing what it is supposed to. I've declared variables in the
> prefaulting function to be "volatile" so that they don't get optimized out.
> But I don't know any way to really verify that the pages are being mapped in
> and locked.
> 2. A kernel bug, where the pages are not, in fact, being locked into memory.
> We're calling "mlockall(MCL_CURRENT | MCL_FUTURE)", so, even if the heap is
> growing, I don't understand why any future pages are not being populated and
> locked into memory at the very beginning. And, the kernel should not be
> unmapping any of our pages, but perhaps it is?
>
> I know this isn't likely a problem with the EVL code, but we're just about
> out of ideas for how to find and kill this problem. I'm not much of a kernel
> expert. If you have any ideas for how to isolate this problem, especially if
> there's a way to verify whether our process pages are really locked or not,
> they would be greatly appreciated.
>
> [[End of S/MIME Signed Part]]

Mlocked pages may be migrated (Documentation/vm/unevictable-lru.txt
gives details about this), in which case such pages would not be immune
from minor faults when accessed anew after migration, which may be the
events the core detects.

NUMA support and transparent huge pages are the usual suspects in this
case (CONFIG_NUMA, CONFIG_TRANSPARENT_HUGEPAGE), and/or memory
compaction (CONFIG_COMPACTION).

If turning these off is not a suitable option, you could try to fiddle
with the related runtime settings to see what helps,

e.g.

sysctl -w kernel.numa_balancing=0
echo 0 > /proc/sys/vm/compact_unevictable_allowed

Bottom line is that you would need to stop vmscan from invalidating the
page table entries of the mlocked pages (at the expense of less
flexibility in memory management, but that may not be the most important
issue at hand in this case).

-- 
Philippe.
