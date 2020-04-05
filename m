MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Sun, 5 Apr 2020 16:06:38 +0800
Message-ID: <CAAvDm6bLF29EmmZHhraskjapoTwM36RL9=caaQFosQ4doOR1cQ@mail.gmail.com>
Subject: question about the calculation of overload bytes in function
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
To: xenomai-git@xenomai.org, xenomai@xenomai.org

Question about the calculation of overload memory in function add_extent()
in heapmem.c line:607(the source is listed below)
In the source code, notes that"overhead memory we need for storing our meta
data as calculated by HEAPMEM_ARENA_SIZE()".(The source of
HEAPMEM_ARENA_SIZE macro is also listed below.)
@@To simplify the problem=EF=BC=8Cwe ignore the alignment.@@
>From the HEAPMEM_ARENA_SIZE macro in code, we can draw the conclusion
HEAPMEM_ARENA_SIZE(size)=3D__size+sizeof(struct
heapmem_extent)+(__size/HEAPMEM_PAGE_SIZE)*HEAPMEM_PGMAP_BYTES
So, the overhead i think is=EF=BC=9A
overhead =3D HEAPMEM_ARENA_SIZE(size)-size =3D sizeof(struct
heapmem_extent)+(__size/HEAPMEM_PAGE_SIZE)*HEAPMEM_PGMAP_BYTES
If we use the representation explained in the source code, then
overhead =3D o =3D e+(a*p)/m
It's not equals to the calculation in the source, which is
        o =3D ((a * m + e * p) / (p + m))

@representation explained in source code(the whole source code is listed
below)
 * o =3D overhead
 * e =3D sizeof(heapmem_extent)
 * p =3D HEAPMEM_PAGE_SIZE
 * m =3D HEAPMEM_PGMAP_BYTES  =3Dsizeof(struct heapmem_pgentry)



Note: "__size/HEAPMEM_PAGE_SIZE" equals to "__size>>
HEAPMEM_PAGE_SHIFT"(which is the orignal code)


@source code of macro HEAPMEM_ARENA_SIZE
#define __HEAPMEM_MAP_SIZE(__nrpages) \
((__nrpages) * HEAPMEM_PGMAP_BYTES)
/*note by myslef :(__size)>>HEAPMEM_PAGE_SHIFT is the number of pages of
memory pool
__HEAPMEM_MAP_SIZE((__size) >> HEAPMEM_PAGE_SHIFT)calculats the memory size
for storing the struct of heapmem_pgentry=E3=80=82*/
#define __HEAPMEM_ARENA_SIZE(__size) \
(__size + \
 __align_to(sizeof(struct heapmem_extent) + \
    __HEAPMEM_MAP_SIZE((__size) >> HEAPMEM_PAGE_SHIFT), \
    HEAPMEM_MIN_ALIGN))

/*
 * Calculate the minimal size of the memory arena needed to contain a
 * heap of __user_size bytes, including our meta data for managing it.
