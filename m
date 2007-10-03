Message-Id: <200710030833.l938XebW026800@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Wed, 3 Oct 2007 10:33:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2ff1a98a0710030022k3227b0b4g577085f802658e2a@domain.hid>
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

Yes, the timer work !

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9=A0: mercredi, 3. octobre 2007 09:22
=C0=A0: Patrick
Cc=A0: xenomai@xenomai.org
Objet=A0: Re: [Xenomai-help] rt_task crash kernel

On 10/3/07, Patrick <kpa_info@domain.hid> wrote:
>
> No I have not a JTAG probe.
>
> But I found that the system crashes when the xnlock_put_irqrestore
function
> is called in the task.c file at (in rt_task_create function).

Ok, next step is to put a printk (or better a printascii) in the tick
handler to check if the timer interrupt is ticking ?

--=20
                                               Gilles Chanteperdrix


