Message-ID: <4B583803.2060502@domain.hid>
Date: Thu, 21 Jan 2010 12:18:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B57134A.3090702@domain.hid> <4B5816E7.2080108@domain.hid>
	<4B58233A.4070708@domain.hid> <4B582AC4.5030104@domain.hid>
	<4B582E1F.9050505@domain.hid>
In-Reply-To: <4B582E1F.9050505@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] assert RTS signal during transmit in
 EIA-485 half duplex mode for 16550A compatible controllers.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexandre Coffignal <alexandre.coffignal@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Alexandre Coffignal wrote:
> Jan Kiszka a =E9crit :
>> Alexandre Coffignal wrote:
>>  =20
>>> Hello,
>>>
>>> Thanks you for your response.
>>>
>>> I used this patch to communicate with a slave equipment in rs485 (mod=
bus
>>> protocol). The data is transmitted over a 2-wire twisted pair bus.
>>> Master initiates all communication activity, by sending data. To do t=
his
>>> it must set RTS line to high state during all it's transmission. Befo=
re
>>> slave answer, master must lower the RTS line.
>>>    =20
>> Will the slave wait on the deassertion of RTS? Or what will happen if
>> RTS is still high and the slave starts its answer?
>>
>>  =20
> No slave does not wait on the deassertion of RTS, if RTS is still high
> during slave answer, it happen a collision and=20
> the master does not receive the frame.
>>  =20
>>> my slave equipment answer in less than 200us, so i must know when xmi=
t
>>> is completing to lower the RTS line
>>>
>>> An extension to RTSER_RTIOC_WAIT_EVENT may be a good solution but do =
you
>>> know if an extension to RTSER_RTIOC_WAIT_EVENT can guarantee this tim=
ing?
>>>
>>>    =20
>> Given a proper platform (check its capabilities with the latency or th=
e
>> irqbench test), yes. It's a myth that such things can only be done in
>> kernel space.
>>
>> Jan
>>
>>  =20
> Ok I take note of this, but do you think this function should not be in
> kernel space in half duplex RS485 ?

Well, at least not based on the current design (the task approach is not
yet convincing to me).

Also, I think one problem of a kernel space solution is to detect when a
485 "frame" (not sure if this is the right term) starts and when it end.
To my understanding, RTS is high across multiple bytes. And user space
knows best if there will more bytes and RTS should remain high or if
that was all and RTS should go low again.

Jan

--=20
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

