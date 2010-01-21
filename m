Message-ID: <4B582E1F.9050505@domain.hid>
Date: Thu, 21 Jan 2010 11:36:15 +0100
From: Alexandre Coffignal <alexandre.coffignal@domain.hid>
MIME-Version: 1.0
References: <4B57134A.3090702@domain.hid> <4B5816E7.2080108@domain.hid>
	<4B58233A.4070708@domain.hid> <4B582AC4.5030104@domain.hid>
In-Reply-To: <4B582AC4.5030104@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka a =E9crit :
> Alexandre Coffignal wrote:
>  =20
>> Hello,
>>
>> Thanks you for your response.
>>
>> I used this patch to communicate with a slave equipment in rs485 (modbus
>> protocol). The data is transmitted over a 2-wire twisted pair bus.
>> Master initiates all communication activity, by sending data. To do this
>> it must set RTS line to high state during all it's transmission. Before
>> slave answer, master must lower the RTS line.
>>    =20
>
> Will the slave wait on the deassertion of RTS? Or what will happen if
> RTS is still high and the slave starts its answer?
>
>  =20
No slave does not wait on the deassertion of RTS, if RTS is still high
during slave answer, it happen a collision and=20
the master does not receive the frame.
>  =20
>> my slave equipment answer in less than 200us, so i must know when xmit
>> is completing to lower the RTS line
>>
>> An extension to RTSER_RTIOC_WAIT_EVENT may be a good solution but do you
>> know if an extension to RTSER_RTIOC_WAIT_EVENT can guarantee this timing?
>>
>>    =20
>
> Given a proper platform (check its capabilities with the latency or the
> irqbench test), yes. It's a myth that such things can only be done in
> kernel space.
>
> Jan
>
>  =20
Ok I take note of this, but do you think this function should not be in
kernel space in half duplex RS485 ?

--=20
Alexandre COFFIGNAL, Chef de Projet
Email: alexandre.coffignal@domain.hid
<mailto:alexandre.coffignal@domain.hid>
------------------------------------
C=E9noSYS <http://www.cenosys.com>
10, Rue Xavier Bichat
F-72000 Le MANS
Tel: +33(0) 243 511 797
web : http://www.cenosys.com
------------------------------------
CONFIDENTIALITE : Ce message =E9lectronique et tous les fichiers attach=E9s
qu'il contient sont confidentiels et destin=E9s exclusivement =E0 l'usage de
la personne =E0 laquelle ils sont adress=E9s. Si vous avez re=E7u ce message
par erreur, merci de le retourner imm=E9diatement a son =E9metteur sans en
conserver de copie.

CONFIDENTIALITY : This e-mail and any attachments are confidential and
may also be privileged. If you are not the named recipient, please
notify the sender immediately and do not disclose the contents to an
other person, use it for any purpose, or store or copy the information
in any medium.

