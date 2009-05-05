Message-ID: <49FFD480.8010106@domain.hid>
Date: Mon, 04 May 2009 22:54:08 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <846584.44873.qm@domain.hid>
In-Reply-To: <846584.44873.qm@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------040906030800040606090202"
Subject: Re: [Xenomai-help] shared library in xenomai ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luan dinh <dinhluanbmt@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------040906030800040606090202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>  after that i write TEST program and use fuctions which my library
>  support. i can build and run TEST program but some functions in my
>  library doen't work ....

What does "doesn't work" mean? If the test program is willing to run 
then it is finding all symbols in the library and (I think) the library 
is finding all symbols it needs.

>  how to build and use my shared library in xenomai?

Did you try running ldd on your built library to make sure that the 
linking is finding all of the dependencies? Or please clarify what does 
not seem to be working for you...

hth

                                   - Tom

-- 
Thomas Lockhart
Supervisor, Distributed and Real-time Group
Instrument Software and Science Data Systems
Caltech/JPL


--------------040906030800040606090202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<span style="white-space: pre;">&gt; after that i write TEST program
and use fuctions which my library <br>
&gt; support. i can build and run TEST program but some functions in my<br>
&gt; library doen't work ....<br>
<br>
</span>What does "doesn't work" mean? If the test program is willing to
run then it is finding all symbols in the library and (I think) the
library is finding all symbols it needs.<br>
<span style="white-space: pre;"><br>
&gt; how to build and use my shared library in xenomai?</span><br>
<br>
Did you try running ldd on your built library to make sure that the
linking is finding all of the dependencies? Or please clarify what does
not seem to be working for you...<br>
<br>
hth<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Tom<br>
<br>
-- <br>
Thomas Lockhart<br>
Supervisor, Distributed and Real-time Group<br>
Instrument Software and Science Data Systems<br>
Caltech/JPL<br>
<br>
</body>
</html>

--------------040906030800040606090202--

