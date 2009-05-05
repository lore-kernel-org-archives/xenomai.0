Message-ID: <4A006AFD.1030409@domain.hid>
Date: Tue, 05 May 2009 09:36:13 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A018D48CC@ARVMAIL1.mra.roland-man.biz>
	<49FDFCC7.6000009@domain.hid>
	<20090504072304.A7E2483420E8@domain.hid>
	<49FF08C4.40908@domain.hid>
	<20090504180134.D9D5283420E8@domain.hid>
In-Reply-To: <20090504180134.D9D5283420E8@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------050802000203030504020709"
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
--------------050802000203030504020709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>  But the problem that the origonal poster reported was  a  restriction
>  of  the "length" parameter - his test seems to demonstrate that
>  under Xenomai the legth must be a multiple of the page sise, while in
>  plain Linux no such restriction exists (I can provide test  code  for
>  that case, if wanted).

Hmm. My code does round the length to a multiple of the page size too. 
I'm pretty sure I would not have done this if it was not required but my 
svn notes are not explicit on this. The man page could be considered 
ambiguous: "EINVAL We  don't  like  start,  length, or offset (e.g., 
they are too large, or not aligned on a page boundary)." but only with a 
liberal reading of the sentence.

hth

                                      - Tom

-- 
Thomas Lockhart
Supervisor, Distributed and Real-time Group
Instrument Software and Science Data Systems
Caltech/JPL


--------------050802000203030504020709
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<span style="white-space: pre;">&gt; But the problem that the origonal
poster reported was&nbsp; a&nbsp; restriction<br>
&gt;&nbsp; of&nbsp; the "length" parameter - his test seems to demonstrate that<br>
&gt; under Xenomai the legth must be a multiple of the page sise, while
in<br>
&gt; plain Linux no such restriction exists (I can provide test&nbsp; code&nbsp;
for<br>
&gt; that case, if wanted).</span><br>
<br>
Hmm. My code does round the length to a multiple of the page size too.
I'm pretty sure I would not have done this if it was not required but
my svn notes are not explicit on this. The man page could be considered
ambiguous: "EINVAL We&nbsp; don&#8217;t&nbsp; like&nbsp; start,&nbsp; length, or offset (e.g.,
they are too large, or not aligned on a page boundary)." but only with
a liberal reading of the sentence.<br>
<br>
hth<br>
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

--------------050802000203030504020709--

