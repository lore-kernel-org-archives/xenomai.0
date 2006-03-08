Message-ID: <20060308171327.17712.qmail@domain.hid>
Date: Wed, 8 Mar 2006 12:13:27 -0500 (EST)
From: Christopher Stone <chris@domain.hid>
Subject: Re: AW: [Xenomai-core] Fundamental Questions
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A20688E@ARVMAIL1.mra.roland-man.biz>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-39976809-1141838007=:17460"
Content-Transfer-Encoding: 8bit
Reply-To: chris@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--0-39976809-1141838007=:17460
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In light of the desire for support below, would the Xenomai team consider l=
isting companies capable of commercial support on their website, or create =
another mailing list for us to announce commercial offerings around Xenomai=
. I am prepared to contribute to Xenomai in order to receive this privilege=
. =20
  =20
  Sorry for discussing commercial issues on your mailing list. If it makes =
it any better, we are a very small company, just trying to make a living, n=
ot a big corporate conglomerate.=20
  =20
  As a final point, I believe Xenomai is very well positioned to become ver=
y popular and "future proof". I believe the next frontier for Linux is indu=
strial grade Linux, or Linux on the factory floor and Xenomai will end up t=
he technology of choice to make that happen. Contrary to many opinions I ha=
ve heard, I beleve the rt-preempt work done by Ingo Molnar will enhance Xen=
omai and not replace it. I also think the break from RTAI was very smart as=
 it has given you the flexibility to move Xenomai in the direction it needs=
 to go. The recent releases have made Xenomai ready for the commercial worl=
d. So, kudos to the Xenomai team. You guys are proving to be great leaders =
with the right technology at the right time.
  =20
  Cheers,
      Chris Stone.

Roderik_Wildenburg@domain.hid wrote:
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



But at least, after a (linux-)systemcall (from what task ever) finished,=20
Xenomai gets controll back before any other linux task, isn=B4t it ?
This means : between systemcalls a rescheduling back to Xenomai is performe=
d=20
or isn=B4t it ??
Sorry for the next stupid question, but what is a network lock. With what k=
ind of=20
action a task can lock the complete stack ? And how long could it block the=
 stack ?
Could you give me an example for better understanding ?


> This=20
> gets better with PREEMPT_RT but still remains non-RT because=20
> the Linux networking stack is not designed for hard real-time.
>=20


Next stupid question : what is PREEMPT_RT ? Is this kernel 2.6 or is it the=
=20
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
mixed with systems transmitting when ever they want. Do you refer to VNICs ?



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
> > v-Linux kernel
> > v-Linux processes
> >=20
> > l1 Linux task1 running
> > s1 < l1 Linux task1 makes systemcall
> > s1 Linux task1 systemcall processed
> > ------------- Linux scheduling=20
> > l2 Linux task2 starts to run
> > s2 < l2 Linux task2 makes systemcall
> > s2 Linux task2 systemcall processed
> > +++++++++++++ Xenomai scheduling
> > x3 Xenomai task3 starts to run =3D> primary mode
> > x3 > s3 Xenomai task3 makes systemcall =3D> secondary mode
> > s3 Xenomai task3 systemcall processed=20
> > ------------- Linux scheduling =3D> Xenomai task preemted
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
> > s1 Linux task1 systemcall processed
> > s1 > l1 Linux task1 systemcall ready =3D> Linux task1=20
> continues=20
> > l1 Linux task1 continues
> > ------------- Linux scheduling=20
> > s2 Linux task2 systemcall processed
> > s2 > l2 Linux task2 systemcall ready =3D> Linux task2=20
> continues=20
> > l2 Linux task2 continues
> > ------------- Linux scheduling =3D> Xenomai Task3 systemcall=20
> continued
> > s3 Xenomai Task3 systemcall continued
> > x3 < s3 Xenomai Task3 systemcall ready =3D> Xenomai=20
> Task contiunes
> > x3 but has been delayed by normal Linux tasks
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
> o promoting it (yes, it can already be that simple) o=20
> reporting problems o fixing minor bugs and posting the fixes=20
> o contributing new features and enhancements (drivers, board support,
> API extensions, ...)
> o or directly funding the development of such enhancements
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

