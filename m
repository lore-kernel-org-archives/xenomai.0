Message-ID: <50F19DE4.4030805@xenomai.org>
Date: Sat, 12 Jan 2013 18:31:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com>
In-Reply-To: <50F19CE1.5080106@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel OOPS during regression tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/12/2013 06:26 PM, John Morris wrote:

> Hi list,
> 
> The el6 packages are coming along nicely:
> 
> https://github.com/zultron/kernel-ml/tree/branch3.5.3-xeno

>

> Still a few problems when running xeno-regression-test.
> 
> 1)  Most worrisome is "kernel BUG at mm/mmap.c:2313!   invalid opcode:
> 0000 [#2] SMP".  Is this related to HEAPSZ or STACKPOOLSZ?  My mind is
> getting foggy about all the things I've seen, but it seems like it was
> happening earlier in the tests until these config values were quadrupled.


Could you check whether you can reproduce this issue with the I-pipe
patch for 3.5.7 ? The next xenomai release will be based on this version
on x86 anyway. Branch for-core-3.5.7 in ipipe-gch.git

> 
> 2)  posix/mprotect is failing:  "FAILURE: sigdebug_handler triggered,
> reason 2    memory write after exec enable".


I guess you need Jan's fixes.

> 
> 3)  FPU warning:  "fptest.h:24: Warning: Linux is compiled to use FPU in
> kernel-space.    For this reason, switchtest can not test using FPU in
> Linux kernel-space."


Well, the warning says it all.

-- 
                                                                Gilles.

