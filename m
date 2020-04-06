MIME-Version: 1.0
References: <CAAvDm6bLF29EmmZHhraskjapoTwM36RL9=caaQFosQ4doOR1cQ@mail.gmail.com>
 <8dd80eb2-cb93-c48b-2012-cb2b91ed672d@siemens.com>
In-Reply-To: <8dd80eb2-cb93-c48b-2012-cb2b91ed672d@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Mon, 6 Apr 2020 16:50:44 +0800
Message-ID: <CAAvDm6YUoFtwUEUNRMpUsfV_e2UQfSdkSOSWy--m=+k+apgYig@mail.gmail.com>
Subject: Re: question about the calculation of overload bytes in function
 add_extent()
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

>
> Thanks a lot for your replay.
> I am sorry for the bad experience in reading my last letter.
> I rewrite the letter below.
>
> The question i met is when i enabled --enable-pshared  option in compilin=
g
>  the xenomai-v3.1.
>
> In the source code https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/lib=
/
> boilerplate/heapmem.c  line:607,notes that"overhead memory we need for
> storing our metadata as calculated by HEAPMEM_ARENA_SIZE()".
>
> To simplify the problem=EF=BC=8CI ignore the alignment.
> Since the HEAPMEM_ARENA_SIZE macro in code, we can draw the conclusion
> HEAPMEM_ARENA_SIZE(size)=3D__size+sizeof(struct heapmem_extent)+
> (__size/HEAPMEM_PAGE_SIZE)*HEAPMEM_PGMAP_BYTES
>
> So, the overhead i think is=EF=BC=9A
> overhead =3D HEAPMEM_ARENA_SIZE(size)-size =3D sizeof(struct heapmem_exte=
nt)+
> (__size/HEAPMEM_PAGE_SIZE)*HEAPMEM_PGMAP_BYTES
>
> Note: "__size/HEAPMEM_PAGE_SIZE" equals to
>  "__size>> HEAPMEM_PAGE_SHIFT"(which is the orignal code)
>
> If i use the representation explained in the source code(see heapmem.c,th=
e
> representation is listed below), then
>  overhead =3D o =3D e+(a*p)/m
>  It's not equals to the calculation in the source(see heapmem.c,url list
>  above), which is
>           o =3D ((a * m + e * p) / (p + m))
>
>  @representation explained in source code(the whole source code is listed
>  below)
>    * o =3D overhead
>    * e =3D sizeof(heapmem_extent)
>    * p =3D HEAPMEM_PAGE_SIZE
>    * m =3D HEAPMEM_PGMAP_BYTES  =3Dsizeof(struct heapmem_pgentry)
>
>
> @source code of macro HEAPMEM_ARENA_SIZE
> @see https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/include/
> boilerplate/heapmem.h line: 95-110
> #define __HEAPMEM_MAP_SIZE(__nrpages) \
> ((__nrpages) * HEAPMEM_PGMAP_BYTES)
> /*note by myslef :(__size)>>HEAPMEM_PAGE_SHIFT is the number of pages of
> memory pool
>  __HEAPMEM_MAP_SIZE((__size) >> HEAPMEM_PAGE_SHIFT)calculats the memory
> size
>  for storing the struct of heapmem_pgentry=E3=80=82*/
>  #define __HEAPMEM_ARENA_SIZE(__size) \
>  (__size + \
>    __align_to(sizeof(struct heapmem_extent) + \
>       __HEAPMEM_MAP_SIZE((__size) >> HEAPMEM_PAGE_SHIFT), \
>       HEAPMEM_MIN_ALIGN))
>  /*
>  * Calculate the minimal size of the memory arena needed to contain a
>  * heap of __user_size bytes, including our meta data for managing it.
>  * Usable at build time if __user_size is constant.
>  */
> #define HEAPMEM_ARENA_SIZE(__user_size)                 \
>     __HEAPMEM_ARENA_SIZE(__align_to(__user_size, HEAPMEM_PAGE_SIZE))
>
>
>