Form your mentioning of "industrial partners" I conclude you are working wi=
th=20
or for companies also, not just for your universty.
So i would like to know whether you also offer external consultations ?=20
Just in case, we want to make shure that things, we plan to do are possible=
=20
with Xenomai.

Best Regards
Roderik

_______________________________________________
Xenomai-core mailing list
Xenomai-core@domain.hid
https://mail.gna.org/listinfo/xenomai-core






Christopher Stone
Principal
Sombrio Systems Inc.
www.openembedded.biz
613-831-1892
--0-39976809-1141838007=:17460
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<div>In light of the desire for support below, would the Xenomai team consi=
der listing companies capable of commercial support on their website, or cr=
eate another mailing list for us to announce commercial offerings around Xe=
nomai. I am&nbsp;prepared to contribute to Xenomai in order to receive this=
 privilege. &nbsp;</div>  <div>&nbsp;</div>  <div>Sorry for discussing comm=
ercial issues on your mailing list. If it makes it any better, we are a ver=
y small company, just trying to&nbsp;make a living,&nbsp;not a big corporat=
e conglomerate. </div>  <div>&nbsp;</div>  <div>As a final point, I believe=
 Xenomai is very well positioned to become very popular and "future proof".=
 I believe the next frontier for Linux is industrial grade Linux, or Linux =
on the factory floor and Xenomai will end up the technology of choice to ma=
ke that happen. Contrary to many opinions I have heard, I beleve the rt-pre=
empt work done by Ingo Molnar will enhance Xenomai and not replace it.&nbsp=
;I also&nbsp;think the
 break from RTAI was very smart as it has given you the flexibility to move=
 Xenomai in the direction it needs to go. The recent releases have made Xen=
omai ready for the commercial world. So, kudos to the Xenomai team. You guy=
s are proving to be great leaders with the right technology at the right ti=
me.</div>  <div>&nbsp;</div>  <div>Cheers,</div>  <div>&nbsp;&nbsp;&nbsp; C=
hris Stone.<BR><BR><B><I>Roderik_Wildenburg@domain.hid</I></B> wrote:</div>=
  <BLOCKQUOTE class=3Dreplbq style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #1010ff 2px solid">Dear Jan,<BR>thank you for taking time to a=
nswer my questions and <BR>sorry for the delayed response, but I have been =
busy <BR>with some other work. <BR>Please find my follow-up questions inser=
ted in the text.<BR><BR>&gt; &gt; <BR>&gt; &gt; 1.)<BR>&gt; &gt; Essentiall=
y the question deals with the problem, how long a <BR>&gt; Xenomai task in =
secondary mode can be delayed by normal Linux tasks. <BR>&gt; &gt; In detai=
l : we plan to to have a
 lot of "near realtime" <BR>&gt; ethernet communication from within Xenomai=
 using the normal <BR>&gt; Linux network stack (calling the normal socket A=
PI). The <BR>&gt; question now is, how our network communication is influen=
ced <BR>&gt; by other Linux tasks performing also network communication, <B=
R>&gt; let=B4s say an FTP transfer ?<BR>&gt; <BR>&gt; Depending on the "nor=
mal" networking load, you will suffer <BR>&gt; from more or less frequent (=
indeterministic) packet delays. <BR><BR>Do you have an idea about the dimen=
sion weare talking about :<BR>less than a millisecond, few milliseconds, se=
conds, or is the<BR>delay complete indeterministic ?<BR><BR>&gt; Xenomai wi=
ll not improve this in any way. If your task in <BR>&gt; secondary mode tri=
es to send some data and requires to take a <BR>&gt; networking lock curren=
tly held by another Linux task, it can <BR>&gt; take a real long time until=
 this request is completed. <BR><BR><BR><BR>But at least, after a (linux-)s=
