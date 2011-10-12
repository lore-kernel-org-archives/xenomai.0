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
Date: Wed, 12 Oct 2011 13:00:42 -0300
Message-ID: <CAMwkeZxHjYyO54CzL+wYprfWPLCdMFqwd8xzuA2Uu0tqsxwzLg@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec53146dd4e51a004af1c20c0
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

--bcaec53146dd4e51a004af1c20c0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 11 de octubre de 2011 19:12, Alexis Berlemont <alexis.berlemont@domain.hid=
m
> escribi=C3=B3:

> Hi,
>
> Sorry for answering late.
>

Well, thanks for answering ;)


>
> I took some time to compare both versions of code (comedi and
> analogy). I did not find anything interesting in mite.c. I was about
> to ask you to increase verbosity (debug + a specific patch) when I got
> a glimpse on the allocation of the asynchronous buffer on the comedi
> side.
>
> The methods are not the same at that level:
> - comedi: n * dma_alloc_coherent  + a vmap at the end
> - analogy:  a big vmalloc + n * page_to_phys(vmalloc_to_page(vaddr)
>
> I don't understand the reason why the analogy way is not correct, I
> did not have time to check yet. If anyone has any idea, please help
> me.
>
> However, the NI mite expects 32 bit addresses... (because of
> cpu_to_le32 in the mite driver).
>
> If I remember well, you are using a 64-bit architecture. Is it
> correct? There may be a bug here; analogy might give to the mite
> physical addresses which are not below 2^32.
>

That's right, I'm on a 64bit machine. This sounds very reasonable to me.


> So, could you:
> - with comedi, add some printk("%lx") in mite_buf_change so as to dump
> the pages physical addresses
> - with analogy, do the same thing in a4l_mite_buf_change.
>

Ok, I'v only performed the analogy tests so far, and here are the results:

[  172.627662] Analogy: sizeof(dma_addr_t) =3D 8
[  172.627663] Analogy: ring->descriptors_dma_addr =3D c740d000
[  172.627665] Analogy: cpu_to_le32(ring->descriptors_dma_addr) =3D c740d00=
0
[  172.627666] Analogy: buf->pg_list[0] =3D 19d806000
[  172.627667] Analogy: buf->pg_list[1] =3D 1a9095000
[  172.627668] Analogy: buf->pg_list[2] =3D 19d552000
[  172.627669] Analogy: buf->pg_list[3] =3D 19eb93000
[  172.627671] Analogy: buf->pg_list[4] =3D 1a91fc000
[  172.627672] Analogy: buf->pg_list[5] =3D 1a9203000
[  172.627673] Analogy: buf->pg_list[6] =3D 19d9c1000
[  172.627674] Analogy: buf->pg_list[7] =3D 19ebff000
[  172.627675] Analogy: buf->pg_list[8] =3D 19eacb000
[  172.627676] Analogy: buf->pg_list[9] =3D 1a905d000
[  172.627677] Analogy: buf->pg_list[10] =3D 1a9050000
[  172.627678] Analogy: buf->pg_list[11] =3D 1a9174000
[  172.627679] Analogy: buf->pg_list[12] =3D 1aa791000
[  172.627680] Analogy: buf->pg_list[13] =3D 1aa635000
[  172.627682] Analogy: buf->pg_list[14] =3D 1aa7fb000
[  172.627683] Analogy: buf->pg_list[15] =3D 19dae5000

These are printed right after the call to "pci_alloc_consistent()" and in
the subsequent "for" loop. So if I understand it right,
"ring->descriptors_dma_addr" represents the base physical address that DMA
transfers will access? And then, "buf->pg_list" are virtual addresses or
virtual page indexes?

I'll check those values in comedi and let you know.

Thanks a lot for your effort!

Fernando

--bcaec53146dd4e51a004af1c20c0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 11 de octubre de 2011 19:12, Alexis Berlemont=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid">alexis=
.berlemont@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquote class=3D"=
gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb=
(204, 204, 204); padding-left: 1ex;">
Hi,<br>
<br>
Sorry for answering late.<br></blockquote><div><br>Well, thanks for answeri=
ng ;)<br>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left=
: 1ex;">
<div><div class=3D"h5">
<br>
</div></div>I took some time to compare both versions of code (comedi and<b=
r>
analogy). I did not find anything interesting in mite.c. I was about<br>
to ask you to increase verbosity (debug + a specific patch) when I got<br>
a glimpse on the allocation of the asynchronous buffer on the comedi<br>
side.<br>
<br>
The methods are not the same at that level:<br>
- comedi: n * dma_alloc_coherent =C2=A0+ a vmap at the end<br>
- analogy: =C2=A0a big vmalloc + n * page_to_phys(vmalloc_to_page(vaddr)<br=
>
<br>
I don&#39;t understand the reason why the analogy way is not correct, I<br>
did not have time to check yet. If anyone has any idea, please help<br>
me.<br>
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt=
 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
However, the NI mite expects 32 bit addresses... (because of<br>
cpu_to_le32 in the mite driver).<br>
<br>
If I remember well, you are using a 64-bit architecture. Is it<br>
correct? There may be a bug here; analogy might give to the mite<br>
physical addresses which are not below 2^32.<br></blockquote><div><br>That&=
#39;s right, I&#39;m on a 64bit machine. This sounds very reasonable to me.=
<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt =
0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

So, could you:<br>
- with comedi, add some printk(&quot;%lx&quot;) in mite_buf_change so as to=
 dump<br>
the pages physical addresses<br>
- with analogy, do the same thing in a4l_mite_buf_change.<br></blockquote><=
/div><br>Ok, I&#39;v only performed the analogy tests so far, and here are =
the results:<br><br><div style=3D"margin-left: 40px;">[=C2=A0 172.627662] A=
nalogy: sizeof(dma_addr_t) =3D 8<br>
[=C2=A0 172.627663] Analogy: ring-&gt;descriptors_dma_addr =3D c740d000<br>=
[=C2=A0 172.627665] Analogy: cpu_to_le32(ring-&gt;descriptors_dma_addr) =3D=
 c740d000<br>[=C2=A0 172.627666] Analogy: buf-&gt;pg_list[0] =3D 19d806000<=
br>[=C2=A0 172.627667] Analogy: buf-&gt;pg_list[1] =3D 1a9095000<br>
[=C2=A0 172.627668] Analogy: buf-&gt;pg_list[2] =3D 19d552000<br>[=C2=A0 17=
2.627669] Analogy: buf-&gt;pg_list[3] =3D 19eb93000<br>[=C2=A0 172.627671] =
Analogy: buf-&gt;pg_list[4] =3D 1a91fc000<br>[=C2=A0 172.627672] Analogy: b=
uf-&gt;pg_list[5] =3D 1a9203000<br>
[=C2=A0 172.627673] Analogy: buf-&gt;pg_list[6] =3D 19d9c1000<br>[=C2=A0 17=
2.627674] Analogy: buf-&gt;pg_list[7] =3D 19ebff000<br>[=C2=A0 172.627675] =
Analogy: buf-&gt;pg_list[8] =3D 19eacb000<br>[=C2=A0 172.627676] Analogy: b=
uf-&gt;pg_list[9] =3D 1a905d000<br>
[=C2=A0 172.627677] Analogy: buf-&gt;pg_list[10] =3D 1a9050000<br>[=C2=A0 1=
72.627678] Analogy: buf-&gt;pg_list[11] =3D 1a9174000<br>[=C2=A0 172.627679=
] Analogy: buf-&gt;pg_list[12] =3D 1aa791000<br>[=C2=A0 172.627680] Analogy=
: buf-&gt;pg_list[13] =3D 1aa635000<br>
[=C2=A0 172.627682] Analogy: buf-&gt;pg_list[14] =3D 1aa7fb000<br>[=C2=A0 1=
72.627683] Analogy: buf-&gt;pg_list[15] =3D 19dae5000<br></div><br>These ar=
e printed right after the call to &quot;pci_alloc_consistent()&quot; and in=
 the subsequent &quot;for&quot; loop. So if I understand it right, &quot;ri=
ng-&gt;descriptors_dma_addr&quot; represents the base physical address that=
 DMA transfers will access? And then, &quot;buf-&gt;pg_list&quot; are virtu=
al addresses or virtual page indexes?<br>
<br>I&#39;ll check those values in comedi and let you know.<br><br>Thanks a=
 lot for your effort!<br><br>Fernando<br>

--bcaec53146dd4e51a004af1c20c0--

