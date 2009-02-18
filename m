MIME-Version: 1.0
In-Reply-To: <6a782b880902170947q215c5686r2dd87d086d6073b3@domain.hid>
References: <6a782b880902170947q215c5686r2dd87d086d6073b3@domain.hid>
Date: Wed, 18 Feb 2009 12:26:23 +0000
Message-ID: <6a782b880902180426w4d4ef6beh1afa018d8e9b6566@domain.hid>
From: Thiago Lima <thiagolims@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd47d9c208f56046330872e
Subject: Re: [Xenomai-help] Hook Problems
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

--000e0cd47d9c208f56046330872e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

That's ok. I have already found the solution.

I used the following code to get the thread that fired the hook.

void start_hook(void *cookie) {
   xnthread_t *task;

   task = (xnthread_t*) cookie;

  (...)

}

[]s

On Tue, Feb 17, 2009 at 5:47 PM, Thiago Lima <thiagolims@domain.hid> wrote:

> Well,
>
> I have created a function in a linux kernel module and used
> rt_task_add_hook() to this function.
> I would like to obtain information about the thread that have fired the
> hook.
> Does anyone know how to do it ?
>
> I have already tried rt_task_self(), but i have no success.
>
> Thanks.
>
> att,
>
> --
> Thiago Lima Silva
> Computer Science Student - UFBA
> Registered Linux user #466887
>
>


-- 
Thiago Lima Silva
Computer Science Student - UFBA
Registered Linux user #466887

--000e0cd47d9c208f56046330872e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

That&#39;s ok. I have already found the solution.<br><br>I used the followi=
ng code to get the thread that fired the hook.<br><br>void start_hook(void =
*cookie) {<br>&nbsp;&nbsp; xnthread_t *task;<br><br>&nbsp;&nbsp; task =3D (=
xnthread_t*) cookie;<br>
<br>&nbsp; (...)<br><br>}<br><br>[]s<br><br><div class=3D"gmail_quote">On T=
ue, Feb 17, 2009 at 5:47 PM, Thiago Lima <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:thiagolims@domain.hid">thiagolims@domain.hid</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 2=
04, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Well,<br><br>I have created a function in a linux kernel module and used rt=
_task_add_hook() to this function.<br>I would like to obtain information ab=
out the thread that have fired the hook.<br>Does anyone know how to do it ?=
<br>

<br>I have already tried rt_task_self(), but i have no success.<br><br>Than=
ks.<br><br>att,<br clear=3D"all"><font color=3D"#888888"><br>-- <br>Thiago =
Lima Silva<br>Computer Science Student - UFBA<br>Registered Linux user #466=
887<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <font color=3D"#8888=
88"><br>Thiago Lima Silva<br>Computer Science Student - UFBA<br>Registered =
Linux user #466887</font><br><br>

--000e0cd47d9c208f56046330872e--

