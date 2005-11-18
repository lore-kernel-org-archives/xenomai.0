In-Reply-To: <437D976B.3040502@domain.hid>
Subject: Re: [Xenomai-core] Re: [Xenomai-help] Blocking reads from pipes
Message-ID: <OF3D687430.1B92652B-ONC12570BD.00317943-C12570BD.0032624E@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Fri, 18 Nov 2005 10:10:19 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2EDFA2FFD38f9e8a93df938690918c4EBBFA2EDFA2FFD3"
Content-Disposition: inline
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ignacio =?ISO-8859-1?Q?Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org, xenomai-core <xenomai@xenomai.org>

--0__=4EBBFA2EDFA2FFD38f9e8a93df938690918c4EBBFA2EDFA2FFD3
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable




xenomai-core-bounces@domain.hid wrote on 18.11.2005 09:57:15:

>
> >Exactly, I have just found out that and posted actually a long mail =
just

> >before getting this mail from you :o)
> >
> >Yep, and before getting blocked, read() increments the counter as
> well, that's
> >why we don't have a xnpipe_realease() called as a result of close().=

> >So everything is correct.
> >
> >
> Fine. Though then my problem is not related to xenomai, any suggestio=
ns
> on how to force read() to return? (without writing anything to the ot=
her
> end of the pipe)

ummm... send it a certain signal with pthread_kill() (and setting up
something like thread::flag =3D=3D END_OF_WORK_BABY at the same time bu=
t only
in case when there can be other cases of getting a signal by this threa=
d)?
In such a case, read() should return -EINTR.
Note, a signal handler must be installed without a SA_RESTART flag so t=
hat
the read() will not be restarted after signal processing.


---

Dmitry=

--0__=4EBBFA2EDFA2FFD38f9e8a93df938690918c4EBBFA2EDFA2FFD3
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>xenomai-core-bounces@domain.hid wrote on 18.11.2005 09:57:15:<br>
<br>
&gt; <br>
&gt; &gt;Exactly, I have just found out that and posted actually a long=
 mail just <br>
&gt; &gt;before getting this mail from you :o)<br>
&gt; &gt;<br>
&gt; &gt;Yep, and before getting blocked, read() increments the counter=
 as <br>
&gt; well, that's <br>
&gt; &gt;why we don't have a xnpipe_realease() called as a result of cl=
ose().<br>
&gt; &gt;So everything is correct.<br>
&gt; &gt; &nbsp;<br>
&gt; &gt;<br>
&gt; Fine. Though then my problem is not related to xenomai, any sugges=
tions<br>
&gt; on how to force read() to return? (without writing anything to the=
 other<br>
&gt; end of the pipe)<br>
</tt><br>
<tt>ummm... send it a certain signal with pthread_kill() (and setting u=
p something like thread::flag =3D=3D END_OF_WORK_BABY at the same time =
but only in case when there can be other cases of getting a signal by t=
his thread)? In such a case, read() should return -EINTR.</tt><br>
<tt>Note, a signal handler must be installed without </tt><tt>a SA_REST=
ART flag so that the read() will not be restarted after signal processi=
ng.</tt><br>
<br>
<br>
<tt>---</tt><br>
<br>
<tt>Dmitry</tt><br>
</body></html>=

--0__=4EBBFA2EDFA2FFD38f9e8a93df938690918c4EBBFA2EDFA2FFD3--


