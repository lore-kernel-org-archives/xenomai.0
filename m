Date: Thu, 4 Feb 2016 13:19:01 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160204131901.6cd6924b@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] huge ioremap from kernel 4.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Toshi Kani <toshi.kani@hp.com>
Cc: Xenomai <xenomai@xenomai.org>

Hey Toshi,

i am working on the xenomai project where we recently rebased our
patches on 4.1. The fact that io-regions may be mapped as huge pages
caused some problem in our patch.

Whenever memory is vmalloced or ioremapped we make sure it is synched
into all mm's to avoid page faults in that area. We use
vmalloc_sync_one to do that. Now vmalloc_sync_one can not handle huge
pages (i am talking about x86 32+64). Hence for areas where you
introduced huge pages vmalloc_fault should never happen in any mm,
otherwise your patchset would have introduced a regression in mainline.

Can you help me understand by which mechanism these io-regions are
always mapped into all mm's, ruling out calls to vmalloc_fault and
vmalloc_sync_one? Because calling this on these regions will treat you
device memory as pagetables when huge pages are used.

Best regards,
Henning

