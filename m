Message-ID: <4FF13B93.1040302@logilin.fr>
Date: Mon, 02 Jul 2012 08:11:30 +0159
From: Christophe Blaess <mailist@logilin.fr>
MIME-Version: 1.0
References: <CAKKWdte1Yg5fEUN=jqVgyTkRTHwY62WrMdw99ZgqOZZdAnAm+w@mail.gmail.com>	<4FEED882.9070307@xenomai.org>	<4FEF2EB1.3050600@logilin.fr>
	<4FEF31AC.2000403@xenomai.org> <4FF09E30.5050400@logilin.fr>
	<4FF0A625.7070408@xenomai.org>
In-Reply-To: <4FF0A625.7070408@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: XENO_OPT_TIMING_SCHEDLAT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 01/07/2012 21:33, Gilles Chanteperdrix wrote:
> It looks like a buffer overflow with a buffer on stack. Please try the
> following patch:
>
> diff --git a/ksrc/nucleus/vfile.c b/ksrc/nucleus/vfile.c
> index 5928aef..a6ad363 100644
> --- a/ksrc/nucleus/vfile.c
> +++ b/ksrc/nucleus/vfile.c
> @@ -811,7 +811,7 @@ ssize_t xnvfile_get_blob(struct xnvfile_input *input,
>   {
>          ssize_t nbytes = input->size;
>
> -       if (nbytes < size)
> +       if (nbytes > size)
>                  nbytes = size;
>
>          if (nbytes > 0 && copy_from_user(data, input->u_buf, nbytes))
> @@ -904,7 +904,7 @@ ssize_t xnvfile_get_integer(struct xnvfile_input
> *input, long *valp)
>          ssize_t nbytes;
>          long val;
>
> -       nbytes = xnvfile_get_blob(input, buf, sizeof(buf));
> +       nbytes = xnvfile_get_blob(input, buf, sizeof(buf) - 1);
>          if (nbytes < 0)
>                  return nbytes;
>

The patch is ok, I do not have any segfault.

But, there's still something weird (I run on a stock xenomai 2.6.0 with 
adeos-ipipe-2.6.38.8-arm-1.18-04.patch, I'll try on a 2.6 git kernel)

[Panda]#*echo 2388 > /proc/xenomai/latency*
[Panda]#*cat /proc/xenomai/latency*
2386
[Panda]#*echo 2386 > /proc/xenomai/latency*
[Panda]#*cat /proc/xenomai/latency*
2384
[Panda]#*echo 2384 > /proc/xenomai/latency*
[Panda]#*cat /proc/xenomai/latency*
2382
[Panda]#

I suspect something wrong in xnarch_tsc_to_ns()/xnarch_ns_to_tsc() maybe 
in xnarch_llimd(). I'll investigate more this afternoon.



