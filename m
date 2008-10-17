Message-ID: <48F8C03C.6060202@domain.hid>
Date: Fri, 17 Oct 2008 18:41:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081017154559.420723261@domain.hid>
In-Reply-To: <20081017154559.420723261@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 00/13] Generic fast xnsynch support & more
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Hopefully the last round, addressing remarks brought up on the last
> posting. The changes are:
> 
> [Patches 7-9]
>  - define xnsynch_owner_check as xnsynch-implementation-independent way
>    to check provided and current synch owner match (reduces #ifdefs)
> 
> [Patches 6 and 9]
>  - push lockcnt changes to native mutexes into separate patch (patch
> 
> [Patch 2]
>  - switch creation of xeno_current_key etc. from pthread_once to a
>    constructor
>  - translate pthread_getspecific == NULL into XN_NO_HANDLE
>    (funnily, this shrinks the code on x86-64)
> 
> [Patch 13]
>  - detect SMP feature inconsistency between kernel and userland
>    (but keep SMP off by default for now)
> 
> Note that this series (as well as the latter) depends on the VRTX fix of
> Philippe which is not yet merged into SVN trunk.
> 
> Jan
> 
> PS: Hope this series is compatible with more mail clients /wrt
> commenting on the inlined patches.

Ok. Let's be done with it. I am ok with the whole stack.

-- 
                                                 Gilles.

