Message-ID: <44181150.7070708@domain.hid>
Date: Wed, 15 Mar 2006 14:06:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>	<200603141640.18539.lbocseg@domain.hid>
	<4417279B.4030103@domain.hid> <200603141932.55374.lbocseg@domain.hid>
In-Reply-To: <200603141932.55374.lbocseg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Rodrigo Rosenfeld Rosas wrote:
> I really tried to not answer this message and finish the "endless threa=
d" you=20
> mentioned, but I couldn't resist. ;) Maybe this will be the last post f=
rom my=20
> own on this thread and will begin writing in the new thread. See below,=
=20
> please.

Don't bother with self-censorship, AFAIC, the issues you are triggering a=
re=20
important ones, since RTDM is a critical piece of the Xenomai framework, =
and=20
allowing users to leverage it efficiently will help us all. However, plea=
se don't=20
top post and trim the old messages a bit more from your replies: unfortun=
ately, my=20
brain has a limited FIFO. TIA,

> ____________________________________________________________
> Em Ter=E7a 14 Mar=E7o 2006 17:29, Jan Kiszka escreveu:
>=20
>=20
>>...
>>
>>Ok, your framework is effectively aiming for relative times here, that'=
s
>>clear now. But your driver will deliver individual frames with absolute
>>timestamp, right?
>=20
>=20
> Right.
>=20
>=20
>>Then it's up to the user to NOT mix up these=20
>>timestamps with dates obtained from the system clock. You will have to
>>state this clearly!
>=20
>=20
> Sure, of course. No problem with that.
>=20
>=20
>>Moreover, when considering the TSC as high-resolution timestamp source,
>>this is not applicable on SMP / multicore systems. Those tend to have
>>unsynchronised and drifting TSCs. So if the first picture was taken on
>>one CPU and the second on some other...
>=20
>=20
> Unfortunately I can not arguee on that for now since I know almost noth=
ing=20
> about SMP systems. I'll take a look on the topic and hopely soon I'll r=
eturn=20
> you what I think about it.
>=20
>=20
>>>I'm not talking especifically about this application, but giving you a
>>>general idea of what is not possible to do currently with RTDM if the
>>>application set the timer to periodic.
>>
>>And as I have this general view in mind, I want to avoid that the TSC
>>issue gets exported via RTDM drivers to the user. That's already
>>problematic for the other skins, but having to write special notes all
>>over the documentation of dozens of driver using mixed clocks would be
>>very unhandy.
>=20
>=20
> I don't understand why adding a new function like this would change a l=
ot the=20
> documentation. I really can not see your worries... If you could give m=
e a=20
> practical example, maybe it would be easier for me...
>=20
>=20
>>I see the need for having a high-resolution timestamp aside a
>>low-overhead and low-resolution timer now,=20
>=20
>=20
> good, got an ally. ;)
>=20
>=20
>>and I think we need to look=20
>>for a way to avoid its negative sides.
>=20
>=20
> First I need to understand better what exactly are the negative sides..=
.
>=20
>=20
>>Not sure yet if it will be=20
>>feasible, but I will come up with a new thread on this topic soon...
>=20
>=20
> Yes, I've seen. I'll discuss next messages there.
>=20
> Thank you,
>=20
> Rodrigo.
>=20
> =09
>=20
> =09
> 	=09
> _______________________________________________________=20
> Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
> http://br.yahoo.com/homepageset.html=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20


--=20

Philippe.

