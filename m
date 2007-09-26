Message-ID: <353969d40709260447l1b64e966hb500f8d3c0d4a0a@domain.hid>
Date: Wed, 26 Sep 2007 13:47:43 +0200
From: "Guillaume Gaudonville" <guillaume.gaudonville@domain.hid>
In-Reply-To: <46FA26C0.5050606@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7072_9675032.1190807263995"
References: <353969d40709260127s1c7fb5c6necdcf3591abc90f4@domain.hid>
	<46FA26C0.5050606@domain.hid>
Subject: Re: [Xenomai-core] new features for 16550A driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

------=_Part_7072_9675032.1190807263995
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/9/26, Jan Kiszka <jan.kiszka@domain.hid>:
>
> Guillaume Gaudonville wrote:
> > Hello,
> >
> > I'm working on a project which aims at porting an application
> > running under VxWorks to Linux. This application uses the serial
> > port.
> >
> > I would like to add an ioctl or a field in the config structure
> > to permit to strip or not the parity bit of each byte on reception. This
> > feature is implemented on Linux and VxWorks.
> >
> > Is it something I can do and then submit to Xenomai or your driver is
> only
> > an example and will never be improved?
>
> The driver is far from being just an example, it's used in real
> applications.


It was just to be sure... I'm using it for a real application.

If your feature is useful and doesn't turn the existing code upside
> down, it will surely be considered for merging.
>
> >
> > I think that I will have more feature to add to the driver, that's why
> I'm
> > asking this.
>
> I don't want to exclude anything (specifically as long as I haven't seen
> some patch yet), but I also don't want to overload the driver over the
> time with corner-case features. We need a good balance.
>
> But we first of all need more details about what you plan to add, what
> application scenario is behind it, why you need the driver to implement
> the feature, and what impact it may have on the code. You are welcome to
> elaborate on this or, even better, post some patch drafts here.


I don't  know  which  features  I'll need. For the ISTRIP feature the goal
is only to
remove the eigth'th bit of every byte received: I've got a VxWorks
application which communicate
with an external clock on the serial port. The clock uses the parity bit but
my application
do not. In the original code an ioctl was done to say the serial driver to
remove the parity bit on
reception. This feature is also offered under Linux and seems to be posix
(man tcsetattr, search ISTRIP).
In order to reduce the code modifications, I would like to implement it in
the driver.

If so, I think the better way would be to add a field in the rtser_config
struct, do you agree? And then depending
upon this field to apply a mask (0x7f) to the character in the interrupt
handler rt_16550_rx_interrupt() or only
to the characters passed to user space depending upon what is done in other
driver.
to reproduce the same behaviour).

Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>



-- 
Guillaume Gaudonville
E-mail: guillaume.gaudonville@domain.hid

------=_Part_7072_9675032.1190807263995
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/9/26, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Guillaume Gaudonville wrote:<br>&gt; Hello,<br>&gt;<br>&gt; I&#39;m working on a project which aims at porting an application<br>&gt; running under VxWorks to Linux. This application uses the serial<br>&gt; port.<br>&gt;<br>
&gt; I would like to add an ioctl or a field in the config structure<br>&gt; to permit to strip or not the parity bit of each byte on reception. This<br>&gt; feature is implemented on Linux and VxWorks.<br>&gt;<br>&gt; Is it something I can do and then submit to Xenomai or your driver is only
<br>&gt; an example and will never be improved?<br><br>The driver is far from being just an example, it&#39;s used in real<br>applications.</blockquote><div><br>It was just to be sure... I&#39;m using it for a real application.
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">If your feature is useful and doesn&#39;t turn the existing code upside<br>down, it will surely be considered for merging.
<br><br>&gt;<br>&gt; I think that I will have more feature to add to the driver, that&#39;s why I&#39;m<br>&gt; asking this.<br><br>I don&#39;t want to exclude anything (specifically as long as I haven&#39;t seen<br>some patch yet), but I also don&#39;t want to overload the driver over the
<br>time with corner-case features. We need a good balance.<br><br>But we first of all need more details about what you plan to add, what<br>application scenario is behind it, why you need the driver to implement<br>the feature, and what impact it may have on the code. You are welcome to
<br>elaborate on this or, even better, post some patch drafts here.</blockquote><div><br>I don&#39;t&nbsp; know&nbsp; which&nbsp; features&nbsp; I&#39;ll need. For the ISTRIP feature the goal is only to<br>remove the eigth&#39;th bit of every byte received: I&#39;ve got a VxWorks application which communicate
<br>with an external clock on the serial port. The clock uses the parity bit but my application<br>do not. In the original code an ioctl was done to say the serial driver to remove the parity bit on<br>reception. This feature is also offered under Linux and seems to be posix (man tcsetattr, search ISTRIP).
<br>In order to reduce the code modifications, I would like to implement it in the driver.<br><br>If so, I think the better way would be to add a field in the rtser_config struct, do you agree? And then depending<br>upon this field to apply a mask (0x7f) to the character in the interrupt handler rt_16550_rx_interrupt() or only
<br>to the characters passed to user space depending upon what is done in other driver.<br>to reproduce the same behaviour).<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Jan<br><br>--<br>Siemens AG, Corporate Technology, CT SE 2<br>Corporate Competence Center Embedded Linux<br></blockquote></div><br><br clear="all"><br>-- <br>Guillaume Gaudonville<br>E-mail: <a href="mailto:guillaume.gaudonville@domain.hid">
guillaume.gaudonville@domain.hid</a>

------=_Part_7072_9675032.1190807263995--

