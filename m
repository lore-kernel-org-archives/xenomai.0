Date: Mon, 6 Apr 2015 16:14:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150406141434.GA1450@hermes.click-hack.org>
References: <CAKKWdtdUN=FxONoqC5qMdJZPQjFFeosehRdLnY-b1jq_msU02Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKKWdtdUN=FxONoqC5qMdJZPQjFFeosehRdLnY-b1jq_msU02Q@mail.gmail.com>
Subject: Re: [Xenomai] why there are errors compiling the kernel, 3.16.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: buildroot@buildroot.net, xenomai <xenomai@xenomai.org>

On Mon, Apr 06, 2015 at 06:27:39PM +0430, ali hagigat wrote:
> linux-3.16.7.tar.xz
> ipipe-core-3.16.7-arm-5.patch  + xenomai user space applications and libraries
> target-board: wandboard-quad
> 
> 
>   CHK     include/generated/compile.h
>   CC      arch/arm/xenomai/hal.o
>   CC      net/socket.o
>   AS      arch/arm/xenomai/switch.o
> arch/arm/xenomai/hal.c:47:24: fatal error: asm/system.h: No such file
> or directory
>  #include <asm/system.h>

See this thread from last month:
https://xenomai.org/pipermail/xenomai/2015-March/033641.html

One way to learn about a free software project is to not only
subscribe to the project mailing list to send questions, but to also
actually read the messages you receive.

-- 
					    Gilles.

