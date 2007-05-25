Message-ID: <4656E657.9070909@domain.hid>
Date: Fri, 25 May 2007 15:36:23 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4656C2D1.5000904@domain.hid> <4656E396.60002@domain.hid>
In-Reply-To: <4656E396.60002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] small cleanups for rtcan_peak_dng
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Hello,

sorry, didn't realize the CC to the xenomai-core ML :-(. Here the=20
English translation:

Wolfgang Grandegger wrote:
> Hallo Jan,
>=20
> Jan Kiszka wrote:
>> Hi Wolfgang,
>>
>> I came across the fact that xeno_can_peak_dng is autoloaded on 2.6 due=
 to
>> its PnP announcement via MODULE_DEVICE_TABLE. xeno_irqbench and
>> xeno_16550A used to behave similar, but both just as well as this driv=
er
>> require manual parameters anyway. So let's remove the table and thus a=
ny
>> autoloading tendency. I also cleaned up a few driver messages at this
>> chance.
>>
>> OK to apply?
>=20
> Ja, sieht gut aus und bei dir funktioniert es ja auch.

Yes, looks good and it's working for you, I assume.

> Ein Kunde von uns evaluiert gerade CAN-Festival mit RT-Socket-CAN auf=20
> einem MPC5200-Board. Mal sehen, was dabei rauskommt.

FYI, a customer is currently evaluating CAN-Festival, a free CANopen=20
implementation, with RT-Socket-CAN on a MPC5200. The rest is off-topic he=
re.

> Die Socket-CAN-Integration hat ja jetzt auch begonnen. Da bin ich mal=20
> gespannt. Sollte mal wieder die linux-netdev ML durchschauen.

FYI, the request for inclusion of Socket-CAN into the kernel has started=20
on linux-netdev.

> Dann erstmal sch=F6ne Feiertage.

Have a nice weekend.

Wolfgang.


