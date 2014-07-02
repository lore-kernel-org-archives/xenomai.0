Message-ID: <53B44431.2050401@xenomai.org>
Date: Wed, 02 Jul 2014 19:41:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53A3FAB0.4050100@axelsw.it> <53A4207F.9040801@xenomai.org>
 <53A9AA38.3090005@axelsw.it> <53A9B0FB.1070809@xenomai.org>
 <53AA7F39.90706@axelsw.it> <53AA8AC3.7020100@xenomai.org>
 <53B434F4.6060203@axelsw.it>
In-Reply-To: <53B434F4.6060203@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel freezes in __ipipe_sync_stage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Tessore <marco.tessore@axelsw.it>, Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 07/02/2014 06:36 PM, Marco Tessore wrote:
> ipipe_mach_allow_hwtimer_uaccess(MX25_AIPS1_BASE_ADDR_VIRT,MX25_AIPS2_BASE_ADDR_VIRT);
>      return 0;
> }
> 
> postcore_initcall(post_cpu_init);
> #endif /* CONFIG_IPIPE */
> 
> 
> the question that I kindly ask is: what should do the function 
> ipipe_mach_allow_hwtimer_uaccess?

As the name suggests, this function allows access to the hardware timer
registers from user-space. Xenomai user-space libraries require this,
unless you compile xenomai with --disable-arm-tsc, but this will
increase (greatly) the latency of services such as rt_timer_tsc or
clock_gettime(CLOCK_MONOTONIC) by requiring a system call.

And it probably has nothing to do with your problem.


-- 
                                                                Gilles.

