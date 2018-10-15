Date: Mon, 15 Oct 2018 21:01:14 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
Message-ID: <1840972159.10340438.1539637274299@mail.yahoo.com>
In-Reply-To: <ddf9dee0-653d-b784-b01f-8d09a3fda629@siemens.com>
References: <144decef-a102-1cee-a9b1-8be5ed0d1258@siemens.com>
 <1882419000.9157539.1539392168772@mail.yahoo.com>
 <ddf9dee0-653d-b784-b01f-8d09a3fda629@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [ipipe 4.14][PATCH] x86: ipipe: Fix trap hooking for
 userspace routes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

>Those two commits install fundamental features of the I-pipe patch set, you 
>can't reasonably run Xenomai without them.

The 3.18.20-x86-9 patch for example works just fine, and the only function I see that's related to e6b81a0ce7fb86cf1f1db9f80b982c9b5f95c4c1in that patch is __ipipe_trap_prologue.

I only took a quick glance at any of this so don't mind me, but all those trapnrs weren't added to entry_64.S previously, and there wasn't massive breakage everywhere.

Assembly isn't my thing so my best bet is to just use whatever worked before, but if the fix is sufficient, then never mind. :)

Alec

