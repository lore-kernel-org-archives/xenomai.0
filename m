Message-ID: <fd6a47a90602280729xb39e0f4l@domain.hid>
Date: Tue, 28 Feb 2006 16:29:52 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-help] Page faults
In-Reply-To: <440466C6.9050706@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12941_15140911.1141140592823"
References: <fd6a47a90602280622o4cfb2b79g@domain.hid>
	<440466C6.9050706@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

------=_Part_12941_15140911.1141140592823
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> Maybe not all of your user memory is cleanly locked and got swapped out
> (swapping activated?). If you don't see kernel oopses and your programs
> don't receive segfaults, these faults are references to swapped out or
> not yet mapped in pages. BTW, what does the kernel console tell you?


I have a mlockall(MCL_CURRENT | MCL_FUTURE) in my main() (non-RT) task
alright. Do I need to repeat that for the real-time tasks as well ?

I'm quite certain that my kernel is configured for swapping. I did not see
any harm in it, as a mlockall() was given. Should I try turning it off (if
so, where) ?

I do not see 'oopses' and the dmesg log is clean, apart from one
incidental spurious IRQ7 interrupt. Is 'dmesg' what you mean by 'kernel
console' ?


Jeroen.

------=_Part_12941_15140911.1141140592823
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Maybe not all of your user memor=
y is cleanly locked and got swapped out<br>(swapping activated?). If you do=
n't see kernel oopses and your programs
<br>don't receive segfaults, these faults are references to swapped out or<=
br>not yet mapped in pages. BTW, what does the kernel console tell you?</bl=
ockquote>
<div>&nbsp;</div>
<div>I have a mlockall(MCL_CURRENT | MCL_FUTURE) in my main() (non-RT) task=
 alright. Do I need to repeat that for the real-time tasks as well ?</div>
<div>&nbsp;</div>
<div>I'm quite certain that my kernel is configured for swapping. I did not=
 see any harm in it, as a mlockall() was given. Should I try turning it off=
 (if so, where) ?</div>
<div>&nbsp;</div>
<div>I do not see 'oopses' and the dmesg log is clean, apart from one incid=
ental&nbsp;spurious IRQ7 interrupt. Is 'dmesg' what you mean by 'kernel con=
sole' ?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div></div>

------=_Part_12941_15140911.1141140592823--

