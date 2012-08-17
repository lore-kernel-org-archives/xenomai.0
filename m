Message-ID: <502E8CA9.7020401@xenomai.org>
Date: Fri, 17 Aug 2012 20:25:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <502D040F.2010906@axesseurope.com>	<20120816144617.GD1237@csclub.uwaterloo.ca>
	<502E541F.7090801@axesseurope.com>
In-Reply-To: <502E541F.7090801@axesseurope.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Trying to get Xenomai on P1010RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Retailleau <charles.retailleau@axesseurope.com>
Cc: xenomai@xenomai.org

On 08/17/2012 04:24 PM, Charles Retailleau wrote:

> Thanks Lennart that was very useful, it now works.
> Here is the little patch I made, yet I couldn't find a switch to force
> it for core e500/e500xx only...
> 
> 
> --- ./xenomai-2.6.1.orig/include/asm-powerpc/syscall.h	2011-11-09
> 13:21:36.000000000 +0100
> +++ ./xenomai-2.6.1.mine/./include/asm-powerpc/syscall.h	2012-08-17
> 15:47:28.387435909 +0200
> @@ -167,9 +167,9 @@
>  	} u;
>  	unsigned long __tbu;
> 
> -	__asm__ __volatile__("1: mftbu %0\n"
> -			     "mftb %1\n"
> -			     "mftbu %2\n"
> +	__asm__ __volatile__("1: mfspr %0,269\n"
> +			     "mfspr %1,268\n"
> +			     "mfspr %2,269\n"
>  			     "cmpw %2,%0\n"
>  			     "bne- 1b\n":"=r"(u.v[0]),
>  			     "=r"(u.v[1]), "=r"(__tbu));
> Thanks to all for your help
> Charles,


Merged. Thanks.

-- 
                                                                Gilles.