ystemcall (from what task
 ever) finished, <BR>Xenomai gets controll back before any other linux task=
, isn=B4t it ?<BR>This means : between systemcalls a rescheduling back to X=
enomai is performed <BR>or isn=B4t it ??<BR>Sorry for the next stupid quest=
ion, but what is a network lock. With what kind of <BR>action a task can lo=
ck the complete stack ? And how long could it block the stack ?<BR>Could yo=
u give me an example for better understanding ?<BR><BR><BR>&gt; This <BR>&g=
t; gets better with PREEMPT_RT but still remains non-RT because <BR>&gt; th=
e Linux networking stack is not designed for hard real-time.<BR>&gt; <BR><B=
R><BR>Next stupid question : what is PREEMPT_RT ? Is this kernel 2.6 or is =
it the <BR>Monta Vista approach for real time (making the kernel more preem=
table) ?<BR><BR><BR>&gt; <BR>&gt; If you communication can be soft-RT, you =
could indeed avoid <BR>&gt; the separation - but you will then have to live=
 with the side <BR>&gt; effects. All you can do then is try to lower the nu=
mber of <BR>&gt; deadline
 misses by keeping the standard network traffic low <BR>&gt; and managing t=
he bandwidth of the participants (the Linux <BR>&gt; network stack has some=
 support for QoS, at least<BR>&gt; 2.6 I think).<BR>&gt; <BR>&gt; BTW, as l=
ong as your network is not separated or you have no <BR>&gt; control over t=
he traffic arriving at your system, picking the <BR>&gt; Linux stack in fav=
our of RTnet (which is compatible with <BR>&gt; non-RT networks) is indeed =
generally recommended. This way <BR>&gt; you keep indeterministic load away=
 from the real-time subsystem.<BR>&gt; <BR><BR>Unfortunatelly we don=B4t wa=
nt to limit non realtime traffic, we just <BR>want to make shure, that dete=
rministic traffic has a higher priority <BR>than non RT traffic (like in ot=
her RTOS like vxWorks). <BR>Indeterministic traffic should get just the lef=
tover bandwith.<BR>What do you mean with : "Rtnet is compatible with non-RT=
 networks" ? <BR>I thought RTnet uses a time slice mechanism and therefore =
could not be <BR>mixed
 with systems transmitting when ever they want. Do you refer to VNICs ?<BR>=
<BR><BR><BR>&gt; &gt; <BR>&gt; &gt; I have created a scheduling scenario an=
d I would ask you to <BR>&gt; have a look on it and to tell me whether it i=
s correct or <BR>&gt; not. Thank you !<BR>&gt; &gt; An corresponding questi=
on about this scheduling is : are there <BR>&gt; &gt; differences between a=
 2.4 and 2.6 Linux kernel ? (for our PowerPC <BR>&gt; &gt; plattform we int=
end to use the 2.4 kernel for performance reasons)<BR>&gt; &gt; <BR>&gt; &g=
t; Scheduling scenario :<BR>&gt; &gt; (I hope formating is not destroyed by=
 email transfer)<BR>&gt; &gt; <BR>&gt; &gt; Time moves downwards<BR>&gt; &g=
t; <BR>&gt; &gt; v-Xenomai <BR>&gt; &gt; v-Linux kernel<BR>&gt; &gt; v-Linu=
x processes<BR>&gt; &gt; <BR>&gt; &gt; l1 Linux task1 running<BR>&gt; &gt; =
s1 &lt; l1 Linux task1 makes systemcall<BR>&gt; &gt; s1 Linux task1 systemc=
all processed<BR>&gt; &gt; ------------- Linux scheduling <BR>&gt; &gt; l2 =
Linux task2 starts to
 run<BR>&gt; &gt; s2 &lt; l2 Linux task2 makes systemcall<BR>&gt; &gt; s2 L=
