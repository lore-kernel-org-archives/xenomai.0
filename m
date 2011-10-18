Message-ID: <4E9D5C7C.1040306@domain.hid>
Date: Tue, 18 Oct 2011 13:01:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMwkeZxovug1Zws+NCvaU_6vhK2f3FbZqPg5kq2wVV-YvOkLSA@mail.gmail.com>
	<CAMesUR4iU0=-vTVmk=adq5uR_bep-C7Mycoxk=59Msn2BFngiA@mail.gmail.com>
In-Reply-To: <CAMesUR4iU0=-vTVmk=adq5uR_bep-C7Mycoxk=59Msn2BFngiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 10/18/2011 12:25 AM, Alexis Berlemont wrote:
> Hi,
>=20
> 2011/10/12 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
>> El 12 de octubre de 2011 16:13, Fernando Herrero Carr=C3=B3n <elferdo@=
gmail.com>
>> escribi=C3=B3:
>>>
>>> El 11 de octubre de 2011 19:12, Alexis Berlemont
>>> <alexis.berlemont@domain.hid> escribi=C3=B3:
>>> [...]
>>>
>>>>
>>>> I took some time to compare both versions of code (comedi and
>>>> analogy). I did not find anything interesting in mite.c. I was about=

>>>> to ask you to increase verbosity (debug + a specific patch) when I g=
ot
>>>> a glimpse on the allocation of the asynchronous buffer on the comedi=

>>>> side.
>>>>
>>>> The methods are not the same at that level:
>>>> - comedi: n * dma_alloc_coherent  + a vmap at the end
>>>> - analogy:  a big vmalloc + n * page_to_phys(vmalloc_to_page(vaddr)
>>>
>>> Hmmm, quoting
>>> http://www.mjmwired.net/kernel/Documentation/DMA-mapping.txt:
>>>
>>> If you acquired your memory via the page allocator
>>> (i.e. __get_free_page*()) or the generic memory allocators
>>>
>>> (i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/from
>>> that memory using the addresses returned from those routines.
>>>
>>> This means specifically that you may _not_ use the memory/addresses
>>>
>>>
>>>
>>>
>>> returned from vmalloc() for DMA.  It is possible to DMA to the
>>> _underlying_ memory mapped into a vmalloc() area, but this requires
>>> walking page tables to get the physical addresses, and then
>>>
>>>
>>>
>>>
>>> translating each of those pages back to a kernel address using
>>> something like __va().  [ EDIT: Update this when we integrate
>>> Gerd Knorr's generic code which does this. ]
>>>
>>> So, I guess analogy indeed took the walking approach mentioned there?=
 If I
>>> understand it right, the following loop in "a4l_buf_alloc()":
>>>
>>> for (vaddr =3D vabase; vaddr < vabase + buf_desc->size;
>>>          vaddr +=3D PAGE_SIZE)
>>>         buf_desc->pg_list[(vaddr - vabase) >> PAGE_SHIFT] =3D
>>>             (unsigned long) page_to_phys(vmalloc_to_page(vaddr));
>>>
>>> does exactly this, by holding a list of the physical addresses of all=
 the
>>> logical pages of the buffer, even if they may be non-contiguous. Then=
, the
>>> MITE is able to scatter data across the ring descriptors calculated i=
n
>>> a4l_mite_buf_change()? What is the benefit of using vmalloc?
>=20
> A vmalloced area is composed of pages which do not have to be
> physically contiguous, the kernel's page table is filled so that
> sparse physical pages are reachable through a virtual contiguous area.
> This is a great advantage when your OS does not manage to allocate
> physically contiguous area (because of fragmentation: free memory 4KB
> pages in the middle of used memory pages).
>=20
> - On the device side, if your DMA controller can work with
> non-contiguous buffer, you just have to indicate each page
> - On the CPU side, you work with a virtually contiguous buffer (so
> really easy to manipulate).
>=20
> I did not use vmap because I did not know it...
>=20
>>> Copying from/to
>>> user space is easier so?
>>>
>>> According to my previous test, the addresses calculated are all indee=
d
>>> larger than 2^32. This makes sense as well, since this machine appear=
s to
>>> have 6GB of memory:
>>>
>>> [    0.000000] Memory: 5992084k/7208960k available (5325k kernel code=
,
>>> 919428k absent, 297448k reserved, 3285k data, 920k init)
>>>
>>> The comedi drivers and kernel were not installed by myself, so
>>> reinstalling them is somewhat more involved. If you still feel it wou=
ld be
>>> useful to check them out I will reinstall them, but this looks to me =
like
>>> the possible source of the problem.
>>>
>>
>> I got it working!!! Simple test: remove two of the three RAM modules. =
Now
>> the machine is working with 2GB of memory:
>>
>> [    0.000000] Memory: 1988808k/2095680k available (5325k kernel code,=
 452k
>> absent, 106420k reserved, 3285k data, 920k init)
>>
>> Now "cmd_read" is properly acquiring the input signal. Output of dmesg=
 now:
>>
>> [  109.389613] Analogy: sizeof(dma_addr_t) =3D 8
>> [  109.389614] Analogy: ring->descriptors_dma_addr =3D 7a279000
>> [  109.389615] Analogy: cpu_to_le32(ring->descriptors_dma_addr) =3D 7a=
279000
>> [  109.389617] Analogy: buf->pg_list[0] =3D 79322000
>> [  109.389618] Analogy: buf->pg_list[1] =3D 799bf000
>> [  109.389619] Analogy: buf->pg_list[2] =3D 79b67000
>> [  109.389620] Analogy: buf->pg_list[3] =3D 79303000
>> [  109.389621] Analogy: buf->pg_list[4] =3D 79015000
>> [  109.389622] Analogy: buf->pg_list[5] =3D 7997f000
>> [  109.389623] Analogy: buf->pg_list[6] =3D 792c1000
>> [  109.389625] Analogy: buf->pg_list[7] =3D 792a7000
>> [  109.389626] Analogy: buf->pg_list[8] =3D 7a087000
>> [  109.389627] Analogy: buf->pg_list[9] =3D 792c0000
>> [  109.389628] Analogy: buf->pg_list[10] =3D 79b36000
>> [  109.389629] Analogy: buf->pg_list[11] =3D 792b6000
>> [  109.389630] Analogy: buf->pg_list[12] =3D 792d0000
>> [  109.389631] Analogy: buf->pg_list[13] =3D 7999d000
>> [  109.389632] Analogy: buf->pg_list[14] =3D 7a1f7000
>> [  109.389634] Analogy: buf->pg_list[15] =3D 791e0000
>>
>> with all pg_list[] entries below 2^32!!
>>
>> Thus far this does it for us, since we can live with a 4GB machine. I =
think
>> the "vmalloc()" approach in analogy should be reworked, but my knowled=
ge of
>> linux's internals on memory handling is very limited. Please let me kn=
ow if
>> I can contribute testing any patches.
>>
>=20
> The last few days, I did not have enough time to review the buffer
> allocation system just like Comedi did. So, I implemented a quick
> workaround Gilles indicated me.
>=20
> Could you validate it on your 64bits architecture (with more than 4GB o=
f RAM)?
>=20
> The code is available here:
> git://git@domain.hid
> branch: analogy.

I pull this for -rc5.

--=20
                                                                Gilles.


