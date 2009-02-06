MIME-Version: 1.0
In-Reply-To: <498C01C0.8010607@domain.hid>
References: <57e813c90902051622i1087er626e00fe9f65fa7@domain.hid>
	<498C01C0.8010607@domain.hid>
Date: Fri, 6 Feb 2009 08:35:24 -0200
Message-ID: <57e813c90902060235l61d188c8g8990f71e35da1963@domain.hid>
From: Zara Tustra <zarawesome@domain.hid>
Content-Type: multipart/alternative; boundary=0016e65875301bbe3804623d9475
Subject: Re: [Xenomai-help] timed looping task in device driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai@xenomai.org

--0016e65875301bbe3804623d9475
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Yes, I have read the API documentation.

> -EINVAL is returned if calling task is not in periodic mode.

How am I to put it in periodic mode then, if rtdm_task_init isn't doing it
for me?

On Fri, Feb 6, 2009 at 7:24 AM, Sebastian Smolorz <
smolorz@domain.hid> wrote:

> Zara Tustra wrote:
>
>> How would I set up a task that, say, turns a led on and off every second,
>> in
>> a device driver (module)? I've tried using rtdm_task_init and it's
>> successful, but when I use rtdm_task_wait_period, it returns -EINVAL.
>>
>
> Xenomai has a useful API documentation where all API calls and the return
> values are well explained. For your case see
>
>
> http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__rtdmtask.html#g577886a7588cdceac10f1b7b6ffcd1c7
>
> --
> Sebastian
>

--0016e65875301bbe3804623d9475
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yes, I have read the API documentation.<br><br>&gt; -EINVAL is returned if =
calling task is not in periodic mode.<br><br>How am I to put it in periodic=
 mode then, if rtdm_task_init isn&#39;t doing it for me?<br><br><div class=
=3D"gmail_quote">
On Fri, Feb 6, 2009 at 7:24 AM, Sebastian Smolorz <span dir=3D"ltr">&lt;<a =
href=3D"mailto:smolorz@domain.hid">smolorz@domain.hid</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">
<div><div></div><div class=3D"Wj3C7c">Zara Tustra wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
How would I set up a task that, say, turns a led on and off every second, i=
n<br>
a device driver (module)? I&#39;ve tried using rtdm_task_init and it&#39;s<=
br>
successful, but when I use rtdm_task_wait_period, it returns -EINVAL.<br>
</blockquote>
<br></div></div>
Xenomai has a useful API documentation where all API calls and the return v=
alues are well explained. For your case see<br>
<br>
<a href=3D"http://www.xenomai.org/documentation/branches/v2.4.x/html/api/gr=
oup__rtdmtask.html#g577886a7588cdceac10f1b7b6ffcd1c7" target=3D"_blank">htt=
p://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__rtdmtask.=
html#g577886a7588cdceac10f1b7b6ffcd1c7</a><br>

<br>
-- <br><font color=3D"#888888">
Sebastian<br>
</font></blockquote></div><br>

--0016e65875301bbe3804623d9475--

