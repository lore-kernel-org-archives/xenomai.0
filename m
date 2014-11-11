From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Tue, 11 Nov 2014 17:33:55 +0000
Message-ID: <b258eccb6b124aaf91fd1b35c9ccbf30@EX132MBOX1B.de2.local>
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>,
 <20141110124308.GK17476@sisyphus.hd.free.fr>
In-Reply-To: <20141110124308.GK17476@sisyphus.hd.free.fr>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
Hi Gilles,=0A=
=0A=
> Also, for the "scheduling while atomic", it may happen if you call=0A=
> some Linux service which reschedules from primary mode, you can try=0A=
> enabling I-pipe debugging, and in fact all Xenomai debugging, to try=0A=
> and catch such mistakes. This is especially important if you are=0A=
> running a custom skin.=0A=
=0A=
you are completely right, we have implemented our own skin. Using=0A=
the debugging functionality mentioned above we have identified a=0A=
function-call that leads to exact the behaviour as described in your post.=
=0A=
=0A=
Hopefully solving that issue solves our application crash.=0A=
=0A=
Thanks for your fast and helpful support!=0A=
=0A=
Regards,=0A=
Christoph=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
Von: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>=0A=
Gesendet: Montag, 10. November 2014 13:43=0A=
An: Stoidner, Christoph=0A=
Cc: xenomai@xenomai.org=0A=
Betreff: Re: [Xenomai] "inconsistent lock state" on boot-up=0A=
=0A=
On Mon, Nov 10, 2014 at 09:08:47AM +0000, Stoidner, Christoph wrote:=0A=
>=0A=
> Hi Gilles,=0A=
>=0A=
> > Do you have the same message with exactly the same kernel=0A=
> > configuration, only with CONFIG_XENOMAI and CONFIG_IPIPE disabled?=0A=
>=0A=
> When CONFIG_XENOMAI and CONFIG_IPIPE are disabled the message does not=0A=
> appear on boot-up.=0A=
>=0A=
> > Do you have FCSE enabled? If yes, did you try disabling it? same=0A=
> > with unlocked context switch.=0A=
>=0A=
> FCSE is already disabled at all.=0A=
>=0A=
> Do you have an idea how to overcome the problem?=0A=
=0A=
I am not sure the lockdep message really is a problem. lockdep could=0A=
be confused by the fact that the hardware interrupts are not off=0A=
when running the I-pipe, or because we are missing some bit in the=0A=
I-pipe arm specific code to get it looking at the virtual mask=0A=
instead of the hardware mask.=0A=
=0A=
As for the scheduling while atomic and random segmentation fault,=0A=
you should use the I-pipe tracer, configure it with enough back=0A=
trace points, something like 1000 or 10000, and trigger a trace=0A=
freeze in the kernell code when the problem happens.=0A=
=0A=
Also, for the "scheduling while atomic", it may happen if you call=0A=
some Linux service which reschedules from primary mode, you can try=0A=
enabling I-pipe debugging, and in fact all Xenomai debugging, to try=0A=
and catch such mistakes. This is especially important if you are=0A=
running a custom skin.=0A=
=0A=
--=0A=
                                            Gilles.=0A=

