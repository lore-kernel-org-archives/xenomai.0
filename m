Date: Mon, 27 Aug 2018 19:33:23 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180827193323.785a95da@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180827133347.26289-1-henning.schild@siemens.com>
References: <20180827133347.26289-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0/1] Eager FPU switching for ipipe-4.9.y
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

I have similar patches for 4.4 and 4.14. At the moment 4.14 can not be
tested yet since we still have interrupt issues in there.
The proposal for 4.9 is because i expect the patch to enter ipipe in
ipipe-4.9.y and be backported into 4.4.y. And naturally become part of
4.14, wich will be released later.

Henning

Am Mon, 27 Aug 2018 15:33:46 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> After applying this one patch, one can merge in a newer minor release
> of 4.9. v4.9.109 switched to eager-only and blocked us from moving
> beyond this release.
> A tree that contains the patch and a sample-merge can be found here:
> https://github.com/henning-schild-work/linux-ipipe/tree/henning/fpu/4.9
>
> Henning Schild (1):
>   x86: make fpu switching eager
> 
>  arch/x86/include/asm/fpu/internal.h | 30
> ++++++++---------------------- arch/x86/include/asm/fpu/types.h    |
> 12 ------------ arch/x86/kernel/fpu/core.c          | 23
> +++++++++-------------- arch/x86/kernel/fpu/init.c          |  5 +----
>  4 files changed, 18 insertions(+), 52 deletions(-)
> 


