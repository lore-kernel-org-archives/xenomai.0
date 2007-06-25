MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18048.2782.400727.660810@domain.hid>
Date: Mon, 25 Jun 2007 20:35:10 +0200
In-Reply-To: <467FD25B.1040607@domain.hid>
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>
	<467D0684.7030604@domain.hid> <1182623858.6000.139.camel@domain.hid>
	<467E2E9C.90905@domain.hid> <1182708919.7044.201.camel@domain.hid>
	<467F5CBF.9040108@domain.hid>
	<18047.40395.671989.328415@domain.hid>
	<467F9FE5.1070205@domain.hid> <467FD25B.1040607@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > +/* Timer operation modes */
 > +typedef enum xntimer_mode {
 > +	XNTM_MONOREL =3D 0,
 > +	XNTM_MONOABS =3D XNTIMER_ABSOLUTE,
 > +	XNTM_REALABS =3D XNTIMER_REALTIME | XNTIMER_ABSOLUTE
 > +} xntimer_mode_t;

Is not it a bit weird to use enums ? I mean=E7 we use #defines everywhere
else.

 > +	default: /* XNTM_MONOABS || XNTM_REALABS */
 >  		date =3D xnarch_ns_to_tsc(value);
 >  		if (date <=3D now)
 >  			return -ETIMEDOUT;
 > +		__setbits(timer->status, XNTIMER_REALTIME);
 > +		break;

Having the same treatment for absolute monotonic and realtime clocks
looks suspicious.


 > +	default: /* XNTM_MONOABS || XNTM_REALABS */
 >  		if (value <=3D timer->base->jiffies)
 >  			return -ETIMEDOUT;
 > +		__setbits(timer->status, XNTIMER_REALTIME);
 > +		break;

Same here


--=20


					    Gilles Chanteperdrix.

