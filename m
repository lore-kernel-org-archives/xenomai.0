From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <CALLqZ8RMbYDFnQy5gV7-vSi_v9rUPx9i3XJ4ym7JQ-+x64q+3Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 16 Oct 2020 09:14:38 +0200
MIME-Version: 1.0
Message-ID: <1176-5f894880-11d-12dbaa60@116733711>
Subject: =?utf-8?q?Re=3A?= Strange switching =?utf-8?q?=5Bthreadname=5D?= to 
 secondary mode after exception #0 in kernel-space at 0x80272444
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?q?Xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

Le Mercredi, Octobre 14, 2020 16:16 CEST, Greg Gallagher <greg@embedded=
greg.com> a =C3=A9crit: 
 
> On Wed, Oct 14, 2020 at 5:37 AM Jan Kiszka <jan.kiszka@siemens.com> w=
rote:
> >
> > On 14.10.20 10:43, Fran=C3=A7ois Legal via Xenomai wrote:
> > > Anybody can help on this ?
> > >
> >
> > I'm unfortunately not familiar with the armv7 details of copy-from-=
user,
> > not too speak of how spectre contributed to it. Greg, Philippe, did=
 you
> > come across this already?
> >
> > Jan
> >
> I'll take a look tonight but I haven't hit this in my testing.  This
> was found on 4.4? Have you tried the 4.19 kernels?
> 
> -Greg
 
So I tried the same case on 4.19.121, with the same result, and I guess=
 for the same reason.
Could anybody explain why, on ARMv7, we need to copy the message header=
 at the syscall entry, and not let the xxxmsg routine do it on its own =
?
Also, I could not find how those COBALT=5FSYSCALL32emu logic work. Can =
anybody point me to some documentation ?

Thanks

Fran=C3=A7ois


