Message-ID: <fd6a47a90601181358k55c60cb4m@domain.hid>
Date: Wed, 18 Jan 2006 22:58:09 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-help] blocked or not blocked call on
	snippet/shared_mem.c?
In-Reply-To: <200601181903.27928.lbocseg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5850_19394583.1137621489501"
References: <200601181903.27928.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_5850_19394583.1137621489501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> I'm confused. Did you really mean TM_NONBLOCK?
> Am I missing something?


I think you have to read it like this:

       Bind to a shared heap which has been created elsewhere, either
       in kernel or user-space. The call will block us until such heap
       is created with the expected name.

       Therefore (because we do not want (and are probably unable to, see
below)), we supply TM_NONBLOCK.

       The heap should have been
       created with the H_SHARED mode set, which is implicit when
       creation takes place in user-space.

Additionally, I think the process wouldn't even block if requested because
it is not a Xenomai thread. Use rt_task_shadow() to promote it. Make sure
you have a suitable bailout mechanism if you happen to start waiting
indefinitely.


Jeroen.

------=_Part_5850_19394583.1137621489501
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I'm confused. Did you really mea=
n TM_NONBLOCK?<br>Am I missing something?</blockquote>
<div>&nbsp;</div>
<div>I think you have to read it like this:</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bind to a shared heap which has b=
een created elsewhere, either<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in ke=
rnel or user-space. The call will block us until such heap<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; is created with the expected name. </div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Therefore (because we do not want=
 (and are probably unable to, see below)), we supply TM_NONBLOCK.</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The heap should have been<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; created with the H_SHARED mode set, which =
is implicit when<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; creation takes pla=
ce in user-space.<br>&nbsp;</div>
<div>Additionally, I think the process wouldn't even block if requested bec=
ause it is not a Xenomai thread. Use rt_task_shadow() to promote it. Make s=
ure you have a suitable bailout mechanism if you happen to start waiting in=
definitely.
</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div></div>

------=_Part_5850_19394583.1137621489501--

