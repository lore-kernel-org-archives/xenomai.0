MIME-Version: 1.0
Date: Wed, 12 Oct 2011 16:38:55 -0300
Message-ID: <CAMwkeZxovug1Zws+NCvaU_6vhK2f3FbZqPg5kq2wVV-YvOkLSA@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec520f1cfb0a42804af1f2cfd
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
To: Xenomai help <xenomai@xenomai.org>

--bcaec520f1cfb0a42804af1f2cfd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 12 de octubre de 2011 16:13, Fernando Herrero Carr=C3=B3n
<elferdo@domain.hid>escribi=C3=B3:

> El 11 de octubre de 2011 19:12, Alexis Berlemont <
> alexis.berlemont@domain.hid> escribi=C3=B3:
> [...]
>
>
>>  I took some time to compare both versions of code (comedi and
>> analogy). I did not find anything interesting in mite.c. I was about
>> to ask you to increase verbosity (debug + a specific patch) when I got
>> a glimpse on the allocation of the asynchronous buffer on the comedi
>> side.
>>
>> The methods are not the same at that level:
>> - comedi: n * dma_alloc_coherent  + a vmap at the end
>> - analogy:  a big vmalloc + n * page_to_phys(vmalloc_to_page(vaddr)
>>
>
> Hmmm, quoting http://www.mjmwired.net/kernel/Documentation/DMA-mapping.tx=
t
> :
>
>
> If you acquired your memory via the page allocator
> (i.e. __get_free_page*()) or the generic memory allocators
> (i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/from
> that memory using the addresses returned from those routines.
>
> This means specifically that you may _not_ use the memory/addresses
>
>
> returned from vmalloc() for DMA.  It is possible to DMA to the
> _underlying_ memory mapped into a vmalloc() area, but this requires
> walking page tables to get the physical addresses, and then
>
>
> translating each of those pages back to a kernel address using
> something like __va().  [ EDIT: Update this when we integrate
> Gerd Knorr's generic code which does this. ]
>
>
> So, I guess analogy indeed took the walking approach mentioned there? If =
I
> understand it right, the following loop in "a4l_buf_alloc()":
>
> for (vaddr =3D vabase; vaddr < vabase + buf_desc->size;
>          vaddr +=3D PAGE_SIZE)
>         buf_desc->pg_list[(vaddr - vabase) >> PAGE_SHIFT] =3D
>             (unsigned long) page_to_phys(vmalloc_to_page(vaddr));
>
> does exactly this, by holding a list of the physical addresses of all the
> logical pages of the buffer, even if they may be non-contiguous. Then, th=
e
> MITE is able to scatter data across the ring descriptors calculated in
> a4l_mite_buf_change()? What is the benefit of using vmalloc? Copying from=
/to
> user space is easier so?
>
> According to my previous test, the addresses calculated are all indeed
> larger than 2^32. This makes sense as well, since this machine appears to
> have 6GB of memory:
>
> [    0.000000] Memory: 5992084k/7208960k available (5325k kernel code,
> 919428k absent, 297448k reserved, 3285k data, 920k init)
>
> The comedi drivers and kernel were not installed by myself, so reinstalli=
ng
> them is somewhat more involved. If you still feel it would be useful to
> check them out I will reinstall them, but this looks to me like the possi=
ble
> source of the problem.
>
>
I got it working!!! Simple test: remove two of the three RAM modules. Now
the machine is working with 2GB of memory:

[    0.000000] Memory: 1988808k/2095680k available (5325k kernel code, 452k
absent, 106420k reserved, 3285k data, 920k init)

Now "cmd_read" is properly acquiring the input signal. Output of dmesg now:

[  109.389613] Analogy: sizeof(dma_addr_t) =3D 8
[  109.389614] Analogy: ring->descriptors_dma_addr =3D 7a279000
[  109.389615] Analogy: cpu_to_le32(ring->descriptors_dma_addr) =3D 7a27900=
0
[  109.389617] Analogy: buf->pg_list[0] =3D 79322000
[  109.389618] Analogy: buf->pg_list[1] =3D 799bf000
[  109.389619] Analogy: buf->pg_list[2] =3D 79b67000
[  109.389620] Analogy: buf->pg_list[3] =3D 79303000
[  109.389621] Analogy: buf->pg_list[4] =3D 79015000
[  109.389622] Analogy: buf->pg_list[5] =3D 7997f000
[  109.389623] Analogy: buf->pg_list[6] =3D 792c1000
[  109.389625] Analogy: buf->pg_list[7] =3D 792a7000
[  109.389626] Analogy: buf->pg_list[8] =3D 7a087000
[  109.389627] Analogy: buf->pg_list[9] =3D 792c0000
[  109.389628] Analogy: buf->pg_list[10] =3D 79b36000
[  109.389629] Analogy: buf->pg_list[11] =3D 792b6000
[  109.389630] Analogy: buf->pg_list[12] =3D 792d0000
[  109.389631] Analogy: buf->pg_list[13] =3D 7999d000
[  109.389632] Analogy: buf->pg_list[14] =3D 7a1f7000
[  109.389634] Analogy: buf->pg_list[15] =3D 791e0000

with all pg_list[] entries below 2^32!!

Thus far this does it for us, since we can live with a 4GB machine. I think
the "vmalloc()" approach in analogy should be reworked, but my knowledge of
linux's internals on memory handling is very limited. Please let me know if
I can contribute testing any patches.

Thank you both for your interest and willingness to help!!

Sincerely,
Fernando

--bcaec520f1cfb0a42804af1f2cfd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 12 de octubre de 2011 16:13, Fernando Herrero=
 Carr=C3=B3n <span dir=3D"ltr">&lt;<a href=3D"mailto:elferdo@domain.hid">elf=
erdo@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquote class=3D"gmail_=
quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, =
204, 204); padding-left: 1ex;">
<div class=3D"gmail_quote"><div class=3D"im">El 11 de octubre de 2011 19:12=
, Alexis Berlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont=
@gmail.com" target=3D"_blank">alexis.berlemont@domain.hid</a>&gt;</span> esc=
ribi=C3=B3:<br>
</div><div>[...]<br>

=C2=A0<br></div><div class=3D"im"><blockquote class=3D"gmail_quote" style=
=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">
<div>
</div>I took some time to compare both versions of code (comedi and<br>
analogy). I did not find anything interesting in mite.c. I was about<br>
to ask you to increase verbosity (debug + a specific patch) when I got<br>
a glimpse on the allocation of the asynchronous buffer on the comedi<br>
side.<br>
<br>
The methods are not the same at that level:<br>
- comedi: n * dma_alloc_coherent =C2=A0+ a vmap at the end<br>
- analogy: =C2=A0a big vmalloc + n * page_to_phys(vmalloc_to_page(vaddr)<br=
></blockquote></div><div><br>Hmmm, quoting <a href=3D"http://www.mjmwired.n=
et/kernel/Documentation/DMA-mapping.txt" target=3D"_blank">http://www.mjmwi=
red.net/kernel/Documentation/DMA-mapping.txt</a>:<br>



<div style=3D"margin-left: 40px;"><pre><span></span><br><span></span>If you=
 acquired your memory via the page allocator<br><span></span>(i.e. __get_fr=
ee_page*()) or the generic memory allocators<br>
<span></span>(i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/fro=
m<br><span></span>that memory using the addresses returned from those routi=
nes.<br><span></span><br><span></span>This means specifically that you may =
_not_ use the memory/addresses<br>



<span></span>returned from vmalloc() for DMA.  It is possible to DMA to the=
<br><span></span>_underlying_ memory mapped into a vmalloc() area, but this=
 requires<br><span></span>walking page tables to get the physical addresses=
, and then<br>



<span></span>translating each of those pages back to a kernel address using=
<br><span></span>something like __va().  [ EDIT: Update this when we integr=
ate<br><span></span>Gerd Knorr&#39;s generic code which does this. ]</pre>



</div></div><div><br>So, I guess analogy indeed took the walking approach m=
entioned there? If I understand it right, the following loop in &quot;a4l_b=
uf_alloc()&quot;:<br><br><div style=3D"margin-left: 40px;">for (vaddr =3D v=
abase; vaddr &lt; vabase + buf_desc-&gt;size;<br>



=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 vaddr +=3D PAGE_SIZE)<br>=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 buf_desc-&gt;pg_list[(vaddr - vabase) &gt;&=
gt; PAGE_SHIFT] =3D<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 (unsigned long) page_to_phys(vmalloc_to_page(vaddr));<br><br></div>d=
oes exactly this, by holding a list of the physical addresses of all the lo=
gical pages of the buffer, even if they may be non-contiguous. Then, the MI=
TE is able to scatter data across the ring descriptors calculated in a4l_mi=
te_buf_change()? What is the benefit of using vmalloc? Copying from/to user=
 space is easier so?<br>



<br>According to my previous test, the addresses calculated are all indeed =
larger than 2^32. This makes sense as well, since this machine appears to h=
ave 6GB of memory:<br><br><div style=3D"margin-left: 40px;">[=C2=A0=C2=A0=
=C2=A0 0.000000] Memory: 5992084k/7208960k available (5325k kernel code, 91=
9428k absent, 297448k reserved, 3285k data, 920k init)<br>



<br></div></div></div>The comedi drivers and kernel were not installed by m=
yself, so reinstalling them is somewhat more involved. If you still feel it=
 would be useful to check them out I will reinstall them, but this looks to=
 me like the possible source of the problem.<br>

<br></blockquote></div><br>I got it working!!! Simple test: remove two of t=
he three RAM modules. Now the machine is working with 2GB of memory:<br><br=
><div style=3D"margin-left: 40px;">[=C2=A0=C2=A0=C2=A0 0.000000] Memory: 19=
88808k/2095680k available (5325k kernel code, 452k absent, 106420k reserved=
, 3285k data, 920k init)<br>
<br></div>Now &quot;cmd_read&quot; is properly acquiring the input signal. =
Output of dmesg now:<br><br><div style=3D"margin-left: 40px;">[=C2=A0 109.3=
89613] Analogy: sizeof(dma_addr_t) =3D 8<br>[=C2=A0 109.389614] Analogy: ri=
ng-&gt;descriptors_dma_addr =3D 7a279000<br>
[=C2=A0 109.389615] Analogy: cpu_to_le32(ring-&gt;descriptors_dma_addr) =3D=
 7a279000<br>[=C2=A0 109.389617] Analogy: buf-&gt;pg_list[0] =3D 79322000<b=
r>[=C2=A0 109.389618] Analogy: buf-&gt;pg_list[1] =3D 799bf000<br>[=C2=A0 1=
09.389619] Analogy: buf-&gt;pg_list[2] =3D 79b67000<br>
[=C2=A0 109.389620] Analogy: buf-&gt;pg_list[3] =3D 79303000<br>[=C2=A0 109=
.389621] Analogy: buf-&gt;pg_list[4] =3D 79015000<br>[=C2=A0 109.389622] An=
alogy: buf-&gt;pg_list[5] =3D 7997f000<br>[=C2=A0 109.389623] Analogy: buf-=
&gt;pg_list[6] =3D 792c1000<br>
[=C2=A0 109.389625] Analogy: buf-&gt;pg_list[7] =3D 792a7000<br>[=C2=A0 109=
.389626] Analogy: buf-&gt;pg_list[8] =3D 7a087000<br>[=C2=A0 109.389627] An=
alogy: buf-&gt;pg_list[9] =3D 792c0000<br>[=C2=A0 109.389628] Analogy: buf-=
&gt;pg_list[10] =3D 79b36000<br>
[=C2=A0 109.389629] Analogy: buf-&gt;pg_list[11] =3D 792b6000<br>[=C2=A0 10=
9.389630] Analogy: buf-&gt;pg_list[12] =3D 792d0000<br>[=C2=A0 109.389631] =
Analogy: buf-&gt;pg_list[13] =3D 7999d000<br>[=C2=A0 109.389632] Analogy: b=
uf-&gt;pg_list[14] =3D 7a1f7000<br>
[=C2=A0 109.389634] Analogy: buf-&gt;pg_list[15] =3D 791e0000<br><br></div>=
with all pg_list[] entries below 2^32!!<br><br>Thus far this does it for us=
, since we can live with a 4GB machine. I think the &quot;vmalloc()&quot; a=
pproach in analogy should be reworked, but my knowledge of linux&#39;s inte=
rnals on memory handling is very limited. Please let me know if I can contr=
ibute testing any patches.<br>
<br>Thank you both for your interest and willingness to help!!<br><br>Since=
rely,<br>Fernando<br>

--bcaec520f1cfb0a42804af1f2cfd--

