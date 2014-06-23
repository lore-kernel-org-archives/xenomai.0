From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Mon, 23 Jun 2014 10:04:37 +0000
Message-ID: <d54dc4eae894479c9a58f8d173d1c7cb@EX132MBOX1B.de2.local>
References: <006d01cf8a3c$dee76050$9cb620f0$@caustier.com>
 <b9cc483bf98d4ce2a161d788d7d7abc0@EX132MBOX1B.de2.local>,
 <53A4201D.8020507@xenomai.org>
 <39ed57fee9f445d995e8d17a267c2fa0@EX132MBOX1B.de2.local>,
 <53A7F900.4020103@xenomai.org>
In-Reply-To: <53A7F900.4020103@xenomai.org>
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
Original ipipe-3.10.18 without Preempt-RT works without any problem. The pr=
oblem occurs only in combination of my Preempt-RT merge and enabled FCSE in=
 guaranteed mode.=0A=
=0A=
Since unmodified ipipe-3.10 does not show the problem I assume unmodified i=
pipe-3.14 also does not show the problem. Or do you think 3.14 brings some =
more details?=0A=
=0A=
Regards,=0A=
Christoph=0A=
=0A=
________________________________________=0A=
Von: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>=0A=
Gesendet: Montag, 23. Juni 2014 11:53=0A=
An: Stoidner, Christoph; xenomai@xenomai.org=0A=
Betreff: Re: [Xenomai] Some Information About compilation Xenomai and RT Pa=
tches=0A=
=0A=
On 06/23/2014 11:33 AM, Stoidner, Christoph wrote:=0A=
>=0A=
> Hi Gilles,=0A=
>=0A=
> when a userspace application starts it calls the brk() syscall to=0A=
> enlarge it's heap space. In some cases the call leads to an NOMEM=0A=
> error in fcse_check_mmap_addr(). Since glibc does not handle NOMEM=0A=
> error at this place the a segfault exception appears.=0A=
>=0A=
> It seems as this happens when brk() got an address above some limit,=0A=
> also when the process at all consumes less than 32MB RAM. E.g.=0A=
> busybox shell command "ls" is enough to get the segfault.=0A=
=0A=
Could you test the I-pipe git branch ipipe-3.14, unmodified?=0A=
=0A=
--=0A=
                                                                Gilles.=0A=

