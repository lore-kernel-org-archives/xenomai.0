Message-ID: <49FF08C4.40908@domain.hid>
Date: Mon, 04 May 2009 08:24:52 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A018D48CC@ARVMAIL1.mra.roland-man.biz>	<49FDFCC7.6000009@domain.hid>
	<20090504072304.A7E2483420E8@domain.hid>
In-Reply-To: <20090504072304.A7E2483420E8@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------030304040909060501070002"
Subject: Re: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030304040909060501070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

> >> 1.) If I don=B4t page align the size of shared memory (multiple of
> >> 4096)...
>  The restrictions for page allignments affect the addr and offset
>  paraemters only. To me it seems clear that mmap() in plain Linux and
>  Xenomai behave differently.

Sorry for not having the start of the thread. I'm not sure if it is=20
helpful to note that when I implemented memory mapped "device drivers"=20
for our system I had to align the address and offset to the page size=20
before the call to mmap would succeed. That was with plain Linux and the=20
driver also works with Xenomai.

                                      - Tom

--=20
Thomas Lockhart
Supervisor, Distributed and Real-time Group
Instrument Software and Science Data Systems
Caltech/JPL


--------------030304040909060501070002
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<span style="white-space: pre;">&gt;&gt;&gt; 1.) If I don&acute;t page align
the size of shared memory (multiple of <br>
&gt;&gt;&gt; 4096)...<br>
&gt; The restrictions for page allignments affect the addr and offset <br>
&gt; paraemters only. To me it seems clear that mmap() in plain Linux
and<br>
&gt; Xenomai behave differently.</span><br>
<br>
Sorry for not having the start of the thread. I'm not sure if it is
helpful to note that when I implemented memory mapped "device drivers"
for our system I had to align the address and offset to the page size
before the call to mmap would succeed. That was with plain Linux and
the driver also works with Xenomai.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Tom<br>
<br>
-- <br>
Thomas Lockhart<br>
Supervisor, Distributed and Real-time Group<br>
Instrument Software and Science Data Systems<br>
Caltech/JPL<br>
<br>
</body>
</html>

--------------030304040909060501070002--

