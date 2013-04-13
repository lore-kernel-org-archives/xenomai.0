Message-ID: <516983AF.2000909@xenomai.org>
Date: Sat, 13 Apr 2013 18:11:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1U2RE9-0007Zc-Em@xenomai.org>
In-Reply-To: <E1U2RE9-0007Zc-Em@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : switchtest: Add SSE and
	AVX check
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 02/04/2013 07:57 PM, GIT version control wrote:

> Module: xenomai-2.6
> Branch: master
> Commit: 192597326a0becd1980cb6c5cc9395af18a19c60
> URL:    http://git.xenomai.org/?p=xenomai-2.6.git;a=commit;h=192597326a0becd1980cb6c5cc9395af18a19c60
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Tue Jan 29 18:46:13 2013 +0100
> 
> switchtest: Add SSE and AVX check
> 
> Add a test for switching the lower SSE registers xmm0..7 or AVX
> registers ymm0..7, provided the CPU supports the corresponding
> feature. As xmm and ymm share their storage, we only need to check
> one of the features.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> ---


>  static inline unsigned fp_regs_check(unsigned val)
>  {
>  	unsigned i, result = val;
> +	uint64_t vec[8][4];
>  	unsigned e[8];
>  
>  	for (i = 0; i < 8; i++)
>  		__asm__ __volatile__("fistpl %0":"=m"(e[7 - i]));
> +	if (fp_features & FP_FEATURE_AVX) {
> +		__asm__ __volatile__(
> +			"vmovupd %%ymm0,%0;"
> +			"vmovupd %%ymm1,%1;"
> +			"vmovupd %%ymm2,%2;"
> +			"vmovupd %%ymm3,%3;"
> +			"vmovupd %%ymm4,%4;"
> +			"vmovupd %%ymm5,%5;"
> +			"vmovupd %%ymm6,%6;"
> +			"vmovupd %%ymm7,%7;"
> +			:
> +			: "m" (vec[0][0]), "m" (vec[1][0]),
> +			  "m" (vec[2][0]), "m" (vec[3][0]),
> +			  "m" (vec[4][0]), "m" (vec[5][0]),
> +			  "m" (vec[6][0]), "m" (vec[7][0]));
> +	} else if (fp_features & FP_FEATURE_SSE) {
> +		__asm__ __volatile__(
> +			"movupd %%xmm0,%0;"
> +			"movupd %%xmm1,%1;"
> +			"movupd %%xmm2,%2;"
> +			"movupd %%xmm3,%3;"
> +			"movupd %%xmm4,%4;"
> +			"movupd %%xmm5,%5;"
> +			"movupd %%xmm6,%6;"
> +			"movupd %%xmm7,%7;"
> +			:
> +			: "m" (vec[0][0]), "m" (vec[1][0]),
> +			  "m" (vec[2][0]), "m" (vec[3][0]),
> +			  "m" (vec[4][0]), "m" (vec[5][0]),
> +			  "m" (vec[6][0]), "m" (vec[7][0]));
> +	}
>  
>  	for (i = 0; i < 8; i++)
>  		if (e[i] != val) {
> @@ -65,8 +148,33 @@ static inline unsigned fp_regs_check(unsigned val)
>  			result = e[i];
>  		}
>  
> +	if (fp_features & FP_FEATURE_AVX) {
> +		for (i = 0; i < 8; i++) {
> +			int error = 0;
> +			if (vec[i][0] != val) {
> +				result = vec[i][0];
> +				error = 1;
> +			}
> +			if (vec[i][2] != val) {
> +				result = vec[i][2];
> +				error = 1;
> +			}
> +			if (error)
> +				printk("ymm%d: %llu/%llu != %u/%u\n",
> +				       i, (unsigned long long)vec[i][0],
> +				       (unsigned long long)vec[i][2],
> +				       val, val);
> +		}
> +	} else if (fp_features & FP_FEATURE_SSE) {
> +		for (i = 0; i < 8; i++)
> +			if (vec[i][0] != val) {
> +				printk("xmm%d: %llu != %u\n",
> +				       i, (unsigned long long)vec[i][0], val);
> +				result = vec[i][0];
> +			}
> +	}
> +
>  	return result;
>  }


This routine causes a warning from gcc and looks indeed wrong: if the
"vec" variable is used as an output variable of the inline assembly, it
should be in the output section of the inline assembly, not the input
section.

-- 
                                                                Gilles.

