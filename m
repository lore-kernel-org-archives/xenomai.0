References: <52bd261d-07c2-80d1-77f4-fb501795dea7@frank-benkert.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cd4214b0-078b-f02b-66c1-f81c4b078ac4@xenomai.org>
Date: Tue, 27 Mar 2018 13:01:43 +0200
MIME-Version: 1.0
In-Reply-To: <52bd261d-07c2-80d1-77f4-fb501795dea7@frank-benkert.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Regression posix/mprotect failed on Xenomai 2.6.5 on
 powerpc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frank Benkert <xenomai@frank-benkert.de>, xenomai@xenomai.org

On 03/27/2018 09:59 AM, Frank Benkert wrote:
> Hello,
> 
> we have to maintain an old productive system.
> It's based on a powerpc MPC5200.
> After updating Xenomai from 2.6.1 to 2.6.5 the Xenomai regression test
> suite failed on posix/mprotect:
> 
> + /usr/bin/regression/posix/mprotect
> memory read
> memory write after exec enable
> memory write after write enable
> memory read/write after access enable
> FAILURE main:102: read zero returned 255 instead of 0
> 
This does not look good given how trivial the failing test is. I can't
tell for kernel 3.5.x, and I won't try it because this would require to
downgrade to a legacy ppc toolchain for building such an old kernel,
which would require more time than I can invest in this case.

Luckily, I still have an ancient 3.10.32 kernel image in my tftpboot
area for some ppc52xx (*), which I tried: it does not exhibit the issue
with a stock Xenomai 2.6.5 release.

(*) Hw is a venerable motorola Icecube, but I would assume that any 6xx
core would do just as well:

CPU:   MPC5200 v1.0, Core v1.1 at 396 MHz

-- 
Philippe.

