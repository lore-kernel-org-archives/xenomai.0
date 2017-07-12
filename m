References: <8a41c134-9ad4-ee16-abe7-9d781713dba9@utpvision.it>
 <20170711174736.6d2b3a68@md1em3qc>
 <ac664b06-6acb-0a50-feae-68b565b4ac49@utpvision.it>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6ec66e3d-f218-6451-230b-d4bf1600c2e0@xenomai.org>
Date: Wed, 12 Jul 2017 16:53:48 +0200
MIME-Version: 1.0
In-Reply-To: <ac664b06-6acb-0a50-feae-68b565b4ac49@utpvision.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Simone Zucchi <simone.zucchi@utpvision.it>, Henning Schild <henning.schild@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/12/2017 08:35 AM, Simone Zucchi wrote:
> Well I've just managed to disable it. Seems the problem was 
> TRANSPARENT_HUGEPAGE flag
> which selected COMPACTION which selects MIGRATION.
> Great :) thanks

As migration involves a series of changes to the page table done from
the (non-rt) virtual memory core, an increased rate of minor page faults
taken by the rt side has been observed in the wake of those fixups,
which directly translates into latency peaks. This is why
CONFIG_MIGRATION is flagged as potentially raising the overall latency
figures in Kconfig.

This is not only a matter of dealing with large NUMA configurations
though, since CONFIG_MIGRATION is also used by the memory compaction
machinery, as you found out. So even on embedded systems, those peaks
stand out.

Granted, page migration does not cause pathological latency peaks; but
those tend to get in the way nevertheless on some SoCs when Xenomai is
used to drive a closed loop control software running a high frequency
acquisition.

-- 
Philippe.

