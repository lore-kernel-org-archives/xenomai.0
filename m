Subject: Re: question about the calculation of overload bytes in function
 add_extent()
References: <CAAvDm6bLF29EmmZHhraskjapoTwM36RL9=caaQFosQ4doOR1cQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8dd80eb2-cb93-c48b-2012-cb2b91ed672d@siemens.com>
Date: Mon, 6 Apr 2020 09:38:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6bLF29EmmZHhraskjapoTwM36RL9=caaQFosQ4doOR1cQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 05.04.20 10:06, 孙世龙 via Xenomai wrote:
> Question about the calculation of overload memory in function add_extent()
> in heapmem.c line:607(the source is listed below)

Please use a plaintext email client that allows to format your messages 
better. The cited code is heavily mangled and almost unreadable. Or add 
a link to the code on gitlab, which also document which revision you are 
referring to.

> In the source code, notes that"overhead memory we need for storing our meta
> data as calculated by HEAPMEM_ARENA_SIZE()".(The source of
> HEAPMEM_ARENA_SIZE macro is also listed below.)
> @@To simplify the problem，we ignore the alignment.@@
>  From the HEAPMEM_ARENA_SIZE macro in code, we can draw the conclusion
> HEAPMEM_ARENA_SIZE(size)=__size+sizeof(struct
> heapmem_extent)+(__size/HEAPMEM_PAGE_SIZE)*HEAPMEM_PGMAP_BYTES
> So, the overhead i think is：
> overhead = HEAPMEM_ARENA_SIZE(size)-size = sizeof(struct
> heapmem_extent)+(__size/HEAPMEM_PAGE_SIZE)*HEAPMEM_PGMAP_BYTES
> If we use the representation explained in the source code, then
> overhead = o = e+(a*p)/m
> It's not equals to the calculation in the source, which is
>          o = ((a * m + e * p) / (p + m))
> 

Thanks for pointing out!

Philippe, can you comment on this?

Jan

> @representation explained in source code(the whole source code is listed
> below)
>   * o = overhead
>   * e = sizeof(heapmem_extent)
>   * p = HEAPMEM_PAGE_SIZE
>   * m = HEAPMEM_PGMAP_BYTES  =sizeof(struct heapmem_pgentry)
> 
> 
> 
> Note: "__size/HEAPMEM_PAGE_SIZE" equals to "__size>>
> HEAPMEM_PAGE_SHIFT"(which is the orignal code)
> 
> 
> @source code of macro HEAPMEM_ARENA_SIZE
> #define __HEAPMEM_MAP_SIZE(__nrpages) \
> ((__nrpages) * HEAPMEM_PGMAP_BYTES)
> /*note by myslef :(__size)>>HEAPMEM_PAGE_SHIFT is the number of pages of
> memory pool
> __HEAPMEM_MAP_SIZE((__size) >> HEAPMEM_PAGE_SHIFT)calculats the memory size
> for storing the struct of heapmem_pgentry。*/
> #define __HEAPMEM_ARENA_SIZE(__size) \
> (__size + \
>   __align_to(sizeof(struct heapmem_extent) + \
>      __HEAPMEM_MAP_SIZE((__size) >> HEAPMEM_PAGE_SHIFT), \
>      HEAPMEM_MIN_ALIGN))
> 
> /*
>   * Calculate the minimal size of the memory arena needed to contain a
>   * heap of __user_size bytes, including our meta data for managing it.
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

