Message-ID: <54b161f50611060208m44287fb6o5ac0f305e21d08d7@domain.hid>
Date: Mon, 6 Nov 2006 11:08:52 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
Subject: Re: [Xenomai-help] Virtual CAN driver and RT Socket CAN
In-Reply-To: <454EF06A.8070207@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_59729_6518811.1162807732303"
References: <54b161f50611060005w3f65a255qa98da9259cecee0b@domain.hid>
	<454EF06A.8070207@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_59729_6518811.1162807732303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/6/06, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> Frits de Klark wrote:
> > Hello everyone,
> >
> > I'm not sure this is the right place to ask about it, but is the virtual
> > CAN driver mentioned in [1] of any use if I want to develop an
> > application using RT Socket CAN? If so, how do I set it up (just patch
> > the xenomai-root I guess) and how do I use it?
>
> The virtual CAN driver is already integrated in recent versions of
> Xenomai 2.3-devel, e.g. 2.3-rc1. Just install Xenomai as usual and
> enable RT-Socket-CAN and the driver virtual CAN driver in the kernel
> configuration.
>
> Wolfgang.
>

Ah, thanks. It's called the 'virtual tunneling driver' in the kernel config,
right?

But now for my second question: How do I set it up? Is it possible to use
the virtual driver to run the rtcansend/recv programs? If so, what actions
should I take to make this possible?

Thank you very much again.

Frits

------=_Part_59729_6518811.1162807732303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/6/06, <b class="gmail_sendername">Wolfgang Grandegger</b> &lt;<a href="mailto:wg@domain.hid">wg@domain.hid</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Frits de Klark wrote:<br>&gt; Hello everyone,<br>&gt;<br>&gt; I'm not sure this is the right place to ask about it, but is the virtual<br>&gt; CAN driver mentioned in [1] of any use if I want to develop an<br>&gt; application using RT Socket CAN? If so, how do I set it up (just patch
<br>&gt; the xenomai-root I guess) and how do I use it?<br><br>The virtual CAN driver is already integrated in recent versions of<br>Xenomai 2.3-devel, e.g. 2.3-rc1. Just install Xenomai as usual and<br>enable RT-Socket-CAN and the driver virtual CAN driver in the kernel
<br>configuration.<br><br>Wolfgang.<br></blockquote></div><br>
Ah, thanks. It's called the 'virtual tunneling driver' in the kernel config, right?<br>
<br>
But now for my second question: How do I set it up? Is it possible to
use the virtual driver to run the rtcansend/recv programs? If so, what
actions should I take to make this possible?<br>
<br>
Thank you very much again.<br>
<br>
Frits<br>

------=_Part_59729_6518811.1162807732303--

