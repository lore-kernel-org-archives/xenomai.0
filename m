From: Dirk Roloff <roloff@domain.hid>
Subject: Re: [Adeos-main] 260 uSec latency and no idea why
Date: Fri, 12 Mar 2004 04:22:44 +0100
References: <200403110326.33694.roloff@domain.hid> <4050B841.9030902@domain.hid>
In-Reply-To: <4050B841.9030902@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200403120422.44317.roloff@domain.hid>
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
To: adeos-main@gna.org

Am Donnerstag, 11. M=E4rz 2004 20:04 schrieb Paolo Mantegazza:

Hi Paolo,

> Dirk Roloff wrote:
> Have you tried using rt_get_cpu_time_ns to avoid mixing up with Linux
> stuff?=20


No i don't because i am not using rtai. I "just" use an adeos patched kerne=
l.
But i changed the do_gettimeofday() by a rdtsc call. I dont want to know th=
e time,
just the time elapsed. So i dont need the time calculation done by do_getti=
meofday()
and i avoid mixing stuff. But the results are the same. :-(

>Have you checkd the interrupt level acknolwdge jitter/latency using
> the calibration tool available in RTAI?

again - no rtai

> Can you change your code so that it can be used anywhere? In such a case
> it would be simple to run it on a safe machine (e.g. mine) and see if it
> can be repeated, or is machine specific (yours).

Yes but it will not help a lot. I can't see such a latency on other machine=
s.
f.e. on my Box here at home 7-17 MicroSec in the adeos domain.
And i try stressing the Box- but its a complete different h/ware.

So it must be the celeron box or some kernel/compiler settings on it.

But what is able to delay the delivery of an interrupt if there is no one=20
calling cli or masking irq's (Both is prohibited by adeos isn't it ?)

One thing would be waking a suspended cpu - but i disabled APM.
Someone told me Intel SpeedStep switching the mode will take hundrets of Mi=
croSecs
but i didn't find what this is yet. Have to google some more.

Dirk.