inux task2 systemcall processed<BR>&gt; &gt; +++++++++++++ Xenomai scheduli=
ng<BR>&gt; &gt; x3 Xenomai task3 starts to run =3D&gt; primary mode<BR>&gt;=
 &gt; x3 &gt; s3 Xenomai task3 makes systemcall =3D&gt; secondary mode<BR>&=
gt; &gt; s3 Xenomai task3 systemcall processed <BR>&gt; &gt; ------------- =
Linux scheduling =3D&gt; Xenomai task preemted<BR>&gt; <BR>&gt; This preemp=
tion will only happen if the target Linux task has <BR>&gt; a higher priori=
ty or the Xenomai task on secondary mode has <BR>&gt; to block on some reso=
urce to be become free. As I sketched <BR>&gt; above, this can actually hap=
pen in the network stack.<BR><BR><BR>What do you mean with "higher priority=
" ? I thought Xenomai has<BR>a higher priority than anything else in the li=
nux system.<BR>Could you give mean example about the resource (related to n=
etwork<BR>communication) s3 could wait for ?<BR><BR>&gt; <BR>&gt; &gt; s1 L=
inux task1 systemcall
 processed<BR>&gt; &gt; s1 &gt; l1 Linux task1 systemcall ready =3D&gt; Lin=
ux task1 <BR>&gt; continues <BR>&gt; &gt; l1 Linux task1 continues<BR>&gt; =
&gt; ------------- Linux scheduling <BR>&gt; &gt; s2 Linux task2 systemcall=
 processed<BR>&gt; &gt; s2 &gt; l2 Linux task2 systemcall ready =3D&gt; Lin=
ux task2 <BR>&gt; continues <BR>&gt; &gt; l2 Linux task2 continues<BR>&gt; =
&gt; ------------- Linux scheduling =3D&gt; Xenomai Task3 systemcall <BR>&g=
t; continued<BR>&gt; &gt; s3 Xenomai Task3 systemcall continued<BR>&gt; &gt=
; x3 &lt; s3 Xenomai Task3 systemcall ready =3D&gt; Xenomai <BR>&gt; Task c=
ontiunes<BR>&gt; &gt; x3 but has been delayed by normal Linux tasks<BR>&gt;=
 &gt; <BR>&gt; &gt; <BR><BR><BR><BR><BR>&gt; &gt; 2.)<BR>&gt; &gt; This que=
stion is not so crucial, but nevertheless interesting :<BR>&gt; &gt; Who ar=
e the people behind Xenomai (I did not find anything <BR>&gt; about this on=
 the Xenomai webpage), what is their background <BR>&gt; (University, Compa=
ny)and who impels /sponsors the
 Xenomai <BR>&gt; development (University, Company, Community)? <BR>&gt; &g=
t; I think I "identified" at least 2 core developers : <BR>&gt; Philippe Ge=
rum and Gilles Chanteperdrix, but I don=B4t know <BR>&gt; very much more.<B=
R>&gt; <BR><BR>&gt; I can add my/our own profile here: working at the unive=
rsity <BR>&gt; of Hannover (Real-Time Systems Group) with and on Xenomai to=
 <BR>&gt; use it on mobile service robots and to do research on <BR>&gt; re=
al-time security and industrial automation. Our institute <BR>&gt; is curre=
ntly developing a larger robotic software framework <BR>&gt; on top of it. =
Primarily, we see Xenomai as a mature platform <BR>&gt; for doing real-time=
 with Linux, i.e. as a very useful tool.<BR>&gt; <BR>&gt; &gt; The backgrou=
nd for this question is, to get a feeling, how <BR>&gt; future-proof the xe=
nomai development is. As far as I can see <BR>&gt; open source projects oft=
en die or stall when the initiators <BR>&gt; decide that "growing flowers" =
is a much more pleasant
 job ;-).<BR>&gt; &gt; <BR>&gt; <BR>&gt; We had to decide last year which w=
