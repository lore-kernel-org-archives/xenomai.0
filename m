Date: Thu, 2 May 2019 09:45:59 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1702513142.9141275.1556808359044.JavaMail.zimbra@wolfram.com>
In-Reply-To: <4c3b2a42-de26-2180-d0ba-299593462265@alaxarxa.net>
References: <f4d38a1b-0676-fc70-e42e-c07bc2c98cb0@alaxarxa.net>
 <CALLqZ8QGLU56XY4YDj-QkOKjLp6bGucURc1DASPQ_7GQ-rSd4g@mail.gmail.com>
 <4c3b2a42-de26-2180-d0ba-299593462265@alaxarxa.net>
Subject: Re: [Xenomai] called regular poll() rtdm-socket
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: Greg Gallagher <greg@embeddedgreg.com>, xenomai <xenomai@xenomai.org>

----- Den 2 maj 2019, p=C3=A5 kl 16:39, xenomai xenomai@xenomai.org skrev:

> El 2/5/19 a les 16:28, Greg Gallagher ha escrit:
> > On Thu, May 2, 2019 at 10:07 AM Leopold Palomo-Avellaneda via Xenomai
> > <xenomai@xenomai.org> wrote:

> >> Hi,


> >> we developed a C++ library that used rtnet with ethercat. It implement=
s a class
> >> that interchange information between the RT and NON_RT using xddm. It =
was
> >> working but now (using POSIX skin) fails and I several (less than 10) =
and got
> >> this message.

> >> [Xenomai] platformnode[8324] called regular poll() on /dev/rtdm/[rtdm-=
socket]

> >> Could you explain me what is it? because I have searched on web and wh=
at I found
> >> I didn't understand well.


> > From my understanding, this means you are talking to the RTDM driver
> > with a non RT thread. I don't think Xenomai has a poll system call.
> > Can you check if the thread that is causing this is in the primary
> > domain?


> AFAIK yes ... but checking. It's C++ code that uses native and rt_task.

> Leopold

> --
> --
> Linux User 152692 GPG: 05F4A7A949A2D9AA
> Catalonia
> -------------------------------------
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?

What do you mean with "It was working but now (using POSIX skin) fails". Di=
d it stop working when you switched to posix? I am doing network communicat=
ion with RTNet using the POSIX skin and two things that usually bite me are=
:=20

1) Compilation flags
2) Mixing RTNet with non RTNet in the same code-base.

Per =C3=96berg=20

