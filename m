MIME-Version: 1.0
In-Reply-To: <AANLkTimZM3QJqxY0wmBf0LAdn4PCaA6t+UgbFCjm7hAw@domain.hid>
References: <AANLkTimZM3QJqxY0wmBf0LAdn4PCaA6t+UgbFCjm7hAw@domain.hid>
Date: Tue, 5 Oct 2010 10:37:03 +0530
Message-ID: <AANLkTimk_+MFLLZJUXmB24LegAV6da98gqLRe8yqECia@domain.hid>
From: Prakash A S <asprakash83@domain.hid>
Content-Type: multipart/alternative; boundary=0050450140b5ad3d060491d7a1ef
Subject: Re: [Xenomai-help] XENOMAI in Embedded Linux vs Ubuntu
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Warner <xenomai.start@domain.hid>
Cc: xenomai@xenomai.org

--0050450140b5ad3d060491d7a1ef
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Oct 4, 2010 at 9:18 PM, Peter Warner <xenomai.start@domain.hid>wrote:

> Dear  Xenomai Users,
>
> I have one question, can any of you suggets me the answer.
>
> I have Instaled Xenomai Sucessfully in my system the detail of my System is
> as mentioned below:
>
> processor: core2duo.
> Operating System: Ubuntu 10.4
>
> After the installation I have checked the examples programmes I ran and
> modified it and i found it is running fine I am getting deterministic result
> here for the tasks. Now from one of the resource I came to know that one of
> the very much popular Embedded Linux called  MontaVista Linux is also
> Patched with the xenomai to achive the hard real-time requirement.
>
> Now I had a doubt what is the advantage of Using MontaVista or any Embedded
> Linux over Ubuntu as both the System is having xenomai layer and we can
> achive the realtime performance in ubuntu right which is a freeware o the
> other hand Montavista is Lisenced one.
>
> So my question is which one is more better either an Embedded Linux patched
> with xenomai or ubuntu or desktop Linux with Xenomai.
>

Probably you need to aware of that the distributions are not at all related
with Xenomai. Its working fine with the source kernel from kernel.org.
Moreover, all the distributions are taking the kernel from kernel.org and
modified according to their needs. As Edward suggested, its better idea to
use the kernel from kernel.org. You can opt any flavour of distributions for
your host, may be Ubuntu, Montavista, Fedora, CentOS,.etc. Even I worked
from Puppy Linux also. You can get some good BSP support for your boards, if
you are using any proprietary embedded linux like MV.

-Prakash

--0050450140b5ad3d060491d7a1ef
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Oct 4, 2010 at 9:18 PM, Peter Wa=
rner <span dir=3D"ltr">&lt;<a href=3D"mailto:xenomai.start@domain.hid">xenom=
ai.start@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
<div>Dear=A0 Xenomai Users,</div>
<div>=A0</div>
<div>I have one question, can any of you suggets me the answer.</div>
<div>=A0</div>
<div>I have Instaled Xenomai Sucessfully in my system the detail of my Syst=
em is as mentioned below:</div>
<div>=A0</div>
<div>processor: core2duo.</div>
<div>Operating System: Ubuntu 10.4</div>
<div>=A0</div>
<div>After the installation I have checked the examples programmes I ran an=
d modified it and i found it is running fine I am getting deterministic res=
ult here for the tasks. Now from one of the resource I came to know that on=
e of the very much popular Embedded Linux called=A0 MontaVista Linux is als=
o Patched with the xenomai to achive the hard real-time requirement.</div>


<div>=A0</div>
<div>Now I had a doubt what is the advantage of Using MontaVista or any Emb=
edded Linux=A0over Ubuntu as both the System is having xenomai layer and we=
 can achive the realtime performance in ubuntu right which is a freeware o =
the other hand Montavista is Lisenced one.</div>


<div>=A0</div>
<div>So my question is which one is more better either an Embedded Linux pa=
tched with xenomai or ubuntu or desktop Linux=A0with Xenomai.</div></blockq=
uote><div><br></div></div>Probably you need to aware of that the distributi=
ons are not at all related with Xenomai. Its working fine with the source k=
ernel from <a href=3D"http://kernel.org">kernel.org</a>. Moreover, all the =
distributions are taking the kernel from <a href=3D"http://kernel.org">kern=
el.org</a> and modified according to their needs. As Edward suggested, its =
better idea to use the kernel from <a href=3D"http://kernel.org">kernel.org=
</a>. You can opt any flavour of distributions for your host, may be Ubuntu=
, Montavista, Fedora, CentOS,.etc. Even I worked from Puppy Linux also. You=
 can get some good BSP support for your boards, if you are using any propri=
etary embedded linux like MV.=A0 <br>
<br>-Prakash<br>

--0050450140b5ad3d060491d7a1ef--

