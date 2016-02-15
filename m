From: =?UTF-8?Q?Javier_Mart=c3=adnez_Cantos?= <jmartinez@ixion.es>
Message-ID: <56C1B8F1.5070506@ixion.es>
Date: Mon, 15 Feb 2016 12:39:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Unexpected CPU assignment on iMX6Q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everybody,

I'm currently working on Toradex Apalis iMX6Q (4 cores) with Xenomai=20
2.6.4. The system runs fine.

However, I'm playing around with rt_task_create and T_CPU obtaining the=20
following results:

- T_CPU(0-3) leads to task creation on expected core, i.e. 1 to 4,

- while T_CPU(>3) leads to task creation always on first core.

Affinity is configured as follows:

cat /proc/xenomai/affinity
0000000f

I expect rt_task_create to return an EINVAL error or something like that=20
when T_CPU is higher than RTHAL_NR_CPUS - 1.

Could RTHAL_NR_CPUS has a value higher than 4? How can I check this? I=20
have already checked that CONFIG_NR_CPUS is 4.

On runtime, how can I query the "task to core assignment" through=20
Xenomai API?

Thanks in advance.

--=20


Javier Mart=C3=ADnez Cantos

Sistemas embarcados



=09

Juli=C3=A1n Camarillo, 21 B, 3=C2=AA Planta 28037 Madrid, Espa=C3=B1a

=09

(+34) 91 440 18 33

=09

jmartinez@ixion.es

=09

http://www.ixion.es <http://www.ixion.es/>

-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------

/This message is intended solely for its addressee. It may contain=20
privileged and/or confidential information, whose disclosure is=20
prohibited by law. If you have received this message in error, please do=20
not read, copy or distribute it and notify the dispatcher immediately./

/
Este correo electr=C3=B3nico est=C3=A1 dirigido exclusivamente a su desti=
natario y=20
puede contener informaci=C3=B3n sujeta a reserva y/o confidencial, cuya=20
revelaci=C3=B3n est=C3=A1 prohibida por ley. Si Ud. ha recibido este mens=
aje por=20
error, le rogamos que no lo lea, copie o distribuya y que lo notifique=20
de inmediato a su remitente./



--=20


Javier Mart=C3=ADnez Cantos

Sistemas embarcados



=09

Juli=C3=A1n Camarillo, 21 B, 3=C2=AA Planta 28037 Madrid, Espa=C3=B1a

=09

(+34) 91 440 18 33

=09

jmartinez@ixion.es=20
<.////172.20.31.5/datos/IXION/Info_public/Logos/Nueva%2520imagen%2520corp=
orativa/Plantillas/xxxx@ixion.es%2520>

=09

http://www.ixion.es <http://www.ixion.es/>

-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------

/This message is intended solely for its addressee. It may contain=20
privileged and/or confidential information, whose disclosure is=20
prohibited by law. If you have received this message in error, please do=20
not read, copy or distribute it and notify the dispatcher immediately./

/
Este correo electr=C3=B3nico est=C3=A1 dirigido exclusivamente a su desti=
natario y=20
puede contener informaci=C3=B3n sujeta a reserva y/o confidencial, cuya=20
revelaci=C3=B3n est=C3=A1 prohibida por ley. Si Ud. ha recibido este mens=
aje por=20
error, le rogamos que no lo lea, copie o distribuya y que lo notifique=20
de inmediato a su remitente./



