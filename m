Message-ID: <7289437c0705310614g459c0720xcce9f024ea0bf91f@domain.hid>
Date: Thu, 31 May 2007 15:14:43 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <465EC7C1.5080300@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14714_31695405.1180617283975"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<465C6268.1090704@domain.hid>
	<18012.28254.882249.144005@domain.hid>
	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>
	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>
	<465D664E.3040700@domain.hid> <465E8FA8.4030507@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>
	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
	<465EC7C1.5080300@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
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

------=_Part_14714_31695405.1180617283975
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks a lot. It works fine.
And now I have the .so in /lib directory.


On 5/31/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Perrine Martignoni wrote:
> >> Perrine, did you happen to configure Xenomai with "configure --host=arm
> >> ..."? If yes (see config.log), please use "--host=arm-linux". This
> >> solved all issues for me.
> >>
> >> Awaiting your feedback!
> >
> > I configure Xenomai with --host=arm.
> > I tried to configure like this but it doesn't work :
> >
> > ./configure --build=arm-linux --host=arm-linux CC=arm-linux-gcc
>                      ^^^^^^^^^
> I guess you are not compiling Xenomai _on_ an ARM box, are you? :)
> Try --build=i686-linux here.
>
> Jan
>
>
>

------=_Part_14714_31695405.1180617283975
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Thanks a lot. It works fine.</div>
<div>And now I have the .so in /lib directory.<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 5/31/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt;&gt; Perrine, did you happen to configure Xenomai with &quot;configure --host=arm
<br>&gt;&gt; ...&quot;? If yes (see config.log), please use &quot;--host=arm-linux&quot;. This<br>&gt;&gt; solved all issues for me.<br>&gt;&gt;<br>&gt;&gt; Awaiting your feedback!<br>&gt;<br>&gt; I configure Xenomai with --host=arm.
<br>&gt; I tried to configure like this but it doesn&#39;t work :<br>&gt;<br>&gt; ./configure --build=arm-linux --host=arm-linux CC=arm-linux-gcc<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^<br>I guess you are not compiling Xenomai _on_ an ARM box, are you? :)
<br>Try --build=i686-linux here.<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_14714_31695405.1180617283975--

