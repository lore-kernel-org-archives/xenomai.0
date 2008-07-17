Message-ID: <f48df4840807171345h47cef1c8x7f8ef5d73936c18@domain.hid>
Date: Thu, 17 Jul 2008 22:45:59 +0200
From: "Bruno Rouchouse" <brouchouse@domain.hid>
In-Reply-To: <216400f90807170510t79eb7c07p60715544ec9fc37c@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_50863_18567905.1216327559617"
References: <216400f90807170458n2c910e49m4c74273819bade22@domain.hid>
	<216400f90807170510t79eb7c07p60715544ec9fc37c@domain.hid>
Subject: Re: [Xenomai-core] Skin Arinc 653
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Marc Kaufmann <mkf63@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_50863_18567905.1216327559617
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Mark,

2008/7/17 Marc Kaufmann <mkf63@domain.hid>:

> Hello people,
>
> I am a new member, registred on Gna! & Xenoma=EF mailing lists.
>
> At the moment, my role is to help teams to develop embedded software in
> aerospace (aeronautics system including Scade applications, middleware an=
d
> basic/complex operating system ...).
>
> I have some questions about Xenoma=EF:
>
>    - Is a skin Arinc 653 available or not ?
>
> Not that I know about. No official skin has been implemented so far.

>
>    -
>    - If not, is-it possible to develop spatial/temporal partioning on top
>    of Xenoma=EF ?
>
> Xenomai should have all mechanisms available to allow such implementation=
.
I remember that Philippe added some piece of implementation a while ago in
order to allow multiple thread suspension. The idea behind that was to
enable Arinc-653 partitioning model, although it can apply to any time slic=
e
scheduling.

>
>    -
>    - Shall Xenoma=EF  require  a Linux platform to run ?
>
> Yes Xenomai micro kernel and skins are developed on top of the Linux
kernel, although I think it is possible to make it run on bare metal i.e.
only using Xenomai scheduler without Linux as a host operating system.

>
>    -
>    - If Linux is not required, is-it a faq or some directives in order to
>    make a port on a "scratch operating system" or an existing micro-kerne=
l
>    (example : MicroCOS-II, uCLinux, eCos ...) ?
>
> Probably possible but I don't know enough about Xenomai's implementation =
to
be able to answer that one. You also have to be aware of potential licensin=
g
issues here. Xenomai is published under GNU General Public License (GPL).

>
>    -
>    - Can be Linux replaced by a VxWorks COIL (Core OS Interface Library)
>    architecture ?
>
> You are not at the same level here. COIL is a proprietary and specific
library of WindRiver's Arinc-653 platform which provides basic
functionalities to allow communication between application and the core OS.
If Linux is used as Core OS with the help of Xenomai and a specific skin to
implement partitioning, talking about COIL here is not appropriate.

>
>    -
>
> Sorry, if my questions seem to be "newbies", it is my first collaboration
> on this mailing list !
>
> Regards,
> Marc Kaufmann.
>
> --Bruno

>
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>
>

------=_Part_50863_18567905.1216327559617
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div dir=3D"ltr">Hi Mark,<br><br><div class=3D"gmail_quote">2008/7/17 Marc =
Kaufmann &lt;<a href=3D"mailto:mkf63@domain.hid" target=3D"_blank">mkf63@domain.hid.=
fr</a>&gt;:<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px =
solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">Hello people,<=
br><br>I am a new member, registred on Gna! &amp; Xenoma=EF mailing lists.<=
br><br>At the moment, my role is to help teams to develop embedded software=
 in aerospace (aeronautics system including Scade applications, middleware =
and basic/complex operating system ...). <br>




<br>I have some questions about Xenoma=EF:<br><ul><li>Is a skin Arinc 653 a=
vailable or not ?</li></ul></div></div></div></blockquote><div>Not that I k=
now about. No official skin has been implemented so far.&nbsp; <br></div><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr"><ul><li><br></=
li><li>If not, is-it possible to develop spatial/temporal partioning on top=
 of Xenoma=EF ?</li></ul></div></div></div></blockquote><div>Xenomai should=
 have all mechanisms available to allow such implementation. I remember tha=
t Philippe added some piece of implementation a while ago in order to allow=
 multiple thread suspension. The idea behind that was to enable Arinc-653 p=
artitioning model, although it can apply to any time slice scheduling.<br>


</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div dir=3D=
"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr"><ul><li><br></li><li>Shal=
l Xenoma=EF&nbsp; require&nbsp; a Linux platform to run ?</li>


</ul></div></div></div></blockquote><div>Yes Xenomai micro kernel and skins=
 are developed on top of the Linux kernel, although I think it is possible =
to make it run on bare metal i.e. only using Xenomai scheduler without Linu=
x as a host operating system.<br>

</div>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div dir=3D"ltr">=
<div class=3D"gmail_quote"><div dir=3D"ltr"><ul><li><br></li>

<li>If Linux is not required, is-it a faq or some directives in order to ma=
ke a port on a &quot;scratch operating system&quot; or an existing micro-ke=
rnel (example : MicroCOS-II, uCLinux, eCos ...) ?</li></ul></div></div>


</div></blockquote><div>Probably possible but I don&#39;t know enough about=
 Xenomai&#39;s implementation to be able to answer that one. You also have =
to be aware of potential licensing issues here. Xenomai is published under =
GNU General Public License (GPL).<br>

</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr"><ul><li><br></=
li><li>Can be Linux replaced by a VxWorks COIL (Core OS Interface Library) =
architecture ?</li></ul></div></div></div></blockquote><div>You are not at =
the same level here. COIL is a proprietary and specific library of WindRive=
r&#39;s Arinc-653 platform which provides basic functionalities to allow co=
mmunication between application and the core OS. If Linux is used as Core O=
S with the help of Xenomai and a specific skin to implement partitioning, t=
alking about COIL here is not appropriate.<br>


</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div dir=3D=
"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr"><ul><li><br>

</li></ul>Sorry, if my questions seem to be &quot;newbies&quot;, it is my f=
irst collaboration on this mailing list !<br><br>Regards,<br>Marc Kaufmann.=
<br><br></div></div></div></blockquote><div>--Bruno <br></div><blockquote c=
lass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); ma=
rgin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr"><br></div>
</div><br></div>
<br>_______________________________________________<br>
Xenomai-core mailing list<br>
<a href=3D"mailto:Xenomai-core@domain.hid" target=3D"_blank">Xenomai-core@domain.hid.=
org</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-core" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-core</a><br>
<br></blockquote></div><br></div>

------=_Part_50863_18567905.1216327559617--

