From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Mon, 10 Nov 2014 12:33:40 +0000
Message-ID: <c9fed148f1f54c4aaa2aaa5d7b107f24@EX132MBOX1B.de2.local>
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>,
 <20141109155351.GH17476@sisyphus.hd.free.fr>,
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
In-Reply-To: <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
Hi again,=0A=
=0A=
now I have disabled CONFIG_XENOMAI but still enabled CONFIG_IPIPE. The erro=
r messages on boot-up is still given.=0A=
=0A=
Since no one else has reported that problem I assume it happens only on a s=
pecific architecture (for me: i.MX28 =3D> ARMv5). Is there something ARMv5 =
architecture specific in ipipe's locking mechanism?=0A=
=0A=
Regards,=0A=
Christoph=0A=
=0A=
________________________________________=0A=
Von: Xenomai <xenomai-bounces@xenomai.org> im Auftrag von Stoidner, Christo=
ph <c.stoidner@arvero.de>=0A=
Gesendet: Montag, 10. November 2014 10:08=0A=
An: xenomai@xenomai.org=0A=
Betreff: Re: [Xenomai] "inconsistent lock state" on boot-up=0A=
=0A=
Hi Gilles,=0A=
=0A=
> Do you have the same message with exactly the same kernel=0A=
> configuration, only with CONFIG_XENOMAI and CONFIG_IPIPE disabled?=0A=
=0A=
When CONFIG_XENOMAI and CONFIG_IPIPE are disabled the message does not=0A=
appear on boot-up.=0A=
=0A=
> Do you have FCSE enabled? If yes, did you try disabling it? same=0A=
> with unlocked context switch.=0A=
=0A=
FCSE is already disabled at all.=0A=
=0A=
Do you have an idea how to overcome the problem?=0A=
=0A=
Regards,=0A=
Christoph=0A=
=0A=
________________________________________=0A=
Von: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>=0A=
Gesendet: Sonntag, 9. November 2014 16:53=0A=
An: Stoidner, Christoph=0A=
Cc: xenomai@xenomai.org=0A=
Betreff: Re: [Xenomai] "inconsistent lock state" on boot-up=0A=
=0A=
On Sun, Nov 09, 2014 at 10:07:54AM +0000, Stoidner, Christoph wrote:=0A=
> Hi at all,=0A=
>=0A=
> I am using linux 3.10.32 and ipipe-core-3.10.32-arm-4.patch on a=0A=
> Freescale i.MX28.=0A=
>=0A=
> When booting the kernel the message "inconsistent lock state" is=0A=
> given (see below). Does anyone have an idea why this happens? With=0A=
> kernel 3.10.18 and according ipipe it is the same. With linux=0A=
> 3.4.6 and ipipe 3.4.6-arm-4 the message does not appear.=0A=
=0A=
Do you have the same message with exactly the same kernel=0A=
configuration, only with CONFIG_XENOMAI and CONFIG_IPIPE disabled?=0A=
=0A=
>=0A=
> I am very interested to understand if these message could lead to=0A=
> any problems, since I have I unpredictable crashes of my=0A=
> xenomai-based application program (e.g. with "segmentation fault"=0A=
> or "scheduling while atomic" messages).=0A=
=0A=
Do you have FCSE enabled? If yes, did you try disabling it? same=0A=
with unlocked context switch.=0A=
=0A=
--=0A=
                                            Gilles.=0A=
=0A=
_______________________________________________=0A=
Xenomai mailing list=0A=
Xenomai@xenomai.org=0A=
http://www.xenomai.org/mailman/listinfo/xenomai=0A=

