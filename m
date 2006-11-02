Message-ID: <54b161f50611012350g10ab75e9sf9f14c05cdd5d7d7@domain.hid>
Date: Thu, 2 Nov 2006 08:50:38 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
Subject: Re: [Xenomai-help] send() from realtime task causes program shutdown
In-Reply-To: <1162400072.4983.30.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1970_8996514.1162453838820"
References: <54b161f50611010545m5aa2f545v89f2c477dcba6dcf@domain.hid>
	<1162400072.4983.30.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

------=_Part_1970_8996514.1162453838820
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/1/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Wed, 2006-11-01 at 14:45 +0100, Frits de Klark wrote:
> > Hello everyone,
> >
> > another question from me. Right now I have a very simple (and dirty)
> > server program which listens for an incoming tcp connection, then
> > starts a realtime task which sends a string to the connected client
> > periodically. This all works fine, until I close the connection from
> > the client side; In that case my server program just shuts down. It
> > just returns to the command prompt (from where I started the server
> > program) without any messages.
> >
> > I noticed that this happens when my realtime task calls send() to send
> > the string to the client. I do check on send() for a return value, but
> > it looks like the program quits before this return value can be
> > checked (i.e. somewhere during the send() call).
> >
>
> The sender may receive SIGPIPE. Run your application over GDB to verify
> that.
>
> Philippe.
>
>
This was indeed the case. I'm sorry to ask such a (afterwards) trivial
question. I couldn't remember it happened to me ever before, so I assumed it
had something to do with Xenomai. As it turns out, it doesn't.

Thanks a lot!

Frits

------=_Part_1970_8996514.1162453838820
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 11/1/06, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wed, 2006-11-01 at 14:45 +0100, Frits de Klark wrote:<br>&gt; Hello everyone,<br>&gt;<br>&gt; another question from me. Right now I have a very simple (and dirty)<br>&gt; server program which listens for an incoming tcp connection, then
<br>&gt; starts a realtime task which sends a string to the connected client<br>&gt; periodically. This all works fine, until I close the connection from<br>&gt; the client side; In that case my server program just shuts down. It
<br>&gt; just returns to the command prompt (from where I started the server<br>&gt; program) without any messages.<br>&gt;<br>&gt; I noticed that this happens when my realtime task calls send() to send<br>&gt; the string to the client. I do check on send() for a return value, but
<br>&gt; it looks like the program quits before this return value can be<br>&gt; checked (i.e. somewhere during the send() call).<br>&gt;<br><br>The sender may receive SIGPIPE. Run your application over GDB to verify<br>that.
<br><br>Philippe.<br><br></blockquote></div><br>
This was indeed the case. I'm sorry to ask such a (afterwards) trivial
question. I couldn't remember it happened to me ever before, so I
assumed it had something to do with Xenomai. As it turns out, it
doesn't.<br>
<br>
Thanks a lot!<br>
<br>
Frits<br>

------=_Part_1970_8996514.1162453838820--

