Subject: Re: [PATCH] boilerplate/avl: fix NULL link representation in pshared
 mode
References: <20191026100424.30908-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9388db5c-75f1-c4fa-7b75-cd1c7ea8d08a@siemens.com>
Date: Sun, 27 Oct 2019 14:31:19 +0100
MIME-Version: 1.0
In-Reply-To: <20191026100424.30908-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 26.10.19 12:04, Philippe Gerum via Xenomai wrote:
> Detect and store NULL links as zero offsets into the shared AVL
> tree. Otherwise, non-constant offsets may be generated for
> representing a NULL link, depending on the process-specific start
> address of the pshared AVL tree in memory as obtained from a memory
> mapping.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  include/boilerplate/avl-inner.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/boilerplate/avl-inner.h b/include/boilerplate/avl-inner.h
> index 10c91140c..8e4de8487 100644
> --- a/include/boilerplate/avl-inner.h
> +++ b/include/boilerplate/avl-inner.h
> @@ -104,26 +104,30 @@ static inline struct shavlh *
>  shavlh_link(const struct shavl *const avl,
>  	    const struct shavlh *const holder, unsigned int dir)
>  {
> -	return (void *)avl + holder->link[avl_type2index(dir)].offset;
> +	ptrdiff_t offset = holder->link[avl_type2index(dir)].offset;
> +	return offset ? (void *)avl + offset : NULL;
>  }
>  
>  static inline void
>  shavlh_set_link(struct shavl *const avl, struct shavlh *lhs,
>  		int dir, struct shavlh *rhs)
>  {
> -	lhs->link[avl_type2index(dir)].offset = (void *)rhs - (void *)avl;
> +	ptrdiff_t offset = rhs ? (void *)rhs - (void *)avl : 0;
> +	lhs->link[avl_type2index(dir)].offset = offset;
>  }
>  
>  static inline
>  struct shavlh *shavl_end(const struct shavl *const avl, int dir)
>  {
> -	return (void *)avl + avl->end[avl_type2index(dir)].offset;
> +	ptrdiff_t offset = avl->end[avl_type2index(dir)].offset;
> +	return offset ? (void *)avl + offset : NULL;
>  }
>  
>  static inline void
>  shavl_set_end(struct shavl *const avl, int dir, struct shavlh *holder)
>  {
> -	avl->end[avl_type2index(dir)].offset = (void *)holder - (void *)avl;
> +	ptrdiff_t offset = holder ? (void *)holder - (void *)avl : 0;
> +	avl->end[avl_type2index(dir)].offset = offset;
>  }
>  
>  #define shavl_count(avl)	((avl)->count)
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

