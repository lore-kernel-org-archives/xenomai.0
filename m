Message-ID: <b647ffbd0603101233ha0d9adcw@domain.hid>
Date: Fri, 10 Mar 2006 22:33:25 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Xenomai vs. RTLinux
In-Reply-To: <4411B23E.8000300@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7445_23470078.1142022805878"
References: <440F5F23.7000703@domain.hid> <44118EDC.2010003@domain.hid>
	<4411B23E.8000300@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_7445_23470078.1142022805878
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[skip-skip-skip]

I'm not quite clear on the memory allocation question.  Does Xenomai have
> the same restriction on allocating memory after a real-time task has been
> created?  I had been thinking that memory allocation could be done from t=
he
> linux context, or by a real-time task in secondary mode.


As one may issue Linux system calls from real-time tasks (causing a switch
to the secondary domain), malloc() ( -> sbrk() system call) or any other
memory allocation mechanism like C++'s new() does not make a big difference=
.
The only additional advice though, is that all pages should be "locked" in
the physical memory so to prevent them from being occasionally swapped out.
mlockall() with MCL_FUTURE comes in handy to this goal.

Of course, the rule remains to be the same as you pointed out, - calling
malloc() or most of other linux system calls is not something one would lik=
e
to do (at least being in good memory) inside time-critical code fragments.


>
> -Jeff
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>



--
Best regards,
Dmitry Adamushko

------=_Part_7445_23470078.1142022805878
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><div><br>
[skip-skip-skip] <br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I'm
not quite clear on the memory allocation question.&nbsp;&nbsp;Does
Xenomai have the same restriction on allocating memory after a
real-time task has been created?&nbsp;&nbsp;I had been thinking that
memory allocation could be done from the linux context, or by a
real-time task in secondary mode.</blockquote><div><br>
As one may issue Linux system calls from real-time tasks (causing a
switch to the secondary domain), malloc() ( -&gt; sbrk() system call)
or any other memory allocation mechanism like C++'s new() does not make
a big difference.<br>
The only additional advice though, is that all pages should be &quot;locked=
&quot;
in the physical memory so to prevent them from being occasionally
swapped out. mlockall() with MCL_FUTURE comes in handy to this goal.<br>
<br>
Of course, the rule remains to be the same as you pointed out, -
calling malloc() or most of other linux system calls is not something
one would like to do (at least being in good memory) inside
time-critical code fragments.<br>
&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px sol=
id rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>-=
Jeff<br><br>_______________________________________________<br>Xenomai-help=
 mailing list
<br><a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br><a =
href=3D"https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/li=
stinfo/xenomai-help</a><br></blockquote></div><br><br clear=3D"all"><br>-- =
<br>
Best regards,<br>Dmitry Adamushko

------=_Part_7445_23470078.1142022805878--

