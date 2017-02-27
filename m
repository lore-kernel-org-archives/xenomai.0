MIME-Version: 1.0
In-Reply-To: <06614ad5-4dd0-45f2-2281-054b3e5621c9@xenomai.org>
References: <58a70af0.cf0d1c0a.74142.a8ca@mx.google.com>
 <06614ad5-4dd0-45f2-2281-054b3e5621c9@xenomai.org>
From: Steve B <sbattazzo@gmail.com>
Date: Mon, 27 Feb 2017 11:38:36 -0800
Message-ID: <CAEMXjGxGnjER66=8cKHZwY=ay0DJtKwb=t0HVScDK5GpcSsb7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Set CPU Clock Frequency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

In my application, turning CPU_FREQ off defaulted the CPU to a frequency
that we didn't want (we wanted 100% but it for some reason set us to  a
lower one). The other problem is that in some cases our application would
intermittently freak out and lock things up if the frequency changed in the
background.

What I did was leave the frequency scaling on, and then I went into the
device tree and removed all of the options except the one we wanted.
Depending on how your OS distribution is set up you may be able to do the
same!

Steve


On Fri, Feb 17, 2017 at 7:24 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 02/17/2017 03:38 PM, mobin.motallebizadeh@gmail.com wrote:
> > Hi
> > As we are disabling CPU_FREQ system consumes as much energy as it can
> and it=E2=80=99s undesirable.
> >
> > Is there any method to set cpu clock freq to something other than 100%?
> >
> > Something like letting CPU_FREQ=3Dy and setting clock freq manually by
> cpufreq utility and then re-calibrate the cobalt core. I don=E2=80=99t kn=
ow. Just
> guessing!
>
> There is no provision for this.
>
> --
> Philippe.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
