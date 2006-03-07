Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-core] Fundamental Questions
Date: Tue, 7 Mar 2006 11:34:50 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A20688E@ARVMAIL1.mra.roland-man.biz>
From: <Roderik_Wildenburg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Dear Jan,
thank you for taking time to answer my questions and=20
sorry for the delayed response, but I have been busy=20
with some other work.=20
Please find my follow-up questions inserted in the text.

> >=20
> > 1.)
> > Essentially the question deals with the problem, how long a=20
> Xenomai task in secondary mode can be delayed by normal Linux tasks.=20
> > In detail : we plan to to have a lot of "near realtime"=20
> ethernet communication from within Xenomai using the normal=20
> Linux network stack (calling the normal socket API). The=20
> question now is, how our network communication is influenced=20
> by other Linux tasks performing also network communication,=20
> let=B4s say an FTP transfer ?
>=20
> Depending on the "normal" networking load, you will suffer=20
> from more or less frequent (indeterministic) packet delays.=20

Do you have an idea about the dimension weare talking about :
less than a millisecond, few milliseconds, seconds, or is the
delay complete indeterministic ?

> Xenomai will not improve this in any way. If your task in=20
> secondary mode tries to send some data and requires to take a=20
> networking lock currently held by another Linux task, it can=20
> take a real long time until this request is completed.=20



But at least, after a (linux-)systemcall (from what task ever) finished, =

Xenomai gets controll back before any other linux task, isn=B4t it ?
This means : between systemcalls a rescheduling back to Xenomai is =
performed=20
or isn=B4t it ??
Sorry for the next stupid question, but what is a network lock. With =
what kind of=20
action a task can lock the complete stack ? And how long could it block =
the stack ?
Could you give me an example for better understanding ?


> This=20
> gets better with PREEMPT_RT but still remains non-RT because=20
> the Linux networking stack is not designed for hard real-time.
>=20


Next stupid question : what is PREEMPT_RT ? Is this kernel 2.6 or is it =
the=20
Monta Vista approach for real time (making the kernel more preemtable) ?


>=20
> If you communication can be soft-RT, you could indeed avoid=20
> the separation - but you will then have to live with the side=20
> effects. All you can do then is try to lower the number of=20
> deadline misses by keeping the standard network traffic low=20
> and managing the bandwidth of the participants (the Linux=20
> network stack has some support for QoS, at least
> 2.6 I think).
>=20
> BTW, as long as your network is not separated or you have no=20
> control over the traffic arriving at your system, picking the=20
> Linux stack in favour of RTnet (which is compatible with=20
> non-RT networks) is indeed generally recommended. This way=20
> you keep indeterministic load away from the real-time subsystem.
>=20

Unfortunatelly we don=B4t want to limit non realtime traffic, we just=20
want to make shure, that deterministic traffic has a higher priority=20
than non RT traffic (like in other RTOS like vxWorks).=20
Indeterministic traffic should get just the leftover bandwith.
What do you mean with : "Rtnet is compatible with non-RT networks" ?=20
I thought RTnet uses a time slice mechanism and therefore could not be=20
mixed with systems transmitting when ever they want. Do you refer to =
VNICs ?

=20

> >=20
> > I have created a scheduling scenario and I would ask you to=20
> have a look on it and to tell me whether it is correct or=20
> not. Thank you !
> > An corresponding question about this scheduling is : are there=20
> > differences between a 2.4 and 2.6 Linux kernel ? (for our PowerPC=20
> > plattform we intend to use the 2.4 kernel for performance reasons)
> >=20
> > Scheduling scenario :
> > (I hope formating is not destroyed by email transfer)
> >=20
> > Time moves downwards
> >=20
> > v-Xenomai=20
> >      v-Linux kernel
> >           v-Linux processes
> >=20
> >           l1   Linux task1 running
> >      s1 < l1   Linux task1 makes systemcall
> >      s1        Linux task1 systemcall processed
> > -------------  Linux scheduling  =20
> >           l2   Linux task2 starts to run
> >      s2 < l2   Linux task2 makes systemcall
> >      s2        Linux task2 systemcall processed
> > +++++++++++++  Xenomai scheduling
> > x3             Xenomai task3 starts to run =3D> primary mode
> > x3 > s3        Xenomai task3 makes systemcall =3D> secondary mode
> >      s3        Xenomai task3 systemcall processed=20
> > -------------  Linux scheduling =3D> Xenomai task preemted
>=20
> This preemption will only happen if the target Linux task has=20
> a higher priority or the Xenomai task on secondary mode has=20
> to block on some resource to be become free. As I sketched=20
> above, this can actually happen in the network stack.


