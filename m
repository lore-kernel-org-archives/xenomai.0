Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <1158326750.5072.2.camel@domain.hid>
References: <3BDC517D-07A0-4BD3-9C6A-332E76B32615@domain.hid>
	<1158250677.5040.199.camel@domain.hid>
	<38A01364-EC56-46D9-9768-A14979EA98E5@domain.hid>
	<1158326750.5072.2.camel@domain.hid>
Content-Type: multipart/alternative; boundary=Apple-Mail-45--289486368
Message-Id: <DE56BFC0-D567-44CE-99A1-869B458AE896@domain.hid>
From: ckreider <ckreider@domain.hid>
Subject: Re: [Xenomai-help] inscrutable pipes
Date: Sat, 16 Sep 2006 07:32:19 -0400
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


--Apple-Mail-45--289486368
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


>>>
>>> Could you try it, and let us know if it solves the issue you raised?
>>
>> Yes, the issues are solved using Xenomi-2.2.x (gotten via svn) and
>> linux-2.6.17.13
>
> Ok, thanks.

I think I will expand on this because Xenomai coders are on this list.

We have two product lines that have been made for several years with  
custom hardware and proprietary RTOS.  We decided to migrate these to  
COTS hardware and Linux.  Conventional wisdom, right?  The other line  
migrated first.  There was pain, but not unbearable.  We used RTLinux  
because we needed something that could sample the A/D card at  
predictable intervals and it was what was available at the time.  I  
recently embarked on the conversion of my line and ran into a big  
problem.  My A/D card controls the timing, so I shouldn't need and  
RTOS.  I have a serial stream of 20 byte packets at 60 hz, but Linux  
should handle that, right?  Well, if I had Mot serial chips that did  
hardware handshake, it would be OK, but COTS hardware has 16550s  
which require and interrupt to drop the handshake line(s).  If Linux  
it too busy to service an interrupt for a full receive fifo, how is  
it going to handle the handshake?  It can't.  So I was dropping bytes  
every so often.  Linux didn't have to mask the interrupt for long,  
just a fifo full at 38400. So it wsa RTOS time.  I picked Xenomai  
this time primarily because of the patent issues, but it has a serial  
driver also.  I am not sorry. Yeah, there was some pain with the  
pipes, but it is working slick now.  The serial task is only using  
0.1% of a relatively slow CPU.  I like the status in/proc.  I like  
the level of support here.  Most of all, I like the quality of  
Xenomai.  Fantastic job all who are involved in Xenomai, and a  
heartfelt thanks.

---
Carl Kreider
ckreider@domain.hid




--Apple-Mail-45--289486368
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><BR><DIV><BLOCKQUOTE =
type=3D"cite"><BLOCKQUOTE type=3D"cite"><BLOCKQUOTE type=3D"cite"><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Could =
you try it, and let us know if it solves the issue you raised?</DIV> =
</BLOCKQUOTE><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Yes, the issues are solved using Xenomi-2.2.x =
(gotten via svn) and</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">linux-2.6.17.13</DIV> =
</BLOCKQUOTE><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Ok, thanks.</DIV></BLOCKQUOTE></DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>I think I will expand on this =
because Xenomai coders are on this list.<DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>We have two product lines =
that have been made for several years with custom hardware and =
proprietary RTOS.=A0 We decided to migrate these to COTS hardware and =
Linux.=A0 Conventional wisdom, right?=A0 The other line migrated first.=A0=
 There was pain, but not unbearable.=A0 We used RTLinux because we =
needed something that could sample the A/D card at predictable intervals =
and it was what was available at the time.=A0 I recently embarked on the =
conversion of my line and ran into a big problem.=A0 My A/D card =
controls the timing, so I shouldn't need and RTOS.=A0 I have a serial =
stream of 20 byte packets at 60 hz, but Linux should handle that, =
right?=A0 Well, if I had Mot serial chips that did hardware handshake, =
it would be OK, but COTS hardware has 16550s which require and interrupt =
to drop the handshake line(s).=A0 If Linux it too busy to service an =
interrupt for a full receive fifo, how is it going to handle the =
handshake?=A0 It can't.=A0 So I was dropping bytes every so often.=A0 =
Linux didn't have to mask the interrupt for long, just a fifo full at =
38400. So it wsa RTOS time.=A0 I picked Xenomai this time primarily =
because of the patent issues, but it has a serial driver also.=A0 I am =
not sorry. Yeah, there was some pain with the pipes, but it is working =
slick now.=A0 The serial task is only using 0.1% of a relatively slow =
CPU.=A0 I like the status in/proc.=A0 I like the level of support here.=A0=
 Most of all, I like the quality of Xenomai.=A0 Fantastic job all who =
are involved in Xenomai, and a heartfelt thanks.</DIV><DIV><BR><DIV> =
<SPAN class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Palatino; =
font-size: 14px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Palatino; =
font-size: 14px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>---</DIV><DIV>Carl Kreider</DIV><DIV><A =
href=3D"mailto:ckreider@domain.hid">ckreider@domain.hid</A></DIV><DIV><B=
R class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN></SPAN> =
</DIV><BR></DIV></BODY></HTML>=

--Apple-Mail-45--289486368--

