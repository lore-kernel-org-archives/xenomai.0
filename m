MIME-Version: 1.0
In-Reply-To: <4EEB3614.4080805@domain.hid>
References: <4EE9FD4A.1090202@domain.hid>
	<CAMwkeZw4X15HU7ABUhvLpXuu1Sbspen6FK7XvjHiQLXg0AcazQ@mail.gmail.com>
	<4EEB304B.2010108@domain.hid>
	<CAMwkeZyxGbvYRzDGJucFd-1n4iALRQed5x+fMCVMTFzWYPvfnw@domain.hid>
	<4EEB3614.4080805@domain.hid>
Date: Fri, 16 Dec 2011 13:30:25 +0100
Message-ID: <CAMwkeZwtUDw__OktsMYWwpgXpz1R+H54aOnRCPv4tgORVtqCiA@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=e89a8ff1c802ef5ff704b434c330
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

--e89a8ff1c802ef5ff704b434c330
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 16 de diciembre de 2011 13:14, Anders Blomdell <
anders.blomdell@domain.hid> escribi=C3=B3:

> On 12/16/2011 12:57 PM, Fernando Herrero Carr=C3=B3n wrote:
>
>>  [...]
>>
>>  Nice that somebody has already tested this.
>>>
>>>
>>
>>  Nobody that has any insight on what might slow down execution with 20%
>>> (curious mind wants to know)?
>>>
>>>
>> Dear Anders,
>>
>> I am afraid I don't understand your question. 20% with respect to what?
>> Indeed, the "sync_dma" function performs some copy between kernel/user
>> space. The old code performs exactly the same copy ten times, which
>> multiplies the time spent in the interrupt handler tenfold, and adds 10u=
s
>> in idle wait. Besides that, I believe that the most time spent in an
>> interrupt handler is in the i-pipe dispatching mechanism itself.
>>
> 20% difference in execution time in identical code paths (attachment 'A'
> and 'B'), where executing the same codepath in 'B' takes 20% longer time
> than in 'A'
>
>
Ok, sorry, I missed that. Well, I may be off the track with this, but I see
you're spending quite some time on some "prefetch" stuff that didn't appear
in my case (a 2.6.38.8 kernel). It may be worth taking a look at:
https://lwn.net/Articles/444336/

Fernando

--e89a8ff1c802ef5ff704b434c330
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">El 16 de diciembre de 2011 13:14, Anders=
 Blomdell <span dir=3D"ltr">&lt;<a href=3D"mailto:anders.blomdell@domain.hid=
th.se">anders.blomdell@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<div class=3D"im">On 12/16/2011 12:57 PM, Fernando Herrero Carr=C3=B3n wrot=
e:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
 =C2=A0[...]<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Nice that somebody has already tested this.<br>
<br>
</blockquote>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Nobody that has any insight on what might slow down execution with 20%<br>
(curious mind wants to know)?<br>
<br>
</blockquote>
<br>
Dear Anders,<br>
<br>
I am afraid I don&#39;t understand your question. 20% with respect to what?=
<br>
Indeed, the &quot;sync_dma&quot; function performs some copy between kernel=
/user<br>
space. The old code performs exactly the same copy ten times, which<br>
multiplies the time spent in the interrupt handler tenfold, and adds 10us<b=
r>
in idle wait. Besides that, I believe that the most time spent in an<br>
interrupt handler is in the i-pipe dispatching mechanism itself.<br>
</blockquote></div>
20% difference in execution time in identical code paths (attachment &#39;A=
&#39; and &#39;B&#39;), where executing the same codepath in &#39;B&#39; ta=
kes 20% longer time than in &#39;A&#39;<div class=3D"im"><br></div></blockq=
uote>
<div><br>Ok, sorry, I missed that. Well, I may be off the track with this, =
but I see you&#39;re spending quite some time on some &quot;prefetch&quot; =
stuff that didn&#39;t appear in my case (a 2.6.38.8 kernel). It may be wort=
h taking a look at: <a href=3D"https://lwn.net/Articles/444336/">https://lw=
n.net/Articles/444336/</a><br>
<br>Fernando <br></div></div><br>

--e89a8ff1c802ef5ff704b434c330--

