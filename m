MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <CAAvA3H_9MbPT+QLgbmVAk-5ZzE2eu0TQo3rzS1mkBV0RtSPcXw@domain.hid>
References: <CAAvA3H_9MbPT+QLgbmVAk-5ZzE2eu0TQo3rzS1mkBV0RtSPcXw@domain.hid>
Date: Mon, 29 Aug 2011 08:26:37 -0500
Message-ID: <CAAvA3H_rtX_Js5TVHHWDyK-J4vouEY4LxO9MsvdU-y8TjPVoNA@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=00504502ac3c33ec1004aba4d803
Subject: [Xenomai-help] Fwd: dynamic loader latencies
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai Help <xenomai@xenomai.org>

--00504502ac3c33ec1004aba4d803
Content-Type: text/plain; charset=ISO-8859-1

Bumping this post again in hopes of eliciting comments ...

Jeff

---------- Forwarded message ----------
From: Jeff Weber <jwamsc@domain.hid>
Date: Fri, Aug 26, 2011 at 11:34 AM
Subject: dynamic loader latencies
To: Xenomai Help <xenomai@xenomai.org>


The Linux ELF dynamic linker/loader ld-linux.so uses a "lazy" model by
default, and defers symbol resolution, shared object resolution to the time
when the symbol is first referenced.  This sounds like a large latency
threat to dynamically linked RT applications running in primary mode. Can
this happen, or is this unlikely?

If this is a latency risk, the only solutions I know of are:

1) Statically link all RT applications

2) Invoke all dynamically linked applications with LD_BIND_NOW=1 environment
to force the dynamic loader to resolve all  symbols  at program startup

3) Link dynamic applications with "-z now" GNU ld option to effect same as
2) above.

Comments?

thanks,
Jeff

--00504502ac3c33ec1004aba4d803
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bumping this post again in hopes of eliciting comments ...<div><br></div><d=
iv>Jeff<br><br><div class=3D"gmail_quote">---------- Forwarded message ----=
------<br>From: <b class=3D"gmail_sendername">Jeff Weber</b> <span dir=3D"l=
tr">&lt;<a href=3D"mailto:jwamsc@domain.hid">jwamsc@domain.hid</a>&gt;</span>=
<br>
Date: Fri, Aug 26, 2011 at 11:34 AM<br>Subject: dynamic loader latencies<br=
>To: Xenomai Help &lt;<a href=3D"mailto:xenomai@xenomai.org">xenomai-help@=
gna.org</a>&gt;<br><br><br>The Linux ELF=A0dynamic linker/loader=A0ld-linux=
.so uses a &quot;lazy&quot; model by default, and defers symbol resolution,=
 shared object resolution to the time when the symbol is first referenced. =
=A0This sounds like a large latency threat to dynamically linked RT applica=
tions running in primary mode.=A0Can this happen, or is this unlikely?<div>

<div>
<br></div><div>If this is a latency risk, the only solutions I know of are:=
</div><div><br></div><div>1) Statically link all RT applications</div><div>=
<br></div><div>2) Invoke all dynamically linked applications with=A0LD_BIND=
_NOW=3D1 environment to force=A0the dynamic loader to resolve all =A0symbol=
s =A0at program startup</div>

<div><br></div><div>3) Link dynamic applications with &quot;-z now&quot; GN=
U ld option to effect same as 2) above.<br>
<div><br></div><div><div>Comments?</div></div><div><br></div><div>thanks,</=
div><div>Jeff</div>
</div></div>
</div><br></div>

--00504502ac3c33ec1004aba4d803--

