Message-ID: <BLU166-W318B8255CBD859B5B3ED9AC49B0@domain.hid>
Content-Type: multipart/alternative;
	boundary="_aa256f06-1082-4313-9a70-5385bb551a8d_"
From: Jan-Erik Lange <jan0385@domain.hid>
Date: Sun, 8 Jan 2012 15:43:19 +0100
MIME-Version: 1.0
Subject: [Xenomai-core] Question about IPC
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--_aa256f06-1082-4313-9a70-5385bb551a8d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello=2C
=20
sorry=2C but I have also some more questions about Xenomai. It would be ver=
y nice if you could look at it.
=20
I have a question concerning shared memory areas and message pipes and the =
implementation of the IPC-techniques Message queues and synchronous messagi=
ng:
=20
Message queues and synchronous messaging: An heap object=2C which can be cr=
eated by the function rt_heap_create() (native API)=2C is used to create an=
 address space accessible from the user-space and the kernel-space. Does th=
e IPC techniques message queues and synchronous messaging use this address =
space for the communication channel?
=20
Shared memory areas: So far as I know=2C the Xenomai and the standard Linux=
 Kernel are connected through the Interrupt-Pipe. In the I-Pipe implementat=
ion=2C these two domains share
a single address-space=2C which can be used when a thread needs to invoke s=
ervice at one point from linux and one point from Xenomai. Is this the addr=
ess space=2C
which is used by message pipes too? Because the message pipes can transport=
 data between the two domains. Is this term documented somewhere?
=20
Best regards
Jan
 		 	   		  =

--_aa256f06-1082-4313-9a70-5385bb551a8d_
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
Hello=2C<BR>
&nbsp=3B<BR>
sorry=2C but I have also some more questions about Xenomai. It would be ver=
y nice if you could look at it.<BR>
&nbsp=3B<BR>
I have a question concerning shared memory areas and message pipes and the =
implementation of the IPC-techniques Message queues and synchronous messagi=
ng:<BR>
&nbsp=3B<BR>
Message queues and synchronous messaging: An heap object=2C which can be cr=
eated by the function rt_heap_create() (native API)=2C is used to create an=
 address space accessible from the user-space and the kernel-space. Does th=
e IPC techniques message queues and synchronous messaging use this address =
space for the communication channel?<BR>
&nbsp=3B<BR>
Shared memory areas: So far as I know=2C the Xenomai and the standard Linux=
 Kernel are connected through the Interrupt-Pipe. In the I-Pipe implementat=
ion=2C these two domains share<BR>a single address-space=2C which can be us=
ed when a thread needs to invoke service at one point from linux and one po=
int from Xenomai. Is this the address space=2C<BR>which is used by message =
pipes too? Because the message pipes can transport data between the two dom=
ains. Is this term documented somewhere?<BR>
&nbsp=3B<BR>
Best regards<BR>
Jan<BR><BR> 		 	   		  </div></body>
</html>=

--_aa256f06-1082-4313-9a70-5385bb551a8d_--

