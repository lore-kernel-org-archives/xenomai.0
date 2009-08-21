Message-ID: <4A8F1E70.6090608@domain.hid>
Date: Sat, 22 Aug 2009 00:23:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EB48F2CADC239E44A8598CC0B0571102E4A9BE@XVS-DCFR-21.europe.corp.altran.com>
	<4A8C23BE.8050904@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C2@domain.hid>
	<4A8E628C.8010001@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C4@domain.hid>
In-Reply-To: <EB48F2CADC239E44A8598CC0B0571102E4A9C4@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RE :  Native message queue and synchronisation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?QmVycnVlciBTw6liYXN0aWVu?= <sebastien.berruer@domain.hid>
Cc: xenomai@xenomai.org

Berruer S=C3=A9bastien wrote:
> Hi,
>=20
>>>>> I'm running a kernel 2.6.28 with Xenomai 2.4.8 on an ARM architectu=
re
>>>>> (PXA255).
>>>>
>>>>Could you try Xenomai 2.4.9?
>>>
>>> I did it yesterday with the version 2.4.9. But, I still issue the sam=
e
>>> problem with the same code.
>>>
>>
>>Ok. Please keep 2.4.8. I did not try to reproduce the bug yet, but in t=
he
>>mean time, could you try the following patch?
>>
>>diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
>>index 8b7c43e..9184da6 100644
>>--- a/ksrc/skins/native/queue.c
>>+++ b/ksrc/skins/native/queue.c
>>@@ -228,7 +228,8 @@ int rt_queue_create(RT_QUEUE *q,
>>
>>               err =3D xnheap_init_mapped(&q->bufpool,
>>                                         poolsize,
>>-                                        (mode & Q_DMA) ? GFP_DMA : 0);=

>>+                                        XNARCH_SHARED_HEAP_FLAGS |
>>+                                        ((mode & Q_DMA) ? GFP_DMA : 0)=
);
>>                if (err)
>>                        return err;
>=20
> I've applied the patch against library's sources.
>=20
> In fact, if I remove the sleep from the "display" routine, it works.
> But, I can't assert what was the scheduling of threads. Maybe, it was
> favourable to the other thread to write the data.
>=20
> If I enable the sleep call in "mesure" routine, I still issue the same
> problem that before: the system hangs. I tried to investigate the role
> of sleep, but it's a little confuse to me for debugging. Furthermore,
> the hang doesn't append in the reverse situation. I'm keeping in that
> way, waiting if you've got a better idea.

Ok. Your test program was tested on ppc and ARM, and works as far as we
can tell. So, unless you show us your full serial console trace, from
boot to the oops/or panic if any, as welll as your kernel configuration,
we will consider this issue closed.


--=20
					    Gilles.


