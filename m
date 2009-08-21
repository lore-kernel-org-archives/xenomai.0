Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA2269.A084A478"
Date: Fri, 21 Aug 2009 16:13:59 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A9C4@domain.hid>
References: <EB48F2CADC239E44A8598CC0B0571102E4A9BE@XVS-DCFR-21.europe.corp.altran.com>
	<4A8C23BE.8050904@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C2@domain.hid>
	<4A8E628C.8010001@domain.hid>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] RE :  Native message queue and synchronisation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA2269.A084A478
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

>>>> I'm running a kernel 2.6.28 with Xenomai 2.4.8 on an ARM =
architecture
>>>> (PXA255).
>>>
>>>Could you try Xenomai 2.4.9?
>>=20
>> I did it yesterday with the version 2.4.9. But, I still issue the =
same
>> problem with the same code.
>>=20
>
>Ok. Please keep 2.4.8. I did not try to reproduce the bug yet, but in =
the
>mean time, could you try the following patch?
>
>diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
>index 8b7c43e..9184da6 100644
>--- a/ksrc/skins/native/queue.c
>+++ b/ksrc/skins/native/queue.c
>@@ -228,7 +228,8 @@ int rt_queue_create(RT_QUEUE *q,
>
>               err =3D xnheap_init_mapped(&q->bufpool,
>                                         poolsize,
>-                                        (mode & Q_DMA) ? GFP_DMA : 0);
>+                                        XNARCH_SHARED_HEAP_FLAGS |
>+                                        ((mode & Q_DMA) ? GFP_DMA : =
0));
>                if (err)
>                        return err;

I've applied the patch against library's sources.

In fact, if I remove the sleep from the "display" routine, it works. =
But, I can't assert what was the scheduling of threads. Maybe, it was =
favourable to the other thread to write the data.

If I enable the sleep call in "mesure" routine, I still issue the same =
problem that before: the system hangs. I tried to investigate the role =
of sleep, but it's a little confuse to me for debugging. Furthermore, =
the hang doesn't append in the reverse situation. I'm keeping in that =
way, waiting if you've got a better idea.

Thanks,

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| BERRUER S=E9bastien
| Trainee at Altran Ouest
| Centre d'Affaires Alphasis
| 35760 Saint-Gr=E9goire - FRANCE
| Tel: 06-76-35-29-55
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D








------_=_NextPart_001_01CA2269.A084A478
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE : [Xenomai-help] Native message queue and =
synchronisation</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
&gt;&gt;&gt;&gt; I'm running a kernel 2.6.28 with Xenomai 2.4.8 on an =
ARM architecture<BR>
&gt;&gt;&gt;&gt; (PXA255).<BR>
&gt;&gt;&gt;<BR>
&gt;&gt;&gt;Could you try Xenomai 2.4.9?<BR>
&gt;&gt;<BR>
&gt;&gt; I did it yesterday with the version 2.4.9. But, I still issue =
the same<BR>
&gt;&gt; problem with the same code.<BR>
&gt;&gt;<BR>
&gt;<BR>
&gt;Ok. Please keep 2.4.8. I did not try to reproduce the bug yet, but =
in the<BR>
&gt;mean time, could you try the following patch?<BR>
&gt;<BR>
&gt;diff --git a/ksrc/skins/native/queue.c =
b/ksrc/skins/native/queue.c<BR>
&gt;index 8b7c43e..9184da6 100644<BR>
&gt;--- a/ksrc/skins/native/queue.c<BR>
&gt;+++ b/ksrc/skins/native/queue.c<BR>
&gt;@@ -228,7 +228,8 @@ int rt_queue_create(RT_QUEUE *q,<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; err =3D xnheap_init_mapped(&amp;q-&gt;bufpool,<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; poolsize,<BR>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; (mode &amp; Q_DMA) ? GFP_DMA : 0);<BR>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; XNARCH_SHARED_HEAP_FLAGS |<BR>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ((mode &amp; Q_DMA) ? GFP_DMA : 0));<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return err;<BR>
<BR>
I've applied the patch against library's sources.<BR>
<BR>
In fact, if I remove the sleep from the &quot;display&quot; routine, it =
works. But, I can't assert what was the scheduling of threads. Maybe, it =
was favourable to the other thread to write the data.<BR>
<BR>
If I enable the sleep call in &quot;mesure&quot; routine, I still issue =
the same problem that before: the system hangs. I tried to investigate =
the role of sleep, but it's a little confuse to me for debugging. =
Furthermore, the hang doesn't append in the reverse situation. I'm =
keeping in that way, waiting if you've got a better idea.<BR>
<BR>
Thanks,<BR>
<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
| BERRUER S=E9bastien<BR>
| Trainee at Altran Ouest<BR>
| Centre d'Affaires Alphasis<BR>
| 35760 Saint-Gr=E9goire - FRANCE<BR>
| Tel: 06-76-35-29-55<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA2269.A084A478--

