Date: Tue, 11 Jul 2017 17:47:36 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170711174736.6d2b3a68@md1em3qc>
In-Reply-To: <8a41c134-9ad4-ee16-abe7-9d781713dba9@utpvision.it>
References: <8a41c134-9ad4-ee16-abe7-9d781713dba9@utpvision.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel CONFIG_MIGRATION flag
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Simone Zucchi <simone.zucchi@utpvision.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Tue, 11 Jul 2017 14:50:15 +0000
schrieb Simone Zucchi <simone.zucchi@utpvision.it>:

> Hello everybody,
> I hope I won't be considered a spammer because of 2 mails in half an
> hour :) I couldn't really find any doc about CONFIG_MIGRATION flag
> and how it could worsen latency over Xenomai.

Well if the linux-kernel is busy moving memory around, other load -
like realtime threads - might have to wait for that to finish. I would
not be too worried about it. 

> I wanted to disable it, just to be sure, but I can't really work it
> out. http://cateee.net/lkddb/web-lkddb/MIGRATION.html shows relative
> dependencies about it but even disabling all of them I can't disable
> it. Could I please attach my .config in this mailing list willing for
> help?

If you have a closer look you will also see
Selected by: COMPACTION [=y] && MMU [=y] || CMA [=n] && HAVE_MEMBLOCK
[=y] && MMU [=y]
That information can be seen i.e. in "make menuconfig". From there find
a way to break the chain that is pulling it in. I guess MMU should stay
enabled, so COMPACTION and its "Selected by"s.

Henning

> Thanks in advance,
> 
> Simone
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


