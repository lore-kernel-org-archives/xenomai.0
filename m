Date: Fri, 2 Mar 2018 14:22:35 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180302142235.15671ecc@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <20180302132205.28807-1-henning.schild@siemens.com>
References: <20180302132205.28807-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH] cobalt/kernel: fix clock_adjtime() compile
	error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai @ xenomai . org" <xenomai@xenomai.org>

Applies on top of current "next".

Henning

Am Fri, 2 Mar 2018 14:22:05 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> Moving the definition out of the ifdef solves the following error:
>=20
> include/xenomai/cobalt/kernel/clock.h:260:16: error:
>  =E2=80=98struct <anonymous>=E2=80=99 has no member named =E2=80=98adjust=
_time=E2=80=99
> include/xenomai/cobalt/kernel/clock.h:263:19: error:
>  =E2=80=98struct <anonymous>=E2=80=99 has no member named =E2=80=98adjust=
_time=E2=80=99
>=20
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  include/cobalt/kernel/clock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/cobalt/kernel/clock.h
> b/include/cobalt/kernel/clock.h index bf03c5921..bbdec9357 100644
> --- a/include/cobalt/kernel/clock.h
> +++ b/include/cobalt/kernel/clock.h
> @@ -53,8 +53,6 @@ struct xnclock {
>  		xnticks_t (*read_monotonic)(struct xnclock *clock);
>  		int (*set_time)(struct xnclock *clock,
>  				const struct timespec *ts);
> -		int (*adjust_time)(struct xnclock *clock,
> -				   struct timex *tx);
>  		xnsticks_t (*ns_to_ticks)(struct xnclock *clock,
>  					  xnsticks_t ns);
>  		xnsticks_t (*ticks_to_ns)(struct xnclock *clock,
> @@ -66,6 +64,8 @@ struct xnclock {
>  		void (*program_remote_shot)(struct xnclock *clock,
>  					    struct xnsched *sched);
>  #endif
> +		int (*adjust_time)(struct xnclock *clock,
> +				   struct timex *tx);
>  		int (*set_gravity)(struct xnclock *clock,
>  				   const struct xnclock_gravity *p);
>  		void (*reset_gravity)(struct xnclock *clock);


