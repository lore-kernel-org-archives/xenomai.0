MIME-Version: 1.0
In-Reply-To: <4EEB304B.2010108@domain.hid>
References: <4EE9FD4A.1090202@domain.hid>
	<CAMwkeZw4X15HU7ABUhvLpXuu1Sbspen6FK7XvjHiQLXg0AcazQ@mail.gmail.com>
	<4EEB304B.2010108@domain.hid>
Date: Fri, 16 Dec 2011 12:57:35 +0100
Message-ID: <CAMwkeZyxGbvYRzDGJucFd-1n4iALRQed5x+fMCVMTFzWYPvfnw@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=f46d041b4a8286be3004b4344e28
Subject: Re: [Xenomai-help] Big differences in analogy interrupt handling
	time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--f46d041b4a8286be3004b4344e28
Content-Type: text/plain; charset=UTF-8

 [...]

> Nice that somebody has already tested this.
>


> Nobody that has any insight on what might slow down execution with 20%
> (curious mind wants to know)?
>

Dear Anders,

I am afraid I don't understand your question. 20% with respect to what?
Indeed, the "sync_dma" function performs some copy between kernel/user
space. The old code performs exactly the same copy ten times, which
multiplies the time spent in the interrupt handler tenfold, and adds 10us
in idle wait. Besides that, I believe that the most time spent in an
interrupt handler is in the i-pipe dispatching mechanism itself.

There are for sure other people in the list more knowledgeable than me on
this subject.

Fernando.

--f46d041b4a8286be3004b4344e28
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><div>=C2=A0[...]</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><div class=3D"im">Nice that somebody has alread=
y tested this.<br>
</div></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div class=3D"im">
Nobody that has any insight on what might slow down execution with 20% (cur=
ious mind wants to know)?<br></div></blockquote></div><br>Dear Anders,<br><=
br>I am afraid I don&#39;t understand your question. 20% with respect to wh=
at? Indeed, the &quot;sync_dma&quot; function performs some copy between ke=
rnel/user space. The old code performs exactly the same copy ten times, whi=
ch multiplies the time spent in the interrupt handler tenfold, and adds 10u=
s in idle wait. Besides that, I believe that the most time spent in an inte=
rrupt handler is in the i-pipe dispatching mechanism itself.<br>
<br>There are for sure other people in the list more knowledgeable than me =
on this subject.<br><br>Fernando.<br><br>

--f46d041b4a8286be3004b4344e28--

