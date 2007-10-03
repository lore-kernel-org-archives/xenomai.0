Message-Id: <200710031119.l93BJc9k013826@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Wed, 3 Oct 2007 13:19:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2ff1a98a0710030144k70633250k2a98079cdcb879f7@domain.hid>
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
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

It's not possible to test this case because adding printk in tick =
handler
saturates the console with messages and it's impossible to work and the
target boot very, very slow.=20

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9=A0: mercredi, 3. octobre 2007 10:45
=C0=A0: Patrick
Cc=A0: xenomai@xenomai.org
Objet=A0: Re: [Xenomai-help] rt_task crash kernel

On 10/3/07, Patrick <kpa_info@domain.hid> wrote:
> Yes, the timer work !

Even when the system seems to be locked up when running latency ?

--=20
                                               Gilles Chanteperdrix


