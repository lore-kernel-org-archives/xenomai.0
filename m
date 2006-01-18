Message-ID: <fd6a47a90601181311i2e726b46w@domain.hid>
Date: Wed, 18 Jan 2006 22:11:30 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Scheduling while atomic
In-Reply-To: <43CEADBE.4040802@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4705_20072920.1137618690500"
References: <fd6a47a90601171559x13acf2c2m@domain.hid>
	<43CE9FCB.2070305@domain.hid>
	<17358.42102.613327.327841@domain.hid>
	<43CEA56D.8000407@domain.hid>
	<fd6a47a90601181236u5a482ba5q@domain.hid>
	<43CEA7AC.9080300@domain.hid>
	<fd6a47a90601181254s11edbb28l@domain.hid>
	<43CEADBE.4040802@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_4705_20072920.1137618690500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 Interesting, when writing to 2 different files, I get the same crashes.
Will test with only one task/fd.



> In fact, my last crash report did contain a difference with yours:
> >
> > ROOT task was at priority 0
> > main was at 1
> > task0 was at 30 timeout 3.7ms
> > task1 was at 29 timeout 4.9 ms
> >
> > Does this mean that both tasks were actually not even inside the
> critical
> > section ?
> >
>
> Yep, and this clearly indicates that there is no issue with mutexes,
> semaphores, or whatever. Please try to capture the full trace and post
> it to the list. As I said, this kind of topic here is not my home
> domain...
>

------=_Part_4705_20072920.1137618690500
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>
<div>Interesting, when writing to 2 different files, I get the same crashes=
. Will test with only one task/fd.</div>
<div>&nbsp;</div>
<div>&nbsp;</div><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; In fact, my last crash repo=
rt did contain a difference with yours:<br>&gt;<br>&gt; ROOT task was at pr=
iority 0
<br>&gt; main was at 1<br>&gt; task0 was at 30 timeout 3.7ms<br>&gt; task1 =
was at 29 timeout 4.9 ms<br>&gt;<br>&gt; Does this mean that both tasks wer=
e actually not even inside the critical<br>&gt; section ?<br>&gt;<br><br>
Yep, and this clearly indicates that there is no issue with mutexes,<br>sem=
aphores, or whatever. Please try to capture the full trace and post<br>it t=
o the list. As I said, this kind of topic here is not my home domain...
<br></blockquote></div>

------=_Part_4705_20072920.1137618690500--

