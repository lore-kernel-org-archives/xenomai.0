Message-ID: <2ff1a98a0804240753s5380fc98qd20e2ecd26f938c9@domain.hid>
Date: Thu, 24 Apr 2008 16:53:26 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD38251@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <0B45E93C5FF65740AEAE690BF3848B7AD38251@domain.hid>
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

On Thu, Apr 24, 2008 at 3:47 PM, Fillod Stephane
<stephane.fillod@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
>  >>  PS: any plan on a H_HUGETLB one of those days?
>  >
>  >What would this do ?
>
>  Some embedded platforms have small TLB compared to the vm hungriness of
>  certain real-time tasks. H_HUGETLB would reply on HugeTLB[1] backing for
>  allocation. Scattered accesses to this memory would benefit in the lower
>  pressure of minor page-faults/TLB refills, which is a good thing(tm) for
>  real-time.

I do not understand the need for a kernel option and a special
filesystem, why does not the kernel use these hugetlb pages upon large
allocations ?


-- 
 Gilles

