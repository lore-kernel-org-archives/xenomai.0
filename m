MIME-Version: 1.0
Date: Tue, 8 Jun 2010 10:16:43 +0200
Message-ID: <AANLkTimIDghE4o5RpesavooS0cB96ekIgYTXv8rkPRZb@domain.hid>
From: Cyril Wallois <walloiscyril@domain.hid>
Content-Type: multipart/alternative; boundary=0015174bee3ee3a1530488806897
Subject: [Xenomai-help] Alignment problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rtnet-users@domain.hid, xenomai@xenomai.org

--0015174bee3ee3a1530488806897
Content-Type: text/plain; charset=ISO-8859-1

Hello everybody,

I try rtnet with the last stable version of xenomai (2.5.3 and linux kernel
2.6.26) and I have a new error code :

./rtping 127.0.0.1
Real-time PING 127.0.0.1 56(84) bytes of data.
[  610.438400] Xenomai: suspending kernel thread bf027038 ('rtnet-rtpc') at
0xc0030fa4 after exception #0

/proc/xenomai/faults :
TRAP         CPU0
  0:            1    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:            0    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)
  8:            0    (Unaligned access exception)


in /proc/kallsyms 0xc0030fa4 correspond to : c0030f60 t do_page_fault

and bf027038 b dispatch_task        [rtnet]

Best regards,

WALLOIS Cyril

--0015174bee3ee3a1530488806897
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everybody,<br><br>I try rtnet with the last stable version of xenomai=
 (2.5.3 and linux kernel 2.6.26) and I have a new error code :<br><br>./rtp=
ing 127.0.0.1<br>Real-time PING 127.0.0.1 56(84) bytes of data.<br>[=A0 610=
.438400] Xenomai: suspending kernel thread bf027038 (&#39;rtnet-rtpc&#39;) =
at 0xc0030fa4 after exception #0<br>
<br>/proc/xenomai/faults :<br>TRAP=A0=A0=A0=A0=A0=A0=A0=A0 CPU0<br>=A0 0:=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0 (Data or instruction access)<b=
r>=A0 1:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Section fault)<br>=A0=
 2:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Generic data abort)<br>=A0=
 3:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Unknown exception)<br>
=A0 4:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Instruction breakpoint)=
<br>=A0 5:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Floating point exce=
ption)<br>=A0 6:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (VFP Floating =
point exception)<br>=A0 7:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (Und=
efined instruction)<br>=A0 8:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0 (=
Unaligned access exception)<br>
<br><br>in /proc/kallsyms 0xc0030fa4 correspond to : c0030f60 t do_page_fau=
lt<br><br>and bf027038 b dispatch_task=A0=A0=A0=A0=A0=A0=A0 [rtnet]<br><br>=
Best regards,<br><br>WALLOIS Cyril<br><br><br>

--0015174bee3ee3a1530488806897--

