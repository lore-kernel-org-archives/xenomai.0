MIME-Version: 1.0
In-Reply-To: <55927557.3000208@web.de>
References: <CAJt3u5n2Ay=QSbR-jXtymMLTBWp263km_Q6ByPqqbJR2N179AA@mail.gmail.com>
 <CAJt3u5m6i63UPTG5gOC3L8qkgX_3aKW20u-LwSFDRKd=R5T__Q@mail.gmail.com>
 <5590E4E4.6030101@web.de>
 <CAJt3u5=cbY2V0xNy_ug-T8=ZWMazMbT_nit9_e9bEWeo7LMiaw@mail.gmail.com>
 <55922BE4.4040007@web.de>
 <CAJt3u5mK=rn2cN7xWQM8z5XQ8dXYGUorzJ_KQ1Sv1ehu-0xvmA@mail.gmail.com>
 <55927557.3000208@web.de>
Date: Tue, 30 Jun 2015 16:40:13 +0530
Message-ID: <CAJt3u5mOA2akinFXEeCt6cqfd0qfrV_O8TGST_xXxwGPnDP8+w@mail.gmail.com>
From: Madan Sondur <sondur.madan23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] CyclicTest query on Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

On Tue, Jun 30, 2015 at 4:24 PM, Jan Kiszka <jan.kiszka@web.de> wrote:

> On 2015-06-30 12:45, Madan Sondur wrote:
> > On Tue, Jun 30, 2015 at 11:10 AM, Jan Kiszka <jan.kiszka@web.de> wrote:
> >
> >> Please don't top-post.
> >>
> >> On 2015-06-30 05:34, Madan Sondur wrote:
> >>> I stress tested the system for an hour using Pi-stress and pumping hu=
ge
> >>> amount of data through usb3.0 and I perf at network.  What I have
> >> observed
> >>> is cyclictest from usr/xenomai/bin behaves differently, only the firs=
t
> >>> thread completes then after all the other threads execute very slowly=
,
> >> you
> >>> can see the count value.
> >>>
> >>> But the cyclictest that was downloaded from net completes all the
> threads
> >>> and exits.
> >>>
> >>> The results of sample tests for 5000 loops are as shown.
> >>>
> >>> Xenomai cyclictest T1 count is 120, where as cyclictest which is from
> net
> >>> has T1 count of 4546.
> >>>
> >>> Why is this behaviour?
> >>
> >> Xenomai uses different interval spreading than rt-test, see your
> >> outputs. There is probably a bug in the Xenomai version of cyclictest,
> >> getting some order of magnitude wrong with the default settings. Shoul=
d
> >> be easy to fix.
> >>
> >
> > Can you tell me what are the default settings for fixing this ?
>
> cyclictest -d <distance>
>
> >
> >>
> >> The fact that you see over 300 =C2=B5s worst-case latencies with vanil=
la
> >> cyclictest on a standard kernel and that you don't get this with the
> >> same test program over a Xenomai kernel, indicates that your test meth=
od
> >> was not correct, e.g. that load was affecting only the other cores.
> >> Xenomai does not improve the latencies of normal applications.
> >>
> >
> >
> > How do you say the vanilla cyclictest should not perform better in
> xenomai
> > kernel than in standard kernel ?,
> >   vanilla cyclictest is using posix calls which xenomai supports (posix
> api
> > interface) for hard real time.
> >
> > All the cores are shot up to 100% with pi_stress. only the first core w=
as
> > around 90% for traffic handling in usb 3.0 and Ethernet.
> >
> > i don't think Vanilla cyclictest is a normal application.
>
> Did you build the vanilla version against Xenomai libs using the
> xeno-config provided parameters? Then the situation could be different.
>

Wow i missed this, ( can't imagine, silly me ), I will try compiling with
Xeno-config. I never tried this as this
 is the first time i am exploring. If you can point me to any useful
guides/examples, would be very helpful

Thx for your time
M

>
> Jan
>
>
