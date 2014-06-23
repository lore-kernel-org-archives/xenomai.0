From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Mon, 23 Jun 2014 09:33:15 +0000
Message-ID: <39ed57fee9f445d995e8d17a267c2fa0@EX132MBOX1B.de2.local>
References: <006d01cf8a3c$dee76050$9cb620f0$@caustier.com>
 <b9cc483bf98d4ce2a161d788d7d7abc0@EX132MBOX1B.de2.local>,
 <53A4201D.8020507@xenomai.org>
In-Reply-To: <53A4201D.8020507@xenomai.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Some Information About compilation Xenomai and RT
 Patches
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
Hi Gilles,=0A=
=0A=
when a userspace application starts it calls the brk() syscall to enlarge i=
t's heap space. In some cases the call leads to an NOMEM error in fcse_chec=
k_mmap_addr(). Since glibc does not handle NOMEM error at this place the a =
segfault exception appears.=0A=
=0A=
It seems as this happens when brk() got an address above some limit, also w=
hen the process at all consumes less than 32MB RAM. E.g. busybox shell comm=
and "ls" is enough to get the segfault.=0A=
=0A=
Regards,=0A=
Christoph=0A=
=0A=
=0A=
________________________________________=0A=
Von: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>=0A=
Gesendet: Freitag, 20. Juni 2014 13:50=0A=
An: Stoidner, Christoph; xenomai@xenomai.org=0A=
Betreff: Re: [Xenomai] Some Information About compilation Xenomai and RT Pa=
tches=0A=
=0A=
On 06/20/2014 11:02 AM, Stoidner, Christoph wrote:=0A=
> My pending problem which I hope to solve soon is the fast context=0A=
> switch extension (FCSE) that allows better latency times on ARM9. In=0A=
> "guaranteed" mode it crashs when using addresses above 32MB.=0A=
=0A=
What do you mean it crashes? Normally, an mmap call that would return=0A=
addresses above 32MB simply fails, because you can not use addresses=0A=
above 32MB in guaranteed mode.=0A=
=0A=
--=0A=
                                                                Gilles.=0A=

