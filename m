Message-ID: <1488265954.3849.8.camel@smigroup.net>
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Tue, 28 Feb 2017 08:12:34 +0100
In-Reply-To: <CAEMXjGxGnjER66=8cKHZwY=ay0DJtKwb=t0HVScDK5GpcSsb7g@mail.gmail.com>
References: <58a70af0.cf0d1c0a.74142.a8ca@mx.google.com>
 <06614ad5-4dd0-45f2-2281-054b3e5621c9@xenomai.org>
 <CAEMXjGxGnjER66=8cKHZwY=ay0DJtKwb=t0HVScDK5GpcSsb7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: Steve B <sbattazzo@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Another way to do this is to configure kernel with CPU_FREQ on and with
all frequency governors disabled except the performance one, or if you
prefer with all governors enabled and performance one set as default
governor (instead on-demand).
Kernel will boot with default frequency and will change it to the
maximum only one time during boot process, when cpufreq driver will be
loaded.

On Mon, 2017-02-27 at 11:38 -0800, Steve B wrote:
> In my application, turning CPU_FREQ off defaulted the CPU to a frequenc=
y
> that we didn't want (we wanted 100% but it for some reason set us to  a
> lower one). The other problem is that in some cases our application wou=
ld
> intermittently freak out and lock things up if the frequency changed in=
 the
> background.
>=20
> What I did was leave the frequency scaling on, and then I went into the
> device tree and removed all of the options except the one we wanted.
> Depending on how your OS distribution is set up you may be able to do t=
he
> same!
>=20
> Steve
>=20
>=20
> On Fri, Feb 17, 2017 at 7:24 AM, Philippe Gerum <rpm@xenomai.org> wrote=
:
>=20
> > On 02/17/2017 03:38 PM, mobin.motallebizadeh@gmail.com wrote:
> > > Hi
> > > As we are disabling CPU_FREQ system consumes as much energy as it c=
an
> > and it=E2=80=99s undesirable.
> > >
> > > Is there any method to set cpu clock freq to something other than 1=
00%?
> > >
> > > Something like letting CPU_FREQ=3Dy and setting clock freq manually=
 by
> > cpufreq utility and then re-calibrate the cobalt core. I don=E2=80=99=
t know. Just
> > guessing!
> >
> > There is no provision for this.
> >
> > --
> > Philippe.
> >
> > _______________________________________________
> > Xenomai mailing list
> > Xenomai@xenomai.org
> > https://xenomai.org/mailman/listinfo/xenomai
> >
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


