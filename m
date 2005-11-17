In-Reply-To: <437C5119.4060100@domain.hid>
Subject: Re: [Xenomai-help] Blocking reads from pipes
Message-ID: <OF793B3877.8F9E3BF6-ONC12570BC.003AE718-C12570BC.003B282B@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Thu, 17 Nov 2005 11:46:09 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2FDFA961888f9e8a93df938690918c4EBBFA2FDFA96188"
Content-Disposition: inline
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ignacio =?ISO-8859-1?Q?Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

--0__=4EBBFA2FDFA961888f9e8a93df938690918c4EBBFA2FDFA96188
Content-type: text/plain; charset=US-ASCII


> Hi,
>
> My application consists of a real time module and a non-realtime user
> mode program. They communicate through several pipes.
>
> The user mode program creates a thread (pthread) that opens a pipe and
> blocks in a read call, waiting for data. Under certain conditions, the
> user mode program must do an orderly exit, and thus I need a way to
> unblock that thread.
>
> I've done that in the past with sockets. If you have one thread blocked
> reading from a socket handle, and you close it from another thread, the
> read call will immediately return with an error code.
>
> However, that doesn't seem to work with xenomai pipes. One posix thread
> blocked reading from a pipe (using posix open/read) won't unblock when
> you close the file handle from another thread.

Actually, it should be unblocked but with 0 as a return value. I'll take a
look at that.


>
> Any suggestions?
>
> Thanks.
>
> Nacho.

---
Best regards,
Dmitry
--0__=4EBBFA2FDFA961888f9e8a93df938690918c4EBBFA2FDFA96188
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>&gt; Hi,<br>
&gt; <br>
&gt; My application consists of a real time module and a non-realtime user<br>
&gt; mode program. They communicate through several pipes.<br>
&gt; <br>
&gt; The user mode program creates a thread (pthread) that opens a pipe and<br>
&gt; blocks in a read call, waiting for data. Under certain conditions, the<br>
&gt; user mode program must do an orderly exit, and thus I need a way to<br>
&gt; unblock that thread.<br>
&gt; <br>
&gt; I've done that in the past with sockets. If you have one thread blocked<br>
&gt; reading from a socket handle, and you close it from another thread, the<br>
&gt; read call will immediately return with an error code.<br>
&gt; <br>
&gt; However, that doesn't seem to work with xenomai pipes. One posix thread<br>
&gt; blocked reading from a pipe (using posix open/read) won't unblock when<br>
&gt; you close the file handle from another thread.</tt><br>
<br>
<tt>Actually, it should be unblocked but with 0 as a return value. I'll take a look at that.</tt><br>
<br>
<tt><br>
&gt; <br>
&gt; Any suggestions?<br>
&gt; <br>
&gt; Thanks.<br>
&gt; <br>
&gt; Nacho.<br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA2FDFA961888f9e8a93df938690918c4EBBFA2FDFA96188--


