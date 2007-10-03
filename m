Message-Id: <200710031318.l93DI2g6007476@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Wed, 3 Oct 2007 15:18:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
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
To: xenomai@xenomai.org

Ok, some messages occur on the console with latency.

For information I have successfully installed and used Xenomai 2.3.1 =
with
2.6.15 kernel on the same board.=20

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9=A0: mercredi, 3. octobre 2007 14:19
=C0=A0: Patrick
Cc=A0: xenomai@xenomai.org
Objet=A0: Re: [Xenomai-help] rt_task crash kernel

On 10/3/07, Patrick <kpa_info@domain.hid> wrote:
> It's not possible to test this case because adding printk in tick =
handler
> saturates the console with messages and it's impossible to work and =
the
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