ay to go for our future <BR>&gt; platforms, also with potential industrial/=
commercial usage in <BR>&gt; mind (e.g.<BR>&gt; proprietary real-time algor=
ithms as user-space applications). <BR>&gt; Based on our experience with th=
e RTAI (&gt; 4 years), my own <BR>&gt; insight into RTAI/fusion (Xenomai pr=
edecessor), and the <BR>&gt; status of PREEMPT_RT, we selected fusion (now =
Xenomai) as the <BR>&gt; most matured and future-proven one.<BR>&gt; <BR>&g=
t; Xenomai is enjoying an increasing acceptance in industry. Our <BR>&gt; i=
ndustry partners e.g. are either planning to start new with <BR>&gt; Xenoma=
i or port over from other RT-extensions - of course <BR>&gt; encouraged by =
our own good experience. I talked to a lot of <BR>&gt; smaller and real lar=
ge companies over the last months, <BR>&gt; specifically here in Germany, t=
hat started new <BR>&gt; automation/embedded projects on top of Linux/Xenom=
ai (as <BR>&gt; usual,
 most of their activities remain non-public - <BR>&gt; unfortunately). They=
 are convinced of the future of this project.<BR>&gt; <BR>&gt; Moreover, I =
believe that Xenomai has a very healthy <BR>&gt; community. We have a quite=
 active crowd of contributors and <BR>&gt; "plain" users. There is definite=
ly more than one person <BR>&gt; knowing the internals of the system (as in=
 many projects, <BR>&gt; there is still one person knowing them best...). A=
nd the code <BR>&gt; is also well documented (exceptions apart).<BR>&gt; <B=
R>&gt; No one can safely predict what will happen to a project when <BR>&gt=
; one of the main contributors stops working on it. But given <BR>&gt; the =
number of "advanced" Xenomai users already at this <BR>&gt; comparably earl=
y project stage, I'm convinced it would even <BR>&gt; survive such an excep=
tional scenario, i.e.<BR>&gt; it has reached a critical mass. But I have no=
 indications <BR>&gt; that Philippe or Gilles will become gardeners. ;)<BR>=
&gt; <BR>&gt; This
 said, the best thing one can do as a long-term user of <BR>&gt; an open so=
urce project is to support its development actively by<BR>&gt; <BR>&gt; o p=
romoting it (yes, it can already be that simple) o <BR>&gt; reporting probl=
ems o fixing minor bugs and posting the fixes <BR>&gt; o contributing new f=
eatures and enhancements (drivers, board support,<BR>&gt; API extensions, .=
..)<BR>&gt; o or directly funding the development of such enhancements<BR>&=
gt; <BR>&gt; &gt; <BR>&gt; &gt; Thank you for taking time to answer these q=
uestions, which <BR>&gt; are interesting to others too, I think !?<BR>&gt; =
&gt; <BR>&gt; <BR>&gt; Hope I was able to provide you some helpful details =
and arguments.<BR>&gt; <BR><BR>Yes, you did ! Thank you very much !<BR>Thin=
gs you said about the interest of larger companies, the widespread<BR>knowl=
edgement and code maturity sounds quite good to me.<BR><BR>Form your mentio=
ning of "industrial partners" I conclude you are working with <BR>or for co=
mpanies also, not just
 for your universty.<BR>So i would like to know whether you also offer exte=
rnal consultations ? <BR>Just in case, we want to make shure that things, w=
e plan to do are possible <BR>with Xenomai.<BR><BR>Best Regards<BR>Roderik<=
BR><BR>_______________________________________________<BR>Xenomai-core mail=
ing list<BR>Xenomai-core@domain.hid<BR>https://mail.gna.org/listinfo/xenoma=
i-core<BR><BR><BR><BR></BLOCKQUOTE><BR><BR><BR>Christopher Stone<br>Princip=
al<br>Sombrio Systems Inc.<br>www.openembedded.biz<br>613-831-1892
--0-39976809-1141838007=:17460--

