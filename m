MIME-Version: 1.0
In-Reply-To: <OF20C64B35.1E041556-ON65257582.0049EA88-65257582.004A9442@domain.hid>
References: <OF20C64B35.1E041556-ON65257582.0049EA88-65257582.004A9442@domain.hid>
Date: Mon, 23 Mar 2009 21:17:34 +0100
Message-ID: <f48df4840903231317t818ebf2tca012f1d8985ad46@domain.hid>
From: Bruno Rouchouse <brouchouse@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5ad4dffea1d0465cef427
Subject: Re: [Xenomai-core] Xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Vandana Sasidharan <vandana.sasidharan@domain.hid>
Cc: xenomai@xenomai.org

--001636c5ad4dffea1d0465cef427
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
1/ Please check the "support frame" on www.xenomai.org and use the proper
mailing list: xenomai-help is the one you need to post to for this kind of
questions at first. It is totally suitable for configuration or compilation
issues.

2/ Adeos patch is not relevant in the case of the simulator. You can
build/use the simulator regardless of your target configuration.

3/ To answer your question now: Tix-4.1 is the problem here (API problem
with tixDirList:ListHierarchy). An easy way to build and make the simulator
work is to switch to an older distribution. Debian/Sarge is known to work
for instance. A good approach here is to use a qemu or a virtualbox that
runs on top of your host platform. If you benefit from a robust hardware
machine (at least Dual core or Core 2 Duo), you'll be able to have the
simulator run with a very low overhead.

--Bruno

2009/3/23 Vandana Sasidharan <vandana.sasidharan@domain.hid>

>
> Hi
>
> I am getting an error when I am trying to "MAKE" Xenosim- 2.4.7.
> I have already installed Xenomai- 2.4.7 along with libelf -0.8.10 , Tcl
> 8.3.5, Tk 8.3.5 , Tix 4.1.0.007 and an adeos patch that is adeos-ipipe
> -2.6.25-x86-2.0-08.patch on a linux kernel which we built which has a
> version Linux 2.6.25.11.
> after configuring Xenosim along with the gcc -2.95.3 tar .gz when I try to
> "make" the xenosim I'm getting an error :
>
> xenomai-2.4.7/xenosim-2.4.7/adapter/adapter.cc: 65: error :too few
> arguments
> xenomai-2.4.7/xenosim-2.4.7/adapter/adapter.cc: 67: error :too few
> arguments
>
> Can anyone tell me why am I getting this error and how to get rid of this?
>
>
> =====-----=====-----=====
> Notice: The information contained in this e-mail
> message and/or attachments to it may contain
> confidential or privileged information. If you are
> not the intended recipient, any dissemination, use,
> review, distribution, printing or copying of the
> information contained in this e-mail message
> and/or attachments to it are strictly prohibited. If
> you have received this communication in error,
> please notify us by reply e-mail or telephone and
> immediately and permanently delete the message
> and any attachments. Thank you
>
>
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>
>

--001636c5ad4dffea1d0465cef427
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>1/ Please check the &quot;support frame&quot; on <a =
href=3D"http://www.xenomai.org">www.xenomai.org</a><span class=3D"Apple-sty=
le-span" style=3D"font-family: -webkit-sans-serif; border-collapse: collaps=
e; "><span class=3D"Apple-style-span" style=3D"border-collapse: separate; f=
ont-family: arial; ">=A0and use the proper mailing list: xenomai-help is th=
e one you need to post to for this kind of questions at first. It is totall=
y suitable for configuration or compilation issues.</span></span></div>
<div><br></div><div>2/ Adeos patch is not relevant in the case of the simul=
ator. You can build/use the simulator regardless of your target configurati=
on.</div><div><br></div><div>3/ To answer your question now: Tix-4.1 is the=
 problem here (API problem with tixDirList:ListHierarchy). An easy way to b=
uild and make the simulator work is to switch to an older distribution. Deb=
ian/Sarge is known to work for instance. A good approach here is to use a q=
emu or a virtualbox that runs on top of your host platform. If you benefit =
from a robust hardware machine (at least Dual core or Core 2 Duo), you&#39;=
ll be able to have the simulator run with a very low overhead.</div>
<div><br></div><div>--Bruno</div><div><br><div class=3D"gmail_quote">2009/3=
/23 Vandana Sasidharan <span dir=3D"ltr">&lt;<a href=3D"mailto:vandana.sasi=
dharan@domain.hid">vandana.sasidharan@domain.hid</a>&gt;</span><br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex;">

<br><font size=3D"2" face=3D"sans-serif">Hi</font>
<br>
<br><font size=3D"2" face=3D"sans-serif">I am getting an error when I am tr=
ying
to &quot;MAKE&quot; Xenosim- 2.4.7.</font>
<br><font size=3D"2" face=3D"sans-serif">I have already installed Xenomai- =
2.4.7
along with libelf -0.8.10 , Tcl 8.3.5, Tk 8.3.5 , Tix 4.1.0.007 and an
adeos patch that is adeos-ipipe -2.6.25-x86-2.0-08.patch on a linux kernel
which we built which has a version Linux 2.6.25.11.</font>
<br><font size=3D"2" face=3D"sans-serif">after configuring Xenosim along wi=
th
the gcc -2.95.3 tar .gz when I try to &quot;make&quot; the xenosim I&#39;m
getting an error :</font>
<br>
<br><font size=3D"2" face=3D"sans-serif">xenomai-2.4.7/xenosim-2.4.7/adapte=
r/adapter.cc:
65: error :too few arguments</font>
<br><font size=3D"2" face=3D"sans-serif">xenomai-2.4.7/xenosim-2.4.7/adapte=
r/adapter.cc:
67: error :too few arguments</font>
<br>
<br><font size=3D"2" face=3D"sans-serif">Can anyone tell me why am I gettin=
g
this error and how to get rid of this?</font>
<br>
<br><font size=3D"2" face=3D"sans-serif"><br>
</font><pre>=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D
Notice: The information contained in this e-mail
message and/or attachments to it may contain=20
confidential or privileged information. If you are=20
not the intended recipient, any dissemination, use,=20
review, distribution, printing or copying of the=20
information contained in this e-mail message=20
and/or attachments to it are strictly prohibited. If=20
you have received this communication in error,=20
please notify us by reply e-mail or telephone and=20
immediately and permanently delete the message=20
and any attachments. Thank you


</pre><br>_______________________________________________<br>
Xenomai-core mailing list<br>
<a href=3D"mailto:Xenomai-core@domain.hid">Xenomai-core@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-core" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-core</a><br>
<br></blockquote></div><br></div>

--001636c5ad4dffea1d0465cef427--

