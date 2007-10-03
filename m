Message-ID: <2ff1a98a0710030518n238b497ehd1751a610bf4a17e@domain.hid>
Date: Wed, 3 Oct 2007 14:18:55 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710031119.l93BJc9k013826@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <2ff1a98a0710030144k70633250k2a98079cdcb879f7@domain.hid>
	<200710031119.l93BJc9k013826@domain.hid>
Subject: Re: [Xenomai-help] rt_task crash kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

On 10/3/07, Patrick <kpa_info@domain.hid> wrote:
> It's not possible to test this case because adding printk in tick handler
> saturates the console with messages and it's impossible to work and the
> target boot very, very slow.

You can do something like:

static int ticks;

if (!(++ticks % 1000))
    printk("%d ticks\n", ticks);

Which will only print something once every 1000 ticks.

>
> -----Message d'origine-----
> De: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Envoy=E9: mercredi, 3. octobre 2007 10:45
> =C0: Patrick
> Cc: xenomai@xenomai.org
> Objet: Re: [Xenomai-help] rt_task crash kernel
>
> On 10/3/07, Patrick <kpa_info@domain.hid> wrote:
> > Yes, the timer work !
>
> Even when the system seems to be locked up when running latency ?
>
> --
>                                                Gilles Chanteperdrix
>
>


--=20
                                               Gilles Chanteperdrix

