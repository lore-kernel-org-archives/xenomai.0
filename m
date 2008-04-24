Message-ID: <2ff1a98a0804240537h1b36c30cj8521cbbe1b5c87ef@domain.hid>
Date: Thu, 24 Apr 2008 14:37:23 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD38250@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <0B45E93C5FF65740AEAE690BF3848B7AD38250@domain.hid>
Subject: Re: [Xenomai-core] [1/9] Support for non cached memory mappings
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Apr 24, 2008 at 2:01 PM, Fillod Stephane
<stephane.fillod@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
>  > This patch adds architecture independent support for non cached memory
>  > mappings. This is necessary on ARM architecture with VIVT cache to
>  share a
>  >mapping between kernel and user-space, but may be used in other
>  situations
>  > (who knows).
>
>  So, the difference between H_DMA and H_NONCACHED would be that
>  H_NONCACHED
>  may not be physically contiguous, while H_DMA (that is physically
>  contiguous)
>  may still be cached on cache coherent systems. Is that correct?

The memory allocated with kmalloc is mapped at boot time, and mapped
with cache enabled, so if we want to get non cached memory, we have to
remap it with vmalloc. So yes, it will probably not be contiguous.

>  PS: any plan on a H_HUGETLB one of those days?

What would this do ?

-- 
 Gilles

