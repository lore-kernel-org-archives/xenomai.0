Message-ID: <15F13C9AC6F2054D8AC7AFEA62FA218E04E32C@vwagwox00002.vw.vwg>
From: "Koenig, Kai (EEFA/4)" <kai.koenig@domain.hid>
Date: Tue, 24 Jul 2007 13:19:43 +0200
MIME-Version: 1.0
content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7CDE4.895B9BE3"
Subject: [Xenomai-help] [NEWBIE question] Use of rt_task_send
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C7CDE4.895B9BE3
Content-Type: text/plain;
	charset="iso-8859-1"

Hello, 

As the topic says I am quite the newbie working with Xenomai. As a result I
have some questions regarding the use of the API.

I tried checking the archives, but did not find what I was looking for. 

I am currently working on a middleware, that manages communication (local
and over network) between different processes/threads by use of Synchonous
Message Passing over a special interface.

I tried using rt_task_send, rt_task_receive and rt_task_reply for
realization of said interface on Xenomai. Now my questions:

1) How do i get the task description of another real-time task that is
needed for rt_task_send? 
I have the symbolic name, the task was created with. If I try to contact a
real-time thread from a user space task I can use it with rt_task_bind to
get the descriptor of the target task.

But the API states this is a user-space task only. Is there a similar API
call for getting the task descriptor of another real-time task from kernel
space?

I checked the message queue and pipe services and there seems to be the same
problem, so I know, I am probably missing something.

I thought of acessing the registry directly, but I read in some post that
the nucleus API calls are supposed to only be used by other skins.

2) Is it possible to use rt_task_send, receive and reply with applications
that are compiled against the POSIX skin? 

Thanks, 
Kai 



------_=_NextPart_001_01C7CDE4.895B9BE3
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.2">
<TITLE>[NEWBIE question] Use of rt_task_send</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">As the topic says I am quite the =
newbie working with Xenomai. As a result I have some questions =
regarding the use of the API.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I tried checking the archives, but did =
not find what I was looking for.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am currently working on a =
middleware, that manages communication (local and over network) between =
different processes/threads by use of Synchonous Message Passing over a =
special interface.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I tried using rt_task_send, =
rt_task_receive and rt_task_reply for realization of said interface on =
Xenomai. Now my questions:</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">1) How do i get the task description =
of another real-time task that is needed for rt_task_send?</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">I have the symbolic name, the task =
was created with. If I try to contact a real-time thread from a user =
space task I can use it with rt_task_bind to get the descriptor of the =
target task.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">But the API states this is a =
user-space task only. Is there a similar API call for getting the task =
descriptor of another real-time task from kernel space?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I checked the message queue and pipe =
services and there seems to be the same problem, so I know, I am =
probably missing something.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I thought of acessing the registry =
directly, but I read in some post that the nucleus API calls are =
supposed to only be used by other skins.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">2) Is it possible to use rt_task_send, =
receive and reply with applications that are compiled against the POSIX =
skin?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Kai </FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C7CDE4.895B9BE3--

