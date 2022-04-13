Message-ID: <79baf069-8bf8-ef6d-1eff-15ba2c702ba8@siemens.com>
Date: Wed, 13 Apr 2022 13:23:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] configure.ac: Enable SMP by default
Content-Language: en-US
References: <20220408085909.26395-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220408085909.26395-1-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 08.04.22 10:59, Richard Weinberger via Xenomai wrote:
> In 2022 it is hard to find ARM or x86 systems without SMP.
> Other CPU architectures are no longer supported by Xenomai.
> So, make SMP support opt-out.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  configure.ac | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 019453793..867fc4636 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -385,12 +385,9 @@ if test x$use_registry = xy; then
>  fi
>  AM_CONDITIONAL(XENO_REGISTRY,[test x$use_registry = xy])
>  
> -dnl SMP support (default: on for cobalt/x86, off otherwise)
> +dnl SMP support (default: on)
>  
> -CONFIG_SMP=
> -if test $target_cpu_arch = x86 -a $rtcore_type = cobalt; then
> -	CONFIG_SMP=y
> -fi
> +CONFIG_SMP=y
>  AC_MSG_CHECKING(for SMP support)
>  AC_ARG_ENABLE(smp,
>  	AS_HELP_STRING([--enable-smp], [Enable SMP support]),

Thanks, applied.

We could now drop the explicit --enable-smp from debian/rules as well,
but that's nothing urgent.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

