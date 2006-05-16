Message-ID: <4546494d0605160315x2fad7c74ge8133057446d5f6b@domain.hid>
Date: Tue, 16 May 2006 18:15:27 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-help] [RTDM] best strategy for periodic reading
In-Reply-To: <44699D5A.9070806@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_34921_21590345.1147774527504"
References: <e4c3bv$829$1@domain.hid> <44699D5A.9070806@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Marco Jackel <ich@domain.hid>, xenomai@xenomai.org

------=_Part_34921_21590345.1147774527504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jan,

Quick questions:
1. What is the problem with "xntimer_init()"? The timerbench.c use it to
create timers? You are going to write a RTDM implementation?
2.  What is  general program model for Xenomai application like data
acquisition? What I am thinking is to start the RT task in user space (via
POSIX skin), and implement the read funtion in kernel space using RTDM.

Thanks,
-Yi

On 5/16/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Marco Jackel wrote:
> > Hello,
> > I'm writing a driver for a A/D converter with a multiplexer. I want to
> > access it with software controlled conversion. The controller has 15
> > Inputs. I've to set a few Bits to select the Channel that I want to rea=
d
> > from and to start the conversion. I want to access different channel
> > with a different frequency. At the moment I try to do this with
> > different realtime-tasks started from the "read_rt" function
> > (rtdm_task_init).
> > Is this the best way or is there something more elegant?
> >
>
> What is the usage model of your driver? Is there an application thread
> associated to each frequency or even each channel? Or is there a single
> reader which gets woken up once some channel finishes the conversion? Or
> does the application requests a bulk of samples from multiple channels?
>
> Depending on that usage model, an alternative way to implement your
> driver is to let the application generate the conversion clock, i.e. let
> it poll the data (maybe just blocking on the conversion completion).
>
> On the other hand, if the acquisition job currently performed in
> rtdm_tasks is rather light-weight, maybe timers would help you to reduce
> the overhead involved in multiple threads reading from the same device
> (including locking etc.). Unfortunately, an RTDM interface for direct
> timer usage has not yet been fully specified. Some preliminary patch
> hangs around on my box for quite a few months now. Do you see advantages
> for your scenario when using timers, i.e. executing the periodic jobs
> directly in the context of the timer IRQ handler? If yes, I could try to
> accelerate the finalisation of this patch.
>
> Jan
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>
>
>

------=_Part_34921_21590345.1147774527504
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jan,<br><br>Quick questions: <br>1. What is the problem with &quot;xntim=
er_init()&quot;? The timerbench.c use it to create timers? You are going to=
 write a RTDM implementation?<br>2.&nbsp; What is&nbsp; general program mod=
el for Xenomai application like data acquisition? What I am thinking is to =
start the RT task in user space (via POSIX skin), and implement the read fu=
ntion in kernel space using RTDM.
<br><br>Thanks,<br>-Yi<br><br><div><span class=3D"gmail_quote">On 5/16/06, =
<b class=3D"gmail_sendername">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kisz=
ka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
Marco Jackel wrote:<br>&gt; Hello,<br>&gt; I'm writing a driver for a A/D c=
onverter with a multiplexer. I want to<br>&gt; access it with software cont=
rolled conversion. The controller has 15<br>&gt; Inputs. I've to set a few =
Bits to select the Channel that I want to read
<br>&gt; from and to start the conversion. I want to access different chann=
el<br>&gt; with a different frequency. At the moment I try to do this with<=
br>&gt; different realtime-tasks started from the &quot;read_rt&quot; funct=
ion
<br>&gt; (rtdm_task_init).<br>&gt; Is this the best way or is there somethi=
ng more elegant?<br>&gt;<br><br>What is the usage model of your driver? Is =
there an application thread<br>associated to each frequency or even each ch=
annel? Or is there a single
<br>reader which gets woken up once some channel finishes the conversion? O=
r<br>does the application requests a bulk of samples from multiple channels=
?<br><br>Depending on that usage model, an alternative way to implement you=
r
<br>driver is to let the application generate the conversion clock, i.e. le=
t<br>it poll the data (maybe just blocking on the conversion completion).<b=
r><br>On the other hand, if the acquisition job currently performed in<br>
rtdm_tasks is rather light-weight, maybe timers would help you to reduce<br=
>the overhead involved in multiple threads reading from the same device<br>=
(including locking etc.). Unfortunately, an RTDM interface for direct<br>
timer usage has not yet been fully specified. Some preliminary patch<br>han=
gs around on my box for quite a few months now. Do you see advantages<br>fo=
r your scenario when using timers, i.e. executing the periodic jobs<br>
directly in the context of the timer IRQ handler? If yes, I could try to<br=
>accelerate the finalisation of this patch.<br><br>Jan<br><br><br><br>_____=
__________________________________________<br>Xenomai-help mailing list
<br><a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br><a =
href=3D"https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/li=
stinfo/xenomai-help</a><br><br><br><br></blockquote></div><br>

------=_Part_34921_21590345.1147774527504--

