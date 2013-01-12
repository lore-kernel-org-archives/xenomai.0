Message-ID: <50F1B329.80303@xenomai.org>
Date: Sat, 12 Jan 2013 20:02:01 +0100
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


Try disabling transparent hugepages, as noted by Jan.

> 
> 2)  posix/mprotect is failing:  "FAILURE: sigdebug_handler triggered,
> reason 2    memory write after exec enable".
> 
> 3)  FPU warning:  "fptest.h:24: Warning: Linux is compiled to use FPU in
> kernel-space.    For this reason, switchtest can not test using FPU in
> Linux kernel-space."
> 
> Regression test run log:
> http://www.zultron.com/static/2013/01/xenomai/foo-xeno-regression-test.log


You should normally use the -l option to use a non default "load", and
run the test for a long time.

See xeno-regression-test --help and dohell --help


-- 
                                                                Gilles.

