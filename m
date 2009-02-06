MIME-Version: 1.0
In-Reply-To: <498C21A4.3010102@domain.hid>
References: <57e813c90902051622i1087er626e00fe9f65fa7@domain.hid>
	<498C01C0.8010607@domain.hid>
	<57e813c90902060235l61d188c8g8990f71e35da1963@domain.hid>
	<498C21A4.3010102@domain.hid>
Date: Fri, 6 Feb 2009 10:22:09 -0200
Message-ID: <57e813c90902060422h24e052cbv5c0361b4824e821@domain.hid>
From: Zara Tustra <zarawesome@domain.hid>
Content-Type: multipart/alternative; boundary=001636416b43e5df2404623f1158
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

--001636416b43e5df2404623f1158
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ret=rtdm_task_init (&toggle_led_task, "toggling_led", &toggling_led_proc,
NULL, 10, 1000000000);

  if (ret) {
    printk(KERN_DEBUG "error while setting periodic, code %d\n", ret);
    return;
  }
    else printk(KERN_DEBUG "task set periodic successfully\n");

On Fri, Feb 6, 2009 at 9:40 AM, Sebastian Smolorz <
smolorz@domain.hid> wrote:

> Zara Tustra wrote:
>
>> Yes, I have read the API documentation.
>>
>>  -EINVAL is returned if calling task is not in periodic mode.
>>>
>>
>> How am I to put it in periodic mode then, if rtdm_task_init isn't doing it
>> for me?
>>
>
> How does your rtdm_task_init() call looks like?
>
> --
> Sebastian
>

--001636416b43e5df2404623f1158
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ret=3Drtdm_task_init (&amp;toggle_led_task, &quot;toggling_led&quot;, &amp;=
toggling_led_proc, NULL, 10, 1000000000);<br><br>&nbsp; if (ret) {<br>&nbsp=
;&nbsp;&nbsp; printk(KERN_DEBUG &quot;error while setting periodic, code %d=
\n&quot;, ret);<br>
&nbsp;&nbsp;&nbsp; return;<br>&nbsp; }<br>&nbsp;&nbsp;&nbsp; else printk(KE=
RN_DEBUG &quot;task set periodic successfully\n&quot;);<br><br><div class=
=3D"gmail_quote">On Fri, Feb 6, 2009 at 9:40 AM, Sebastian Smolorz <span di=
r=3D"ltr">&lt;<a href=3D"mailto:smolorz@domain.hid">smolorz@domain.hid=
i-hannover.de</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"Ih2=
E3d">Zara Tustra wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Yes, I have read the API documentation.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
-EINVAL is returned if calling task is not in periodic mode.<br>
</blockquote>
<br>
How am I to put it in periodic mode then, if rtdm_task_init isn&#39;t doing=
 it<br>
for me?<br>
</blockquote>
<br></div>
How does your rtdm_task_init() call looks like?<br>
<br>
-- <br><font color=3D"#888888">
Sebastian<br>
</font></blockquote></div><br>

--001636416b43e5df2404623f1158--

