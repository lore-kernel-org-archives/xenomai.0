MIME-Version: 1.0
In-Reply-To: <1393935764.2258.YahooMailNeo@web163903.mail.gq1.yahoo.com>
References: <1393935764.2258.YahooMailNeo@web163903.mail.gq1.yahoo.com>
Date: Tue, 4 Mar 2014 13:07:59 +0000
Message-ID: <CAEbDrgnFcZb3iO0mU_-7Up9OfjtcryDwU_LA3xNpOHj11K661A@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] compiling kernel after xenomai-patch ends in error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

had the same issue before. The solution is to disable remote kernel
debugging (kernel hacking menu)



On 4 March 2014 12:22, Huub Van Niekerk <huubvanniekerk@yahoo.com> wrote:

> Hi,
>
> I just patched vanilla kernel 3.10.18 with ipipe-core-3.10.18-arm-1 and
> get these errors:
>
> kernel/ipipe/core.c: In function 'ipipe_probe_kernel_read':
> kernel/ipipe/core.c:1742:2: error: implicit declaration of function
> 'get_fs' [-Werror=implicit-function-declaration]
> kernel/ipipe/core.c:1744:2: error: implicit declaration of function
> 'set_fs' [-Werror=implicit-function-declaration]
> kernel/ipipe/core.c:1744:9: error: 'KERNEL_DS' undeclared (first use in
> this function)
> kernel/ipipe/core.c:1744:9: note: each undeclared identifier is reported
> only once for each function it appears in
> kernel/ipipe/core.c:1747:2: error: implicit declaration of function
> '__copy_from_user_inatomic' [-Werror=implicit-function-declaration]
> kernel/ipipe/core.c: In function 'ipipe_probe_kernel_write':
> kernel/ipipe/core.c:1761:9: error: 'KERNEL_DS' undeclared (first use in
> this function)
> kernel/ipipe/core.c:1764:2: error: implicit declaration of function
> '__copy_to_user_inatomic' [-Werror=implicit-function-declaration]
>
> With previous kernel 3.2 I got warning and errors before saving the
> kernel, now I didn't. Looking on the net for these errors, I find some
> postings, but none related to ipipe. Any ideas?
>
> Thanks.
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
