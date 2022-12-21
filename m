Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47072573
	for <xenomai@lists.linux.dev>; Wed, 21 Dec 2022 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1671634123; bh=e0Nql+pb9wp06HCsy8j7J+sP8ovtGtLo+7LUcWzRY0k=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=vST2f6VN6QhIRMHsT+4L4lRdm4vEDPgJToGSzHtkzQvp9bLX4dtAEr+WD5B1kQw6l
	 RwK9v4bedYUyj7SiYi+TVOREZqVt9kxa3Ikk+xMLrUFUJo1JBeQX4d4eBB/PdDdfie
	 iFK68iIZuDEpYh/KBQcq3LNzBd0PJuTQVgwCc6GruQAKtQBTlEAwbpuWwpQgmEPjgj
	 TUNu7jGNq8KZbB7qORqufV7zn4F92wcynnq/yM6w1Z5uxRimWJkODbfoBFFTYF1kbI
	 Q4/i6zaWVTMtRFzYLYzUIoR+eHbz0wnQE3vre+ON6GTkeG4BBFC2/+v4NhH3ZIFW34
	 ONbKK8wWZXpmA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.20] ([88.73.153.142]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCHy-1ob8U63bbM-00bmug; Wed, 21
 Dec 2022 15:48:43 +0100
Message-ID: <fa74110f-f02a-3ef3-4690-bd6690700ee6@web.de>
Date: Wed, 21 Dec 2022 15:48:42 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: "failed to allocate main tcb" error
Content-Language: en-US
To: "Mauro S." <mau.salvi@tin.it>, xenomai@lists.linux.dev
References: <9e3a4efe-f967-09c0-e8bb-df8d7e8140a9@tin.it>
 <198d2e2a-eb01-0822-67ff-895e8c2f1856@web.de>
 <f3167be0-db2a-2676-4866-d2690172a412@tin.it>
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <f3167be0-db2a-2676-4866-d2690172a412@tin.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NE7cdyvdLYBdOAsHCMA/SdT9osNyhVBUV4PZTzz6kBiSvuac4f2
 dDrKdy/l5cixpuBrlyghfOIf7bRWJ3NXff4sGKJIAOXtAB/zJjudptKkrIVFbEgeYJwHT6+
 8V0o5Qx0rHv041ke4dH3OmJxK72BIldbSSABcuXzAYPSGfCFQqogkCwB4CfG9ZrJ3P5Fv6y
 B4xmmWFpOt1vsqsYlNh+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/O+KoksWoXM=;6fqSmZTFsXxpoVF57QXdm/B/g0m
 kUO9HNOkx7XX6X1P69WrIea9U/lHsvzM/otvT7g6pI7a/vhpb2Ar4A9TM0xWtOqjciTYkSfx4
 BJZJo1VG6xKuD53TmHC0KKgwouOfsbG/+stingwSpD2sv+bdXBZqdm1e/dWXFSirdC+pq4zY2
 ORdSQgLjBmkW7T/cq7zJlbMxO6cUe7mJ6qWCk4F2YFwJ4gmggYYTKnhXPLUv7h86NcwleGj4L
 ZsEX8jVBuFjwIOBfE/q2005EekbtuoNVHhooNnrADKxno0lMVLFUxIN22tkxfKglbll3hjUsr
 qzHejnCzwI8huGeNPW46q9DwSndV1iiJFhBebvFM4qgxwzKFX1hq5xUdqCT+GhDOgpsF2fh3c
 btiLTGEgbOhClFj7HBzio1zsvt+ddOawy+/yqrJyexqqXHWMm4agUOiqc+w3tWK4QIzgwx98a
 rWnWNaoxyDfJzOc2dolEndMzGlIs0z4Qd2VGYxVbkJCqfa/TYfU8Wi1G2au8F6lwYpKntv/Nj
 +qAo4nteTgbj/or8uWy5QUT/MuGJy7ntse7KgVlyOVhA2MQdwBMq3rsYy+WAsys8JWKPXvO1t
 5IHiiqGzXxR14x0kLDQ6pDRdjG78OHRI/FmLSKm16X7K5NLrr3qnfFaBECipeZEnKgd0yacrw
 Bi8Ydlv2L2I1z1SEYq/RB6zUfytp25Fm4Nc69nnxadrIrXpTVPxvT/T8aYT048sDyMBRnHkG0
 LT8as9mljxoziPCkoMjhp8OUCmYQSHrKnTegFZTM961kM5K4oE0DGswtUAkX2H1TbbDfSqZPb
 cXUU3ws4S6x+ErCpjBImmofx/TI17gF7adaanQUcUdCpF66C8oCrZrmgLeQQ2RRtyq2aLyvp0
 x0SnkzwNpU0j55S2/GEF3kgL1N+KLSdkPsb2f5TFJ5UcK2vqEWgVw7AVn1lOSfL04mq3qrUsp
 hymw5A==

On 21.12.22 15:45, Mauro S. wrote:
> Il 21/12/22 15:29, Jan Kiszka ha scritto:
>> On 21.12.22 10:05, Mauro S. wrote:
>>> Hi all,
>>>
>>> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with Copperplate a=
nd
>>> pshared enabled. Linux kernel is 5.4.181.
>>>
>>> I have a main application, and another service application that connec=
ts
>>> to the main one using shared session.
>>>
>>> After some time the main application is running, the service applicati=
on
>>> stops to connect to the main one with the error
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 0"004.166| BUG in main_overlay(): [main] fail=
ed to allocate main
>>> tcb
>>>
>>> Digging a bit in the code, I found that the failing function is the
>>> xnmalloc() call in lib/copperplate/threadobj.c:__threadobj_alloc().
>>> If I understood correctly, this function tries to allocate some space
>>> from the shared heap. But the shared heap is almost free
>>>
>>> =C2=A0=C2=A0 # cat /proc/xenomai/heap
>>> =C2=A0=C2=A0=C2=A0=C2=A0 TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FREE=C2=
=A0 NAME
>>> =C2=A0=C2=A0 4194304=C2=A0=C2=A0 3616512=C2=A0 system heap
>>> =C2=A0=C2=A0 1048576=C2=A0=C2=A0 1041776=C2=A0 shared heap
>>> =C2=A0=C2=A0 1048576=C2=A0=C2=A0 1048480=C2=A0 private heap[14505]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 36864=C2=A0=C2=A0=C2=A0=C2=A0 19968=C2=A0 xdd=
p-pool@0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 24576=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7680=C2=
=A0 xddp-pool@10
>>>
>>
>> This is the code that triggers the message:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pthread_key_create=
(&threadobj_tskey, finalize_thread))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 early_panic("failed to allocate TSD key");
>>
>> pthread_key_create has nothing to do with xnmalloc. That's a plain glib=
c
>> service, and its documentation says:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The pthread_key_create() fun=
ction shall fail if:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EAGAIN The system lacked the=
 necessary resources to create
>> another thread-specific data key, or the system-imposed limit on the
>> total number of keys per process {PTHREAD_KEYS_MAX} has been exceeded.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENOMEM Insufficient memory e=
xists to create the key.
>>
>> Already checked THOSE conditions? Are you possibly creating threads
>> without cleaning them up completely?
>>
>> Jan
>>
>
> Hi Jan,
>
> thank you.
> Sorry but I can't figure out how the code you specified (that panics
> generating the message "failed to allocate TSD key") could trigger the
> "failed to allocate main tcb" message.
>

https://source.denx.de/Xenomai/xenomai/-/blob/v3.1.2/lib/copperplate/threa=
dobj.c#L86

That's the only line in Xenomai which raises this message. If you don't
believe it triggered it, start your application in gdb and put a
breakpoint on that panic line.

Jan

