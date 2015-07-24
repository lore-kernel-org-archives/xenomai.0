Message-ID: <5515ffa50f7d05764c02821440947bc5.squirrel@sourcetrek.com>
In-Reply-To: <E1ZIZjP-0001py-FB@sd-51317.xenomai.org>
References: <E1ZIZjP-0001py-FB@sd-51317.xenomai.org>
Date: Fri, 24 Jul 2015 15:20:22 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : boilerplate: add
 offsetof() shorthand
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


git repository hosting wrote:
> Module: xenomai-3
> Branch: next
> Commit: 2a584d6763c64f9e566b5f53094d57dd72688857
> URL:
> http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=2a584d6763c64f9e566b5f53094d57dd72688857
>
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Thu Jul 23 19:13:29 2015 +0200
>
> boilerplate: add offsetof() shorthand
>
> ---
>
>  include/boilerplate/compiler.h |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/boilerplate/compiler.h
> b/include/boilerplate/compiler.h
> index e27d165..876e004 100644
> --- a/include/boilerplate/compiler.h
> +++ b/include/boilerplate/compiler.h
> @@ -54,4 +54,8 @@
>  #define __aligned(__n)	__attribute__((aligned (__n)))
>  #endif
>
> +#ifndef offsetof
> +#define offsetof(__type, __member)  __builtin_offsetof(__type, __member)
> +#endif

offsetof should be defined by glibc headers. By adding a definition, you
risk a compiler warning about multiple definitions if someone uses the
proper glibc header.


-- 
                                            Gilles.
https://click-hack.org


