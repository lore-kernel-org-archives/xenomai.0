MIME-Version: 1.0
References: <20220413120509.5637-1-richard@nod.at>
In-Reply-To: <20220413120509.5637-1-richard@nod.at>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 5 May 2022 22:06:32 +0200
Message-ID: <CAFLxGvwT2cgn8vRF4HzFuJd1BvjHMueMPc4Cq3+LxNoZ3QDd7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] debian: Remove --enable-smp
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: Xenomai <xenomai@xenomai.org>

ping? :-)

On Wed, Apr 13, 2022 at 2:05 PM Richard Weinberger via Xenomai
<xenomai@xenomai.org> wrote:
>
> SMP is now enabled by default for all architectures.
> No need to use --enable-smp anymore.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  debian/rules | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/debian/rules b/debian/rules
> index 3fe6bece93c9..60094734630d 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -17,7 +17,6 @@ CONFIG_OPTS = --prefix=/usr \
>              --includedir=/usr/include/xenomai \
>              --mandir=/usr/share/man \
>              --with-testdir=/usr/lib/xenomai/testsuite \
> -            --enable-smp \
>              --enable-lazy-setsched \
>              --enable-debug=symbols \
>              --enable-dlopen-libs
> --
> 2.26.2
>
>


-- 
Thanks,
//richard