What do you mean with "higher priority" ? I thought Xenomai has
a higher priority than anything else in the linux system.
Could you give mean example about the resource (related to network
communication) s3 could wait for ?

>=20
> >      s1        Linux task1 systemcall processed
> >      s1 > l1   Linux task1 systemcall ready =3D> Linux task1=20
> continues=20
> >           l1   Linux task1 continues
> > -------------  Linux scheduling=20
> >      s2        Linux task2 systemcall processed
> >      s2 > l2   Linux task2 systemcall ready =3D> Linux task2=20
> continues=20
> >           l2   Linux task2 continues
> > -------------  Linux scheduling =3D> Xenomai Task3 systemcall=20
> continued
> >      s3        Xenomai Task3 systemcall continued
> > x3 < s3        Xenomai Task3 systemcall ready =3D> Xenomai=20
> Task contiunes
> > x3             but has been delayed by normal Linux tasks
> >=20
> >=20




> > 2.)
> > This question is not so crucial, but nevertheless interesting :
> > Who are the people behind Xenomai (I did not find anything=20
> about this on the Xenomai webpage), what is their background=20
> (University, Company)and who impels /sponsors the Xenomai=20
> development (University, Company, Community)?=20
> > I think I "identified" at least 2 core developers :=20
> Philippe Gerum and Gilles Chanteperdrix, but I don=B4t know=20
> very much more.
>=20

> I can add my/our own profile here: working at the university=20
> of Hannover (Real-Time Systems Group) with and on Xenomai to=20
> use it on mobile service robots and to do research on=20
> real-time security and industrial automation. Our institute=20
> is currently developing a larger robotic software framework=20
> on top of it. Primarily, we see Xenomai as a mature platform=20
> for doing real-time with Linux, i.e. as a very useful tool.
>=20
> > The background for this question is, to get a feeling, how=20
> future-proof the xenomai development is. As far as I can see=20
> open source projects often die or stall when the initiators=20
> decide that "growing flowers" is a much more pleasant job ;-).
> >=20
>=20
> We had to decide last year which way to go for our future=20
> platforms, also with potential industrial/commercial usage in=20
> mind (e.g.
> proprietary real-time algorithms as user-space applications).=20
> Based on our experience with the RTAI (> 4 years), my own=20
> insight into RTAI/fusion (Xenomai predecessor), and the=20
> status of PREEMPT_RT, we selected fusion (now Xenomai) as the=20
> most matured and future-proven one.
>=20
> Xenomai is enjoying an increasing acceptance in industry. Our=20
> industry partners e.g. are either planning to start new with=20
> Xenomai or port over from other RT-extensions - of course=20
> encouraged by our own good experience. I talked to a lot of=20
> smaller and real large companies over the last months,=20
> specifically here in Germany, that started new=20
> automation/embedded projects on top of Linux/Xenomai (as=20
> usual, most of their activities remain non-public -=20
> unfortunately). They are convinced of the future of this project.
>=20
> Moreover, I believe that Xenomai has a very healthy=20
> community. We have a quite active crowd of contributors and=20
> "plain" users. There is definitely more than one person=20
> knowing the internals of the system (as in many projects,=20
> there is still one person knowing them best...). And the code=20
> is also well documented (exceptions apart).
>=20
> No one can safely predict what will happen to a project when=20
> one of the main contributors stops working on it. But given=20
> the number of "advanced" Xenomai users already at this=20
> comparably early project stage, I'm convinced it would even=20
> survive such an exceptional scenario, i.e.
> it has reached a critical mass. But I have no indications=20
> that Philippe or Gilles will become gardeners. ;)
>=20
> This said, the best thing one can do as a long-term user of=20
> an open source project is to support its development actively by
>=20
>  o promoting it (yes, it can already be that simple)  o=20
> reporting problems  o fixing minor bugs and posting the fixes=20
>  o contributing new features and enhancements (drivers, board support,
>    API extensions, ...)
>  o or directly funding the development of such enhancements
>=20
> >=20
> > Thank you for taking time to answer these questions, which=20
> are interesting to others too, I think !?
> >=20
>=20
> Hope I was able to provide you some helpful details and arguments.
>=20

Yes, you did ! Thank you very much !
Things you said about the interest of larger companies, the widespread
knowledgement and code maturity sounds quite good to me.

Form your mentioning of "industrial partners" I conclude you are working =
with=20
or for companies also, not just for your universty.
So i would like to know whether you also offer external consultations ?=20
Just in case, we want to make shure that things, we plan to do are =
possible=20
with Xenomai.

Best Regards
Roderik

