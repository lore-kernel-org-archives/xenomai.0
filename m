MIME-Version: 1.0
In-Reply-To: <CAMwkeZxovug1Zws+NCvaU_6vhK2f3FbZqPg5kq2wVV-YvOkLSA@mail.gmail.com>
References: <CAMwkeZxovug1Zws+NCvaU_6vhK2f3FbZqPg5kq2wVV-YvOkLSA@mail.gmail.com>
Date: Wed, 12 Oct 2011 23:55:16 +0200
Message-ID: <CAMesUR5=CA1aj=OH_6ZscsofPUShbFGkWdZoo1jcQQthVmx-Zg@domain.hid>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Command code working with comedi not working
 with analogy [partially solved]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Fernando_Herrero_Carr=F3n?= <elferdo@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Hi

2011/10/12 Fernando Herrero Carr=F3n <elferdo@domain.hid>:
> El 12 de octubre de 2011 16:13, Fernando Herrero Carr=F3n <elferdo@domain.hid.=
com>
> escribi=F3:
>>
>> El 11 de octubre de 2011 19:12, Alexis Berlemont
>> <alexis.berlemont@domain.hid> escribi=F3:
>> [...]
>>
>>>
>>> I took some time to compare both versions of code (comedi and
>>> analogy). I did not find anything interesting in mite.c. I was about
>>> to ask you to increase verbosity (debug + a specific patch) when I got
>>> a glimpse on the allocation of the asynchronous buffer on the comedi
>>> side.
>>>
>>> The methods are not the same at that level:
>>> - comedi: n * dma_alloc_coherent =A0+ a vmap at the end
>>> - analogy: =A0a big vmalloc + n * page_to_phys(vmalloc_to_page(vaddr)
>>
>> Hmmm, quoting
>> http://www.mjmwired.net/kernel/Documentation/DMA-mapping.txt:
>>
>> If you acquired your memory via the page allocator
>> (i.e. __get_free_page*()) or the generic memory allocators
>>
>> (i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/from
>> that memory using the addresses returned from those routines.
>>
>> This means specifically that you may _not_ use the memory/addresses
>>
>>
>>
>>
>> returned from vmalloc() for DMA.  It is possible to DMA to the
>> _underlying_ memory mapped into a vmalloc() area, but this requires
>> walking page tables to get the physical addresses, and then
>>
>>
>>
>>
>> translating each of those pages back to a kernel address using
>> something like __va().  [ EDIT: Update this when we integrate
>> Gerd Knorr's generic code which does this. ]
>>
>> So, I guess analogy indeed took the walking approach mentioned there? If=
 I
>> understand it right, the following loop in "a4l_buf_alloc()":
>>
>> for (vaddr =3D vabase; vaddr < vabase + buf_desc->size;
>> =A0=A0=A0 =A0=A0=A0=A0 vaddr +=3D PAGE_SIZE)
>> =A0=A0=A0 =A0=A0=A0 buf_desc->pg_list[(vaddr - vabase) >> PAGE_SHIFT] =
=3D
>> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 (unsigned long) page_to_phys(vmalloc_to_pa=
ge(vaddr));
>>
>> does exactly this, by holding a list of the physical addresses of all th=
e
>> logical pages of the buffer, even if they may be non-contiguous. Then, t=
he
>> MITE is able to scatter data across the ring descriptors calculated in
>> a4l_mite_buf_change()? What is the benefit of using vmalloc? Copying fro=
m/to
>> user space is easier so?
>>
>> According to my previous test, the addresses calculated are all indeed
>> larger than 2^32. This makes sense as well, since this machine appears t=
o
>> have 6GB of memory:
>>
>> [=A0=A0=A0 0.000000] Memory: 5992084k/7208960k available (5325k kernel c=
ode,
>> 919428k absent, 297448k reserved, 3285k data, 920k init)
>>
>> The comedi drivers and kernel were not installed by myself, so
>> reinstalling them is somewhat more involved. If you still feel it would =
be
>> useful to check them out I will reinstall them, but this looks to me lik=
e
>> the possible source of the problem.
>>
>
> I got it working!!! Simple test: remove two of the three RAM modules. Now
> the machine is working with 2GB of memory:

OK.

> [=A0=A0=A0 0.000000] Memory: 1988808k/2095680k available (5325k kernel co=
de, 452k
> absent, 106420k reserved, 3285k data, 920k init)
>
> Now "cmd_read" is properly acquiring the input signal. Output of dmesg no=
w:
>
> [=A0 109.389613] Analogy: sizeof(dma_addr_t) =3D 8
> [=A0 109.389614] Analogy: ring->descriptors_dma_addr =3D 7a279000
> [=A0 109.389615] Analogy: cpu_to_le32(ring->descriptors_dma_addr) =3D 7a2=
79000
> [=A0 109.389617] Analogy: buf->pg_list[0] =3D 79322000
> [=A0 109.389618] Analogy: buf->pg_list[1] =3D 799bf000
> [=A0 109.389619] Analogy: buf->pg_list[2] =3D 79b67000
> [=A0 109.389620] Analogy: buf->pg_list[3] =3D 79303000
> [=A0 109.389621] Analogy: buf->pg_list[4] =3D 79015000
> [=A0 109.389622] Analogy: buf->pg_list[5] =3D 7997f000
> [=A0 109.389623] Analogy: buf->pg_list[6] =3D 792c1000
> [=A0 109.389625] Analogy: buf->pg_list[7] =3D 792a7000
> [=A0 109.389626] Analogy: buf->pg_list[8] =3D 7a087000
> [=A0 109.389627] Analogy: buf->pg_list[9] =3D 792c0000
> [=A0 109.389628] Analogy: buf->pg_list[10] =3D 79b36000
> [=A0 109.389629] Analogy: buf->pg_list[11] =3D 792b6000
> [=A0 109.389630] Analogy: buf->pg_list[12] =3D 792d0000
> [=A0 109.389631] Analogy: buf->pg_list[13] =3D 7999d000
> [=A0 109.389632] Analogy: buf->pg_list[14] =3D 7a1f7000
> [=A0 109.389634] Analogy: buf->pg_list[15] =3D 791e0000
>
> with all pg_list[] entries below 2^32!!
>
> Thus far this does it for us, since we can live with a 4GB machine. I thi=
nk
> the "vmalloc()" approach in analogy should be reworked, but my knowledge =
of
> linux's internals on memory handling is very limited. Please let me know =
if
> I can contribute testing any patches.

I am modfiying the asynchronous buffer allocation stuff right now. I
will provide a patch as soon as it is working on my side.

> Thank you both for your interest and willingness to help!!
>
> Sincerely,
> Fernando
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

Alexis.

