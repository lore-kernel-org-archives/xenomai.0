Message-ID: <BLU166-W84625BB37F4B5F9C29FB6C4990@domain.hid>
Content-Type: multipart/alternative;
	boundary="_59eeb038-385b-44b9-b8b8-87d5a713be0a_"
From: Jan-Erik Lange <jan0385@domain.hid>
Date: Tue, 10 Jan 2012 16:04:16 +0100
MIME-Version: 1.0
Subject: [Xenomai-core] Synchronization of shared memory with mutexes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--_59eeb038-385b-44b9-b8b8-87d5a713be0a_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hello=2C

I have a question about basics of the synchronization of shared memory with=
 mutexes.
=20
The situation: The Sender is a RT task (primary domain) and the recipient i=
s a non-RT task (usually in the secondary domain). Namely=2C the receiver i=
s used to interact with a Web server. He calls to syscalls and stuff and be=
cause of that he's usually in the secondary mode.
=20
Suppose the sender has written something to the shared memory: He uses mute=
x for synchronization=2C so he calls the rt_mutex_release() function.
=20
The receiver will now get time to work from the scheduler. He calls rt_mute=
x_acquire() function to lock the shared memory. Then a context switch occur=
s from the secondary mode in the primary mode. He has now the resource for =
himself.
=20
Now the scheduler lets sender-task to work and it wants to write something.=
 So it calls rt_mutex_acquire() function. And now comes my question: Provid=
es rt_mutex_acquire() a mechanism to signal the cheduler to immediately con=
tinue with the recipient-task? If so=2C how does the rt_mutex_acquire() fun=
ction tells the scheduler that?
=20
I came out because I in the documention I read the term "Rescheduling: alwa=
ys".
=20
Best regards
Jan 		 	   		  =

--_59eeb038-385b-44b9-b8b8-87d5a713be0a_
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
<BR>Hello=2C<BR>
<BR>I have a question about basics of the synchronization of shared memory =
with mutexes.<BR>
&nbsp=3B<BR>
The situation: The Sender is a RT task (primary domain) and the recipient i=
s a non-RT task (usually in the secondary domain). Namely=2C the receiver i=
s used to interact with a Web server. He calls to syscalls and stuff and be=
cause of that&nbsp=3Bhe's usually in the secondary mode.<BR>
&nbsp=3B<BR>
Suppose the sender has written something to the shared memory: He uses mute=
x for synchronization=2C so he calls the rt_mutex_release() function.<BR>
&nbsp=3B<BR>
The receiver will now get time to work from the scheduler. He calls rt_mute=
x_acquire() function to lock the shared memory. Then a context switch occur=
s from the secondary mode in the primary mode. He has now the resource for =
himself.<BR>
&nbsp=3B<BR>
Now the scheduler lets sender-task to work and it wants to write something.=
 So it calls rt_mutex_acquire() function. And now comes my question: Provid=
es rt_mutex_acquire() a mechanism to signal the cheduler to immediately con=
tinue with the recipient-task? If so=2C how does the rt_mutex_acquire() fun=
ction tells the scheduler that?<BR>
&nbsp=3B<BR>
I came out because I in the documention I read the term "Rescheduling: alwa=
ys".<BR>
&nbsp=3B<BR>
Best regards<BR>Jan<BR> 		 	   		  </div></body>
</html>=

--_59eeb038-385b-44b9-b8b8-87d5a713be0a_--

