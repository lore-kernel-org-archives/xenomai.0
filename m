Message-ID: <COL122-W40D27BC7171600EAF22040BDA50@domain.hid>
From: krishna m <krishnamurthyjs@domain.hid>
Date: Wed, 6 Apr 2011 22:27:27 +0530
In-Reply-To: <4D9B69A4.7050902@domain.hid>
References: <COL122-W376680783697A8A880DC2BBDA20@domain.hid>
	<infaa9$eoe$1@domain.hid>
	<4D9B4EC0.5080701@domain.hid>, <infnf9$6jm$1@domain.hid>,
	<4D9B69A4.7050902@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Tiny Core Linux + xenomai/RTAI
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org, gmane@domain.hid
Cc: xenomai@xenomai.org


----------------------------------------
> Date: Tue=2C 5 Apr 2011 21:12:36 +0200
> From: gilles.chanteperdrix@xenomai.org
> To: gmane@domain.hid
> CC: xenomai@xenomai.org
> Subject: Re: [Xenomai-core] Tiny Core Linux + xenomai/RTAI
>
> Robert Berger wrote:
> > Hi Gilles=2C
> >
> > On 04/05/2011 08:17 PM=2C Gilles Chanteperdrix wrote:
> >> Ok=2C we are on Xenomai-core=2C so=2C let us discuss. If we admit that=
 the OP
> >> is indeed talking about latencies (a quantifiable measure of
> >> determinism)=2C suggesting that the effect on cache of the Linux kerne=
l
> >> might influence the latencies is not completely irrelevant: the
> >> benchmark we make with Xenomai tend to consistently show that cache
> >> thrashing by the Linux kernel has an effect on latencies.
> >
> > Yes this did not immediately come into my mind. Linux cache thrashing
> > affects latencies of threads running under Xenomai (user and/or kernel
> > space)=2C but as you point out (
> > http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/8167 )
> > that is distro independent.
>
> Yes=2C and I completely agree with your answer=2C I was just replying for
> the sake of completeness.

Thanks for replying. I got to read important points that affect the perform=
ance=20
of a realtime system. I was indeed talking about the determinism of the RTO=
S=20
when i referred to the performance. I am right now looking at interrupt=20
determinism=2C task switch latency and jitter performance of the RTOS
[Xenomai in this case]on x86 platform. Since there is no Cache locking=20
mechanism on x86. i wanted to know if a smaller footprint kernel would=20
improve the performance of the above mentioned parameters of RTOS.=20

=20
>
> >
> > I know that the answer to this question might not be trivial=2C but wha=
t
> > would you suggest could be done to minimize cache thrashing?
>
> If we are talking embedded systems=2C you have control over the non
> real-time activities you run=2C you can try and be greedy in the way they
> use cache (I am not sure anyone really does that=2C I=2C for one=2C tried=
 and
> optimize a toy application for cache usage to see that the effect is
> impressive).
>
> The other way=2C is not to minimize cache thrashing=2C but to minimize it=
s
> effect on latencies. You can do that by increasing the frequency of the
> "critical" real-time task. By increasing its frequency=2C you make it mor=
e
> likely to remain in cache=2C and so decrease its latency. This is why=2C =
for
> instance=2C on most (*) platforms you get a better latency with smaller
> periods.
>
> On some embedded platforms=2C you also have the choice to lock some cache
> lines=2C or move some data or code to some fast memory essentially as fas=
t
> as cache (TCMs or SRAMs on ARM). This is a promising solution=2C at least
> on ARM=2C where many SOCs have such special memory=2C but as far as I kno=
w=2C
> nobody tried yet and reported success of failure.
>
> (*) the exception being armv4 or armv5 without the FCSE extension=2C wher=
e
> the cache is flushed all the time anyway.
>
> >
> >> Also=2C having shorter latencies means that we cover a larger range of
> >> user-application needs. So=2C we try to have short latencies.
> >>
> >
> > Whoever wants to see Xenomai latencies in action can compile cyclictest
> > with and without Xenomai and see the differences. On the platforms I've
> > tried so far the differences are clearly visible=3B)
>
> Again=2C I agree with your answer=2C determinism=2C i.e. worst case laten=
cy is
> what matters for a real-time system=2C but:
> - smaller worst case latency covers a broader range of applications=3B
> - smaller average case latency means more CPU cycles for the Linux
> kernel to run=2C so=2C the dual-kernels based solutions still try to
> preserve the average case latency and are a bit special with regard to
> that particular question.
>
> --
> Gilles.
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core 		 	   		  =

