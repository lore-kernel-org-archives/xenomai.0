MIME-Version: 1.0
In-Reply-To: <49C4AD34.7010303@domain.hid>
References: <1237546591.9844.115.camel@domain.hid>
	<49C381F8.9070107@domain.hid>
	<1237563537.9844.150.camel@domain.hid>
	<49C4AD34.7010303@domain.hid>
Date: Sat, 21 Mar 2009 18:26:45 +0200
Message-ID: <b131c9f0903210926j5d0ef32emec061956dfe9000c@domain.hid>
From: vikesh rambaran <vikesh.rambaran@domain.hid>
Content-Type: multipart/alternative; boundary=00032557497ecfe31c0465a37f02
Subject: Re: [Xenomai-help] rtserial interface stalls
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
Cc: xenomai-help <xenomai@xenomai.org>

--00032557497ecfe31c0465a37f02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Sat, Mar 21, 2009 at 11:02 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

> Vikesh Rambaran wrote:
> > On Fri, 2009-03-20 at 12:46 +0100, Jan Kiszka wrote:
> >> Vikesh Rambaran wrote:
> >>> ...
> >>> Alternative tried (after a bit of debugging)
> >>> -----------------
> >>>
> >>> Changed  serialConfig.tx_timeout       = RTSER_DEF_TIMEOUT;
> >>> to       serialConfig.tx_timeout       = RTDM_TIMEOUT_NONE;
> >>>
> >>> Task 2 then runs continuously. Writing to rtser0 returns valid number
> of
> >>> bytes written but no data appears on serial port pin. At the same time
> >>> rtser1 functions normally.
> >> Without feedback from the device about its tx queue state you may
> >> quickly overload it this way (definitely if written bytes > fifo
> length).
> >>
> >
> > The idea is to write data into the devices' circular buffer and return
> > immediately. If there is not enough place in the buffer, i expected
> > the write call to return an error code or fewer bytes than that which
> > was requested. That would indicate a buffer overrun condition which can
> > be flagged at application level. This way the task will not be delayed
> > and other important functionality can be executed in a deterministic
> > way.
> >
> > The data transmitted on each serial channel is less than 150 bytes at
> > 115200kb/s with the task having a fixed period of 20mS. This should not
> > overflow default 4k buffers of the 16550A driver.
> >
> > Well that's the plan:) Did i perhaps misunderstand the implementation
> > for the tx_timeout ?
> >
>
> No, I agree your approach is valid, and even non-blocking write should
> behave as you expected. I actually forgot that the uart driver is that
> smart - at least in theory. Something else is fishy.


:) Yes the uart driver is brimming with features !

>
> When you switch to non-blocking, is there no data at all written, or
> does transmission stop roughly around where blocking write would stop
> the writer?
>

I came across a *stupid* mistake that i made with regards displaying the
error code
of the write function! Apologies for noise on that one.

 The return codes are exactly as we would expect in the non-blocking mode.
After running normally for a while, the write function for rtser0, returns a
positive
value that is less than the requested number of bytes. Thereafter the
function returns
-EAGAIN, for consecutive writes. This occurs at the same place where the
blocking write
stops the task.

I've also displayed the error codes returned from the read calls. On some
occasions, just prior to
the above error, the read call returns -EIO, with the LSR = 0x02 (overrun)
and MSR = 0xFB.

Need to spend some time understanding that one ...

On another note, the RS422 signal levels on the 2nd PC interfacing to our
realtime simulator
PC is a bit low. Will try to get another RS422 converter for the 2nd PC and
repeat the tests to see
if that is influencing it adversely. For comparison, i did measure the
signals when the realtime
simulator interfaced to the actual hardware (autopilot) and the levels were
acceptable.


> Jan
>
> Thanx for your help thus far
Vicki


>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

