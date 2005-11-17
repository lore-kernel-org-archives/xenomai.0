In-Reply-To: <437C8299.3010503@domain.hid>
Subject: Re: [Xenomai-help] Blocking reads from pipes
Message-ID: <OF84150644.927CE822-ONC12570BC.00531CC2-C12570BC.00536AFA@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Thu, 17 Nov 2005 16:11:08 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA2FDFC09A528f9e8a93df938690918c4EBBFA2FDFC09A52"
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

--0__=4EBBFA2FDFC09A528f9e8a93df938690918c4EBBFA2FDFC09A52
Content-type: text/plain; charset=US-ASCII


>
> >As a conclusion, the behaviour that you observed with Xenomai
> >pipes seems consistent with that of Linux' named pipes, except
> >that in Linux read() returns 0, and not an error code as you
> >observed with Xenomai.
> >
> >
> The read() call does *not* return when you close the *same* file handle
> from another pthread in the same process.

I confirm that and as I pointed it out in my previous mail - this is not
how it's supposed to be.
I'm currently on it. More news later.


> Nacho.
>

---

Dmitry
--0__=4EBBFA2FDFC09A528f9e8a93df938690918c4EBBFA2FDFC09A52
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>&gt; <br>
&gt; &gt;As a conclusion, the behaviour that you observed with Xenomai <br>
&gt; &gt;pipes seems consistent with that of Linux' named pipes, except <br>
&gt; &gt;that in Linux read() returns 0, and not an error code as you <br>
&gt; &gt;observed with Xenomai.<br>
&gt; &gt; &nbsp;<br>
&gt; &gt;<br>
&gt; The read() call does *not* return when you close the *same* file handle<br>
&gt; from another pthread in the same process.</tt><br>
<br>
<tt>I confirm that and as I pointed it out in my previous mail - this is not how it's supposed to be.</tt><br>
<tt>I'm currently on it. More news later.</tt><br>
<tt><br>
</tt><br>
<tt>&gt; Nacho.<br>
&gt; <br>
</tt><br>
<tt>---</tt><br>
<br>
<tt>Dmitry</tt><br>
</body></html>
--0__=4EBBFA2FDFC09A528f9e8a93df938690918c4EBBFA2FDFC09A52--


