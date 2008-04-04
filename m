Message-ID: <2ff1a98a0804040848w44037164n18ea4d61f38ffa51@domain.hid>
Date: Fri, 4 Apr 2008 17:48:08 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47F63C37.60307@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>
	<47F551AD.9030509@domain.hid> <47F5E57C.6020309@domain.hid>
	<47F606AE.6080800@domain.hid>
	<2ff1a98a0804040618r2717c5efrb852bcbc76e6bd0c@domain.hid>
	<47F62C46.4080003@domain.hid>
	<2ff1a98a0804040632w391afda4rf30c8ca09fbb0874@domain.hid>
	<47F633B7.70003@domain.hid>
	<2ff1a98a0804040709m51a8db6lc23e1714497f824c@domain.hid>
	<47F63C37.60307@domain.hid>
Subject: Re: [Xenomai-core] latencys drifting into negative (Xenomai
	2.4.2/2.4.3)
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
Cc: xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

On Fri, Apr 4, 2008 at 4:33 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
>
> > Right. We are approximating a fraction with another fraction. But my
> > first impression remains: I do not like the idea of making
> > xnarch_ns_to_tsc wrong because xnarch_tsc_to_ns is wrong.
> >
>
>  Well, my first impression was originally the same: If we still need llimd
> in the ns-to-tsc patch, then we should keep the precise way. But that was
> wrong as this thread demonstrated. We have to ensure that
> ns_to_tsc(tsc_to_ns(x)) remains x with only minor last-digit errors. So
> either use scaled math parameters in both ways or fall back to the original
> calculation.

Now that I think about it, this scaled math approach is about taking
an approximation of the CPU frequency, which is already approximative.
So, I will not oppose longer to your patch.

>
>  However the final decision for 2.5 is (pro or contra scaled math), at least
> for 2.4.x we have to fix things now without turning the upside down. That
> means apply my patch or revert scaled-math optimizations for all archs.



-- 
 Gilles