--00032557497ecfe31c0465a37f02
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sat, Mar 21, 2009 at 11:02 AM, Jan Ki=
szka <span dir=3D"ltr">&lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@=
web.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
<div class=3D"im">Vikesh Rambaran wrote:<br>
&gt; On Fri, 2009-03-20 at 12:46 +0100, Jan Kiszka wrote:<br>
&gt;&gt; Vikesh Rambaran wrote:<br>
</div>&gt;&gt;&gt; ...<br>
<div class=3D"im">&gt;&gt;&gt; Alternative tried (after a bit of debugging)=
<br>
&gt;&gt;&gt; -----------------<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Changed =A0serialConfig.tx_timeout =A0 =A0 =A0 =3D RTSER_DEF_T=
IMEOUT;<br>
&gt;&gt;&gt; to =A0 =A0 =A0 serialConfig.tx_timeout =A0 =A0 =A0 =3D RTDM_TI=
MEOUT_NONE;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Task 2 then runs continuously. Writing to rtser0 returns valid=
 number of<br>
&gt;&gt;&gt; bytes written but no data appears on serial port pin. At the s=
ame time<br>
&gt;&gt;&gt; rtser1 functions normally.<br>
&gt;&gt; Without feedback from the device about its tx queue state you may<=
br>
&gt;&gt; quickly overload it this way (definitely if written bytes &gt; fif=
o length).<br>
&gt;&gt;<br>
&gt;<br>
&gt; The idea is to write data into the devices&#39; circular buffer and re=
turn<br>
&gt; immediately. If there is not enough place in the buffer, i expected<br=
>
&gt; the write call to return an error code or fewer bytes than that which<=
br>
&gt; was requested. That would indicate a buffer overrun condition which ca=
n<br>
&gt; be flagged at application level. This way the task will not be delayed=
<br>
&gt; and other important functionality can be executed in a deterministic<b=
r>
&gt; way.<br>
&gt;<br>
&gt; The data transmitted on each serial channel is less than 150 bytes at<=
br>
&gt; 115200kb/s with the task having a fixed period of 20mS. This should no=
t<br>
&gt; overflow default 4k buffers of the 16550A driver.<br>
&gt;<br>
&gt; Well that&#39;s the plan:) Did i perhaps misunderstand the implementat=
ion<br>
&gt; for the tx_timeout ?<br>
&gt;<br>
<br>
</div>No, I agree your approach is valid, and even non-blocking write shoul=
d<br>
behave as you expected. I actually forgot that the uart driver is that<br>
smart - at least in theory. Something else is fishy.</blockquote><div>=A0</=
div><div>:) Yes the uart driver is brimming with features !<br></div><block=
quote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 2=
04); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
When you switch to non-blocking, is there no data at all written, or<br>
does transmission stop roughly around where blocking write would stop<br>
the writer?<br>
<font color=3D"#888888"></font></blockquote><div>=A0<br>I came across a *st=
upid* mistake that i made with regards displaying the error code <br>of the=
 write function! Apologies for noise on that one.<br><br>=A0The return code=
s are exactly as we would expect in the non-blocking mode.<br>
After running normally for a while, the write function for rtser0, returns =
a positive <br>value that is less than the requested number of bytes. There=
after the function returns<br>-EAGAIN, for consecutive writes. This occurs =
at the same place where the blocking write<br>
stops the task.<br><br>I&#39;ve also displayed the error codes returned fro=
m the read calls. On some occasions, just prior to<br>the above error, the =
read call returns -EIO, with the LSR =3D 0x02 (overrun) and MSR =3D 0xFB.<b=
r>
<br>Need to spend some time understanding that one ...<br><br>On another no=
te, the RS422 signal levels on the 2nd PC interfacing to our realtime simul=
ator <br>PC is a bit low. Will try to get another RS422 converter for the 2=
nd PC and repeat the tests to see <br>
if that is influencing it adversely. For comparison, i did measure the sign=
als when the realtime<br>simulator interfaced to the actual hardware (autop=
ilot) and the levels were acceptable.<br><br></div><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">
<font color=3D"#888888"><br>
Jan<br>
<br>
</font></blockquote><div>Thanx for your help thus far<br>
Vicki<br>=A0
<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>___=
____________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br></blockquote></div><br>

--00032557497ecfe31c0465a37f02--

