Subject: Re: include/boilerplate/compiler.h breaks clang 3.9's arm_acle.h
References: <VI1PR0701MB21264AF72FDA99A8694C2E6AB5DE0@VI1PR0701MB2126.eurprd07.prod.outlook.com>
 <d0e4aced-93eb-1e3c-ed39-7b406df3ee53@siemens.com>
 <VI1PR0701MB2126E2FCB190BCE61C77329CB5D80@VI1PR0701MB2126.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4e92ca74-5fb1-ecc0-a679-103410b1727d@xenomai.org>
Date: Mon, 19 Nov 2018 13:05:08 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR0701MB2126E2FCB190BCE61C77329CB5D80@VI1PR0701MB2126.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/19/18 12:59 PM, Giulio Moro via Xenomai wrote:
> right, digging deeper into the issue, ARM says that if the __ARM_ACLE macro is defined by the compiler, then it's safer to include `arm_acle.h`, which will define __clz() as a function, so a better approach could be perhaps:
> 
> #ifdef __ARM_ACLE
> #include <arm_acle.h>
> #else
> #define __clz(__v)    \
>       // .... currently defined code
> #endif
> 
> Happy to prepare a patch for the above. On the other hand, I am not sure what the current purpose of this definition of __clz() in a public header file is: 
> 
> $ grep -RI __clz .
> ./lib/copperplate/heapobj-pshared.c:		log2size = sizeof(size) * 8 - 1 - __clz(size);
> ./include/boilerplate/compiler.h:#define __clz(__v)
> 
> so it's used only in lib/copperplate/heapobj-pshared.c (similarly for __ctz()) . Even if they was used in multiple places, why should they be defined in a public header, risking to cause issues when user code includes stdlib.h?
> 
> It seems to me that we can safely remove 
> #include <boilerplate/compiler.h>
> 
> from include/cobalt/wrappers.h in order to fix the above issue for the Cobalt API. Possibly something similar can be done for the other APIs?
> 
> Giulio
> 
> 

Why not solving the namespace clash the simplest way by renaming the
offending stuff in boilerplate/compiler.h? __clz and friends are
definitely not part of the public interface, so you only have to care
about in-tree users. __clz could be renamed as count_leading_zeroes()
without affecting the API.

-- 
Philippe.

