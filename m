Message-ID: <49A54246.60404@domain.hid>
Date: Wed, 25 Feb 2009 14:06:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <d7143fa7afb9637a602a432e52eb35b4@domain.hid>
In-Reply-To: <d7143fa7afb9637a602a432e52eb35b4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] [PATCH] ipipe i.MXL freeze's boot
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Gwenha=EBl wrote:
> With i.MXL processor, kernel patched with
> adeos-2.6.27-ipipe-1.12-00.patch wait indefinitly for timer
> calibration.
> Tick event never appear. This patch modify acktimer() in
> arch/arm/mach-imx/time.c.
>=20
> I need to know if this modification is good (without adding
> new errors).

ipipe_mach_update_tsc should be called from imx_timer_interrupt, so,
there is no need to call it from acktimer (and in fact, avoiding the
call to update_tsc in acktimer reduces the timer interrupt latency). So,
maybe what is needed and is missing is simply to read
IMX_TSTAT(TIMER_BASE) ?
--=20
                                                 Gilles.


