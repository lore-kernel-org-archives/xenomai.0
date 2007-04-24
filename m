Message-ID: <462E059A.2010607@domain.hid>
Date: Tue, 24 Apr 2007 15:26:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <403B28AE6257B548B66BB88414AC78330174BBDF@STEGOSAURE.adetel.com>
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BBDF@STEGOSAURE.adetel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-Printable
Subject: Re: [Adeos-main] New patch for AT91SAM9261 adeos support for 2.6.19
 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main@gna.org

BOUIN Alexandre wrote:
>>It is a high.
>=20
> by default, nucleus latency is set to 9342. I can diminish this value
> to 323=B5s only. Is it possible I've done something wrong ? Is there
> another way to reduce theses latencies ?
>=20

The latency value is a value in nanoseconds, so 9342 is 9us. It is a
value used by the nucleus to compensate for the systematic latency of
your system. Usually, I set it to approximately the minimum value
returned by latency (plus the current value of the latency) minus a
small saftety margin, so that latency minimum value is close to 0 and I
do not get negative values.

>=20
>>You should get plenty of negative values.
>=20
> I've sent you my histogram and I don't see any negative value.
> Could you precise what was your thought ?

Look at the code:
static inline void add_histogram(long *histogram, long addval)
{
        /* bucketsize steps */
        long inabs =3D
            rt_timer_tsc2ns(addval >=3D 0 ? addval : -addval) / bucketsiz=
e;
        histogram[inabs < histogram_size ? inabs : histogram_size - 1]++;
}

So, you will never see a negative value in the histogram.


>=20
>=20
>>What is your kernel configuration, do not you have some
>=20
> statistics/debug options enabled ?
> It is right : I've let some kernel debug options while performing these=
 tests.
> I change it right now.=20

I was thinking about Xenomai debug/statistics option. Xenomai nucleus
statistics collection, for instance, is enabled by default and should be
disabled for best performance. Check also that you did not enable
Xenomai debug options, or the I-pipe tracer.

>=20
> Test was launched without any kernel debug options, and we got a worst
> case of 197=B5s now.
> Here is a sum up of our results :=20
> [Board] : 			 AT91SAM9261EK
> [Kernel version] : 	 2.6.19-at91-xenomai-adeos
> [Clocks] : 			 CPU 198 MHz, master 99 MHz, main 18.432 MHz
> [Nucleus latency] : 	 323=B5s
> [Root] : 			 nfs
> [Kernel debug options] : No
> [Load Softwares] :	 calibrator + ping host + bonnie++
> [Duration] : 		 > 15h
> [Best Latency] : 		 45=B5s
> [Average Latency] : 	 82.5=B5s
> [Worst Latency] : 	 197=B5s

The best way to give us all the useful informations about your platform
and configuration is to use the xeno-test script. Sorry I did not
mention this earlier. You will have to use the -W option to use your
custom load generation script.

--=20
                                                 Gilles Chanteperdrix

