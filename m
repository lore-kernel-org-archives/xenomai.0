Message-ID: <40520537.2030701@domain.hid>
Date: Fri, 12 Mar 2004 10:45:11 -0800
From: Paolo Mantegazza <mantegazza@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] 260 uSec latency and no idea why
References: <200403110326.33694.roloff@domain.hid> <4050B841.9030902@domain.hid> <200403120422.44317.roloff@domain.hid>
In-Reply-To: <200403120422.44317.roloff@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Dirk Roloff <roloff@domain.hid>
Cc: adeos-main@gna.org

Dirk Roloff wrote:
> Am Donnerstag, 11. M=E4rz 2004 20:04 schrieb Paolo Mantegazza:
>=20
> Hi Paolo,
>=20
>=20
>>Dirk Roloff wrote:
>>Have you tried using rt_get_cpu_time_ns to avoid mixing up with Linux
>>stuff?=20
>=20
>=20
>=20
> No i don't because i am not using rtai. I "just" use an adeos patched k=
ernel.
> But i changed the do_gettimeofday() by a rdtsc call. I dont want to kno=
w the time,
> just the time elapsed. So i dont need the time calculation done by do_g=
ettimeofday()
> and i avoid mixing stuff. But the results are the same. :-(
>=20
>=20
>>Have you checkd the interrupt level acknolwdge jitter/latency using
>>the calibration tool available in RTAI?
>=20
>=20
> again - no rtai
>=20
>=20
>>Can you change your code so that it can be used anywhere? In such a cas=
e
>>it would be simple to run it on a safe machine (e.g. mine) and see if i=
t
>>can be repeated, or is machine specific (yours).
>=20
>=20
> Yes but it will not help a lot. I can't see such a latency on other mac=
hines.
> f.e. on my Box here at home 7-17 MicroSec in the adeos domain.
> And i try stressing the Box- but its a complete different h/ware.
>=20
> So it must be the celeron box or some kernel/compiler settings on it.
>=20
> But what is able to delay the delivery of an interrupt if there is no o=
ne=20
> calling cli or masking irq's (Both is prohibited by adeos isn't it ?)
>=20
> One thing would be waking a suspended cpu - but i disabled APM.
> Someone told me Intel SpeedStep switching the mode will take hundrets o=
f MicroSecs
> but i didn't find what this is yet. Have to google some more.
>=20

On some of the newest PC chipsets there seems to be a lot of=20
possibilities to programm chipsets so that real time bocomes unfeasable. =

The locking of the bus may come from smart cards and a few other things. =

You are not using RTAI but in RTAI there is a README with a way to=20
reprogram INTEL chipsets to avoid one of those problems.

Paolo.


