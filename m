Date: Tue, 27 Mar 2018 11:25:58 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180327112558.3fc3e8eb@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <52bd261d-07c2-80d1-77f4-fb501795dea7@frank-benkert.de>
References: <52bd261d-07c2-80d1-77f4-fb501795dea7@frank-benkert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Regression posix/mprotect failed on Xenomai 2.6.5 on
 powerpc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frank Benkert <xenomai@frank-benkert.de>
Cc: xenomai@xenomai.org

Am Tue, 27 Mar 2018 09:59:37 +0200
schrieb Frank Benkert <xenomai@frank-benkert.de>:

> Hello,
> 
> we have to maintain an old productive system.

Good luck ;) The versions you are using are not maintained anymore.

> It's based on a powerpc MPC5200.
> After updating Xenomai from 2.6.1 to 2.6.5 the Xenomai regression
> test suite failed on posix/mprotect:
> 
> + /usr/bin/regression/posix/mprotect
> memory read
> memory write after exec enable
> memory write after write enable
> memory read/write after access enable
> FAILURE main:102: read zero returned 255 instead of 0
> 
> Did someone else also discovered this problem or does a wrong 
> configuration of our system triggers this?
> 
> The effective config.gz is attached.
> 
> Our Kernel is 3.5.3 and was originally patched with
> scripts/prepare-kernel.sh from Xenomai v2.6.1
> could that be the problem? I thought this only patches ipipe into the 
> kernel - regardless of the xenomai version.

Yes that is a problem. You will need to patch the kernel again. It
should already be ipipe-enabled and prepare-kernel adds the cokernel.
(part of xenomai)

Henning

> Am I wrong?
> 
> Thanks!
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: config.gz
> Type: application/gzip
> Size: 12427 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20180327/c70e78a7/attachment.bin>
> _______________________________________________ Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


