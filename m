MIME-Version: 1.0
In-Reply-To: <CAMesUR5PsVLb16ZR1bdcbDWdUfvPxViPng+rD7mjQqy1q+OGfA@mail.gmail.com>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
	<CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
	<CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>
	<CAMwkeZyQwtJbcMjOiSnmzoRDud+4=6Nt2NOcEdFG_+1QVSHoSQ@mail.gmail.com>
	<CAMwkeZzajkK7gRYH5cnAW1-5HvgxQyUogDZKpms1FUyLtwxpdg@domain.hid>
	<CAMesUR67RpFHRiNcd-yfR9WF2FRe1U3yBdXWP2dU30aQovCHKQ@mail.gmail.com>
	<CAMwkeZxybKS+-B2C_yaYX3_XSYnAKcj8xfX_YOgQ6Kt=mNTzJQ@mail.gmail.com>
	<CAMwkeZzrfuB1Uf7f1eqG8zEvgeYMXrRspzUANeOaJR2qQUmhOQ@mail.gmail.com>
	<CAMesUR5AvmUDW8wq4e9EtOgnpRtMD_qe8rQe7acgFT6KzdeYAg@domain.hid>
	<CAMwkeZxAvBeY=0c49N+QtUYCKCTiGo4yc9TAEQPLJAJmBXPn+A@mail.gmail.com>
	<CAMesUR59KFH=hjpo=fr8DCHeg50driuitcikc5HfHTZWG5ct8A@mail.gmail.com>
	<CAMwkeZyPorMx9n1Y8YAEJE4hUh49=u9Mr_tj7qzYAnquMa60rw@domain.hid>
	<CAMesUR5PsVLb16ZR1bdcbDWdUfvPxViPng+rD7mjQqy1q+OGfA@mail.gmail.com>
Date: Wed, 12 Oct 2011 16:13:28 -0300
Message-ID: <CAMwkeZxrxJ_fRd5td6Tw-_xxcyKAfbBvZvacYa3UqQoNgvwPsQ@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec53146ddaaef6504af1ed162
Subject: Re: [Xenomai-help] Command code working with comedi not working
	with analogy
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

--bcaec53146ddaaef6504af1ed162
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 11 de octubre de 2011 19:12, Alexis Berlemont <alexis.berlemont@domain.hid=
m
> escribi=C3=B3:
[...]


>  I took some time to compare both versions of code (comedi and
> analogy). I did not find anything interesting in mite.c. I was about
> to ask you to increase verbosity (debug + a specific patch) when I got
> a glimpse on the allocation of the asynchronous buffer on the comedi
> side.
>
> The methods are not the same at that level:
> - comedi: n * dma_alloc_coherent  + a vmap at the end
> - analogy:  a big vmalloc + n * page_to_phys(vmalloc_to_page(vaddr)
>

Hmmm, quoting http://www.mjmwired.net/kernel/Documentation/DMA-mapping.txt:


If you acquired your memory via the page allocator
(i.e. __get_free_page*()) or the generic memory allocators
(i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/from
that memory using the addresses returned from those routines.

This means specifically that you may _not_ use the memory/addresses

returned from vmalloc() for DMA.  It is possible to DMA to the
_underlying_ memory mapped into a vmalloc() area, but this requires
walking page tables to get the physical addresses, and then

translating each of those pages back to a kernel address using
something like __va().  [ EDIT: Update this when we integrate
Gerd Knorr's generic code which does this. ]


So, I guess analogy indeed took the walking approach mentioned there? If I
understand it right, the following loop in "a4l_buf_alloc()":

for (vaddr =3D vabase; vaddr < vabase + buf_desc->size;
         vaddr +=3D PAGE_SIZE)
        buf_desc->pg_list[(vaddr - vabase) >> PAGE_SHIFT] =3D
            (unsigned long) page_to_phys(vmalloc_to_page(vaddr));

does exactly this, by holding a list of the physical addresses of all the
logical pages of the buffer, even if they may be non-contiguous. Then, the
MITE is able to scatter data across the ring descriptors calculated in
a4l_mite_buf_change()? What is the benefit of using vmalloc? Copying from/t=
o
user space is easier so?

According to my previous test, the addresses calculated are all indeed
larger than 2^32. This makes sense as well, since this machine appears to
have 6GB of memory:

[    0.000000] Memory: 5992084k/7208960k available (5325k kernel code,
919428k absent, 297448k reserved, 3285k data, 920k init)

The comedi drivers and kernel were not installed by myself, so reinstalling
them is somewhat more involved. If you still feel it would be useful to
check them out I will reinstall them, but this looks to me like the possibl=
e
source of the problem.

Best regards,
Fernando

--bcaec53146ddaaef6504af1ed162
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 11 de octubre de 2011 19:12, Alexis Berlemont=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid" target=
=3D"_blank">alexis.berlemont@domain.hid</a>&gt;</span> escribi=C3=B3:<br><di=
v>[...]<br>

=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt =
0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
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
></blockquote><div><br>Hmmm, quoting <a href=3D"http://www.mjmwired.net/ker=
nel/Documentation/DMA-mapping.txt" target=3D"_blank">http://www.mjmwired.ne=
t/kernel/Documentation/DMA-mapping.txt</a>:<br>


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
<br>Best regards,<br>Fernando<br>

--bcaec53146ddaaef6504af1ed162--

