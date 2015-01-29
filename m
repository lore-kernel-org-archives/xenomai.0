Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Kevin Kasal <kevin@kasal.at>
In-Reply-To: <CAHH_qdB0SL01DFidmSQ96YSOoGxpuNLTWoO87K-q6mEA-fM-Rg@mail.gmail.com>
Date: Thu, 29 Jan 2015 12:14:03 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <063428AC-6B32-4EE4-B2BB-58F79BABAA5F@kasal.at>
References: <CAHH_qdB0SL01DFidmSQ96YSOoGxpuNLTWoO87K-q6mEA-fM-Rg@mail.gmail.com>
Subject: Re: [Xenomai] imx28 linux 3.10.32 + ipipe v7 + GPIO IRQ machine
	freeze
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gautier HAOUY <gautier.haouy@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>




> On 29 Jan 2015, at 09:46, Gautier HAOUY <gautier.haouy@gmail.com> wrote:
>=20
> Hello everyone,
>=20
> I am kindly requesting your help today as I am facing a complete freeze on=

> an Freescale iMX28 based board (armadeus APF28-Dev).
> I have developed a very simple kernel module which registers a GPIO
> interrupt handler, working properly on linux 3.10.32 kernel.
> The same code, compiled on a 3.10.32 + ipipe7 (also tested on ipipe v4)
> patched kernel generates a machine freeze on IRQ reception, without messag=
e
> and any other possibility than resetting the board.
>=20
> I would appreciate any help/hint/procedure I could use to dive into the
> problem and solve it.
> Hoping to help others afterwards,
> Best regards,
> G0TieR.
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

Hi,=20
this is my first post to this mailing list, but I had a similar problem a fe=
w weeks ago. In my case i simply forgot to acknowledge the interrupt (cleari=
ng the proper bit in the register), which lead to an infinite loop (interrup=
t triggers -> interrupt returns -> interrupt triggers again) . So I would sa=
y, that you just take away all the processing power with your interrupt. If y=
ou want, you can verify this with toggling an gpio pin in your interrupt wit=
h an logic analyzer attached to the pin (at least, thats what i did)

best regards,
Kevin Kasal


