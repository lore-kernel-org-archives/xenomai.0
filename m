Message-ID: <441EDD9B.20708@domain.hid>
Date: Mon, 20 Mar 2006 17:51:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>
	<441E9698.5080506@domain.hid>	<441EAD78.3030007@domain.hid>
	<200603201142.27591.lbocseg@domain.hid>
In-Reply-To: <200603201142.27591.lbocseg@domain.hid>
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
Cc: xenomai@xenomai.org

Rodrigo Rosenfeld Rosas wrote:
> Philippe Gerum wrote:
>=20
>>...
>>Given the description above, just that some skin might return either
>>nucleus ticks or corrected timestamps to the applications, which would
>>in turn do some arithmetics for converting values they got from the ski=
n
>>between both scales internally, and mistakenly use the result while
>>assuming that both scales are always in sync. In this situation, and
>>during a fraction of the time (i.e. the jitter), both scales might not
>>be in sync, and the result would be unusable.
>=20
>=20
> But I still can't find a real situation where the user would need these=
 values=20
> to be in sync...
>=20
>=20
>>...
>>But maybe we are still discussing different issues actually, so it woul=
d
>>be useful that the core issue that triggered the discussion about
>>periodic mode precision be exposed again.
>=20
>=20
> The core issue is that:
> I think the driver development should be kind of independent from the u=
ser=20
> programs. That said, if the driver needs a precise timestamp, it should=
 be=20
> able to get it, even if the user is fine with a, say, 100ms periodic ti=
ck. If=20
> the user have a loop with a deadline of 100ms, and if it takes two=20
> consecutive images for estimating speed in the same loop, the user will=
 need=20
> to have a higher precision timestamps for the images. So, the driver wi=
ll=20
> need a high precision timer reading for making possible to provide thos=
e=20
> timestamps...
>=20

This is exactely what rt_timer_tsc() or clock_gettime(CLOCK_MONOTONIC)=20
[or whatever ends up calling xnarch_get_cpu_tsc() from the underlying=20
architecture] are there for.

The thing is that rt_timer_read() is expected to return values=20
compatible with the timer mode, always. But rt_timer_tsc() is there to=20
return the most precise timestamp available from the underlying=20
architecture, regardless of the current timing mode. If no TSC exists on=20
x86, then it is going to be emulated (using the PIT's channel #2), but=20
in any case, you will get a high precision timestamp, up to the best=20
precision the architecture can provide, that is.

The key issue is to acknowledge the fact that periodic ticks and precise=20
timestamps are two _unrelated_ units. What I'm reluctant to is to try=20
finding some artificial binding between both units, because there is=20
none (being stable, that is).

In your example above, you would be able to estimate the elapsed time=20
using something like rt_timer_tsc(), and convert this to ticks using=20
rt_timer_ns2ticks(rt_timer_tsc2ns(timestamp)). The main problem would be=20
the rounding here, and work around the lack of precision the periodic=20
mode currently exhibits due to the constant delay between timer shots.

I think that you should try convincing Jan that rtdm_clock_tsc() might=20
be a good idea to provide, instead of tweaking rtdm_clock_read() in a=20
way which changes its underlying logic. ;o)


> I hope that was what you were asking for...
>=20
> Regards,
>=20
> Rodrigo.
>=20
> 	=09
> _______________________________________________________
> Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discad=
or agora!
> http://br.acesso.yahoo.com
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20


--=20

Philippe.

