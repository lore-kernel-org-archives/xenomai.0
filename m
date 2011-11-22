MIME-Version: 1.0
Sender: hadrienstegosaure@domain.hid
In-Reply-To: <4ECB967C.70509@domain.hid>
References: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>
	<4ECA2FF8.7040406@domain.hid>
	<CA+eKTkZuNknobLhsgqU8jjkKboL3jNLhMPoG82fkjD6sZfyXgA@mail.gmail.com>
	<4ECA5E12.5040907@domain.hid>
	<CAMesUR7edxnPvpLu0kajLWGtVBwK65m27kssOjh=JViVhPeXJQ@mail.gmail.com>
	<4ECB967C.70509@domain.hid>
Date: Tue, 22 Nov 2011 14:43:05 +0100
Message-ID: <CA+eKTkbcBYnoRnBZrrBQ-Br2h2HPrVdyVLs2V3F4WOvcvhpDxA@mail.gmail.com>
From: Hadrien Caron <hadrien.caron@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec51b984f9abc5704b252fbe9
Subject: Re: [Xenomai-help] [xenomai-help] Error return with a4l_sync_write
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
Cc: xenomai@xenomai.org

--bcaec51b984f9abc5704b252fbe9
Content-Type: text/plain; charset=ISO-8859-1

Alexis : yes I am using the Analogy drivers . . . Would that mean that
analog output is implemented but not digital output for National Instrument
acquisition cards ? Has someone tried this already ? Seems strange that
analog output would be implemented but not digital.

Anders : Ok ! I will look into rebulding my xenomai installation then !

Many thanks to both of you for your ideas !

Hadrien

On Tue, Nov 22, 2011 at 1:33 PM, Anders Blomdell <
anders.blomdell@domain.hid> wrote:

> On 11/22/2011 01:06 PM, Alexis Berlemont wrote:
>
>> Hi,
>>
>> On Mon, Nov 21, 2011 at 3:20 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org <gilles.chanteperdrix@xenomai.org>>
>>  wrote:
>>
>>> On 11/21/2011 12:10 PM, Hadrien Caron wrote:
>>>
>>>> Thanks very much Wolfang !
>>>> Cool script, I didn't know about it :)
>>>> I'll try to correct my code with that information !
>>>>
>>>> Thanks again,
>>>>
>>>
>>> ENOSYS usually means that you have not enabled the relevant support in
>>> kernel configuration.
>>>
>>>
>> Which driver are you using? I think analogy returns ENOSYS if the
>> driver does not implement the related instruction.
>>
> It can also happen with xenomai compiled with gcc-4.6.x, but without
> -fno-omit-frame-pointer :-(
>
> Regards
>
> Anders
>

--bcaec51b984f9abc5704b252fbe9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alexis : yes I am using the Analogy drivers . . . Would that mean that anal=
og output is implemented but not digital output for National Instrument acq=
uisition cards ? Has someone tried this already ? Seems strange that analog=
 output would be implemented but not digital.<br>

<br>Anders : Ok ! I will look into rebulding my xenomai installation then !=
<br><br>Many thanks to both of you for your ideas !<br><br>Hadrien<br><br><=
div class=3D"gmail_quote">On Tue, Nov 22, 2011 at 1:33 PM, Anders Blomdell =
<span dir=3D"ltr">&lt;<a href=3D"mailto:anders.blomdell@domain.hid" tar=
get=3D"_blank">anders.blomdell@domain.hid</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div>On 11/22/201=
1 01:06 PM, Alexis Berlemont wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Hi,<br>
<br>
On Mon, Nov 21, 2011 at 3:20 PM, Gilles Chanteperdrix<br>
&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"_blank">g=
illes.chanteperdrix@domain.hid.<u></u>org</a>&gt; =A0wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
On 11/21/2011 12:10 PM, Hadrien Caron wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Thanks very much Wolfang !<br>
Cool script, I didn&#39;t know about it :)<br>
I&#39;ll try to correct my code with that information !<br>
<br>
Thanks again,<br>
</blockquote>
<br>
ENOSYS usually means that you have not enabled the relevant support in<br>
kernel configuration.<br>
<br>
</blockquote>
<br>
Which driver are you using? I think analogy returns ENOSYS if the<br>
driver does not implement the related instruction.<br>
</blockquote></div>
It can also happen with xenomai compiled with gcc-4.6.x, but without -fno-o=
mit-frame-pointer :-(<br>
<br>
Regards<br><font color=3D"#888888">
<br>
Anders<br>
</font></blockquote></div><br>

--bcaec51b984f9abc5704b252fbe9--

