Message-ID: <BLU166-W50364F5FF2956D7D3F6F78C49B0@domain.hid>
Content-Type: multipart/alternative;
	boundary="_3cb872f7-88b5-4718-8a92-b3448e1ca5ee_"
From: Jan-Erik Lange <jan0385@domain.hid>
Date: Sun, 8 Jan 2012 13:06:05 +0100
In-Reply-To: <BLU166-W368BD6DC25E9423818DC75C49A0@domain.hid>
References: <BLU166-W368BD6DC25E9423818DC75C49A0@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Questio about the Xenomai Scheduler
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--_3cb872f7-88b5-4718-8a92-b3448e1ca5ee_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


 Is it perhaps this way?:=20
=20
When the RT-Task migrated into the secondary domain=2C it is scheduled by t=
he Linux-Scheduler:
=20
-> It inherits the RT-priority from her life in the primary domain and is t=
imely priviliged compared to other tasks scheduled by the linux scheduler=
=2C which have a lower priority.
-> But it can always be preempted by an RT-Task=2C that runs in the primary=
 domain and that is scheduled by the Xenomai Scheduler=2C because this sche=
duler can preempt all
standard linux kernel activities.
-> Still it is protected from preempting by an Linux interrupt handler=2C b=
ecause the I-Pipe is block the interrupts.
=20



From: jan0385@domain.hid
To: xenomai@xenomai.org
Date: Sat=2C 7 Jan 2012 11:43:15 +0100
Subject: [Xenomai-core] Questio about the Xenomai Scheduler





Hello=2C
=20
I have a question about the Xenomai scheduler.

Can the Xenomai Scheduler always preempt any operation of the scheduler of =
the standard Linux kernel? What is=2C when a migrated RT-Task
is currently scheduled by the standard Linux scheduler? Does the Xenomai Sc=
heduler can preempt this task too?
=20
Best regards=20
Jan

_______________________________________________ Xenomai-core mailing list X=
enomai-core@domain.hid https://mail.gna.org/listinfo/xenomai-core 		 	   		  =

--_3cb872f7-88b5-4718-8a92-b3448e1ca5ee_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
&nbsp=3BIs it perhaps this way?: <BR>
&nbsp=3B<BR>
When the RT-Task migrated into the secondary domain=2C it is scheduled by t=
he Linux-Scheduler:<BR>
&nbsp=3B<BR>
-&gt=3B It inherits the RT-priority from her life in the primary domain and=
 is timely priviliged compared to other tasks scheduled by the linux schedu=
ler=2C which have a lower priority.<BR>-&gt=3B But it can always be preempt=
ed by an RT-Task=2C that runs in the primary domain and that is scheduled b=
y the Xenomai Scheduler=2C because this scheduler can preempt all<BR>standa=
rd linux kernel activities.<BR>-&gt=3B Still it is protected from preemptin=
g by an Linux interrupt handler=2C because the I-Pipe is block the interrup=
ts.<BR>
&nbsp=3B<BR>
<DIV>
<DIV id=3DSkyDrivePlaceholder></DIV>
<HR id=3DstopSpelling>
From: jan0385@domain.hid<BR>To: xenomai@xenomai.org<BR>Date: Sat=2C 7 Jan =
2012 11:43:15 +0100<BR>Subject: [Xenomai-core] Questio about the Xenomai Sc=
heduler<BR><BR>
<META name=3DGenerator content=3D"Microsoft SafeHTML">
<STYLE>
.ExternalClass .ecxhmmessage P
{padding:0px=3B}
.ExternalClass body.ecxhmmessage
{font-size:10pt=3Bfont-family:Tahoma=3B}

</STYLE>

<DIV dir=3Dltr>Hello=2C<BR>&nbsp=3B<BR>I have a question about the Xenomai =
scheduler.<BR><BR>Can the Xenomai Scheduler always preempt any operation of=
 the scheduler of the standard Linux kernel? What is=2C when a migrated RT-=
Task<BR>is currently scheduled by the standard Linux scheduler? Does the Xe=
nomai Scheduler can preempt this task too?<BR>&nbsp=3B<BR>Best regards <BR>=
Jan<BR></DIV><BR>_______________________________________________ Xenomai-co=
re mailing list Xenomai-core@domain.hid https://mail.gna.org/listinfo/xenomai-=
core</DIV> 		 	   		  </div></body>
</html>=

--_3cb872f7-88b5-4718-8a92-b3448e1ca5ee_--

