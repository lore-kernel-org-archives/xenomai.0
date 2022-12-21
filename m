Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591E82573
	for <xenomai@lists.linux.dev>; Wed, 21 Dec 2022 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1671635465; bh=8zPXvmq46PbBtRxby8j0F3YJAQ0gOt6nfEr4p09hDvI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=l5qrN5joFbHLu2ajZMrD4qxaHLKXAlUhZ84SWGsFrb4rKQqfVA1qW000k+EncBHIf
	 9MIGi2eu1dy6qYsr/1Dfdx9d9dvnoN6R8Z/xJfresagudOczZ95bW2kOAVpZN16cwg
	 iwgP9eBYeiLn6h5Q1l1x3rLiwg88x7gBEneajZbOFmXSzPcSB7yKtgRn3fpD8My8dL
	 KjKm7FspotTGKVqc+dwXu+JhQfcsOyc3Iji5mKqBHnXRpDGMUmd/0JUfBC3YRyaObo
	 Xzp4YtoAjYQXn8wDPa6tUWheyVFMg2bBD2HBcOXOuhQNoqhWw0CtmXsk9frTTmIwdB
	 Jy+p2tgzPJDDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.20] ([88.73.153.142]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4627-1ohVma1vOr-00zcbl; Wed, 21
 Dec 2022 16:11:05 +0100
Message-ID: <7c281c36-f7d9-71f1-2346-cb00ac5334d7@web.de>
Date: Wed, 21 Dec 2022 16:11:04 +0100
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
 <fa74110f-f02a-3ef3-4690-bd6690700ee6@web.de>
 <d33591ec-f2be-3898-b87e-904d7da77bf1@tin.it>
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <d33591ec-f2be-3898-b87e-904d7da77bf1@tin.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:igAGNRJpBOed8SAOCubb1iPPGETM5OHOafTZPT4ZpBrZg8MgK/e
 B5LXmRCxhgRNue+uMEVLHUP5IsX1bqcLzlJHUaZuzo1AIhLpUseGLFM64tTpd+jbiIqUBsj
 QQqK8XpGTAM4Uo2E1nnU4sy498j0AIKMhESxwV8WZV/WOsfiehqPOpLWiq5M43NSKyYuPln
 Hy14wnvD8Fiu2Bmi1/8bA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Y2JN6IPoUg=;RCg9Hx5zTBnSRFNPdjkbK68S/3a
 CsaEQblTfevrUQxFQCkJLmKUTQTRJrvkhccJbA0Wi+elN86rsjVddCRkdupuNdCjnsOachqwe
 jXu4D0OdbamEIgCA5sbS6oD5lmu+IGpk460QTOyuXuVYJdWFFfILmzXnjxmCS4TN3f/UWkpkn
 CdkrzBZzrC3rP0R3Y5A45ReQ5Cu8aSwloEJqKXSBXY0hgN3VWZC5M4hc8t65Ktj8EAQRxWRrf
 KR3mfU44M/fPLDL9s3lEzjSpJlvrAr4TqM1LWbc1Vs/haVpkMXGTNGHcfWzcDcyHOHnaHO/Gk
 58mbqdrSGBldpsShpEnYFp1guIKb1oi77sCfWHZTwIjnkCqDAq6fLjc7lcxSvr4n5mtT+y2Jf
 mpUGtdVuSv6ox4LdyNtevIyeeBY0W+ufcUl4y43yBj6C7OrX2zFvYdeFfhH/R8Ap3wh1xqFkd
 Mf8tGum4FxVeLgz3ecbtUXgF7FAng/5DJEAtUzt2Ake+Wme2usgyfIuQ+Rof1bO6+6GRUiZ56
 38aUUDO23TqRae89bU5I7ft7CAN/yWk9WqM+v76eNVJnq+6s1FrsnuWtq9zCYByi1mInnIVi1
 F19GePN4PnC9MFYOM2h+yO7BuFMjPJboOjOJ4Fb38Po9BQDDNVmZH30cGoDHNDcyr4vVcz8DT
 Tehm3nWvZDB3CRRRVwqJkpQ1MAC/d/2j2qsybAGsBA0/KLkGhdWq3OI8mZryIG2BgXpNJjCTw
 pcxagIfPs0epvOXPgDwqBpe6IA/cScJoGseJlx8uvcDSFFUj74FDXrr89IXHd0wVUUDzHz4NS
 pSPD4N07oTV2LJFqyDPrnTSIbmJF328EhBmelBoVzPlxoi4ZZk1X6WJgHWZf1M+dltZh/h7h5
 BlihMPw2bCTBWZ9HyWSfvcj597MnnSsko9XQARDR0egxTCJqdYauiXqJtZmx6Cw5Xajq1iw90
 3aFWpHEBU+fjNP2YXzuHK1cIZzM=

On 21.12.22 15:57, Mauro S. wrote:
> Il 21/12/22 15:48, Jan Kiszka ha scritto:
>> On 21.12.22 15:45, Mauro S. wrote:
>>> Il 21/12/22 15:29, Jan Kiszka ha scritto:
>>>> On 21.12.22 10:05, Mauro S. wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with
>>>>> Copperplate and
>>>>> pshared enabled. Linux kernel is 5.4.181.
>>>>>
>>>>> I have a main application, and another service application that
>>>>> connects
>>>>> to the main one using shared session.
>>>>>
>>>>> After some time the main application is running, the service
>>>>> application
>>>>> stops to connect to the main one with the error
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0"004.166| BUG in main_overlay(): [ma=
in] failed to allocate main
>>>>> tcb
>>>>>
>>>>> Digging a bit in the code, I found that the failing function is the
>>>>> xnmalloc() call in lib/copperplate/threadobj.c:__threadobj_alloc().
>>>>> If I understood correctly, this function tries to allocate some spac=
e
>>>>> from the shared heap. But the shared heap is almost free
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 # cat /proc/xenomai/heap
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 F=
REE=C2=A0 NAME
>>>>> =C2=A0=C2=A0=C2=A0 4194304=C2=A0=C2=A0 3616512=C2=A0 system heap
>>>>> =C2=A0=C2=A0=C2=A0 1048576=C2=A0=C2=A0 1041776=C2=A0 shared heap
>>>>> =C2=A0=C2=A0=C2=A0 1048576=C2=A0=C2=A0 1048480=C2=A0 private heap[14=
505]
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36864=C2=A0=C2=A0=C2=A0=C2=A0 19968=
=C2=A0 xddp-pool@0
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24576=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7=
680=C2=A0 xddp-pool@10
>>>>>
>>>>
>>>> This is the code that triggers the message:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pthread_ke=
y_create(&threadobj_tskey, finalize_thread))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 early_panic("failed to allocate TSD key"=
);
>>>>
>>>> pthread_key_create has nothing to do with xnmalloc. That's a plain
>>>> glibc
>>>> service, and its documentation says:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The pthread_key_crea=
te() function shall fail if:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EAGAIN The system la=
cked the necessary resources to create
>>>> another thread-specific data key, or the system-imposed limit on the
>>>> total number of keys per process {PTHREAD_KEYS_MAX} has been exceeded=
.
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ENOMEM Insufficient =
memory exists to create the key.
>>>>
>>>> Already checked THOSE conditions? Are you possibly creating threads
>>>> without cleaning them up completely?
>>>>
>>>> Jan
>>>>
>>>
>>> Hi Jan,
>>>
>>> thank you.
>>> Sorry but I can't figure out how the code you specified (that panics
>>> generating the message "failed to allocate TSD key") could trigger the
>>> "failed to allocate main tcb" message.
>>>
>>
>> https://source.denx.de/Xenomai/xenomai/-/blob/v3.1.2/lib/copperplate/th=
readobj.c#L86
>>
>> That's the only line in Xenomai which raises this message. If you don't
>> believe it triggered it, start your application in gdb and put a
>> breakpoint on that panic line.
>>
>> Jan
>>
>
> I believe thet this code triggers the message "failed to allocate TSD ke=
y".
>
> But I get the message "failed to allocate main tcb", that is in the same
> file, but at the line #1790.
>

Ah, sorry, you are right. Didn't read careful enough.

Could the heap be fragmented after lots and lots of
allocations/releases? But what is also a bit strange is that the main
thread is continuously mapped. Are you restarting the main application
for every request?

Jan

