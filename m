Subject: Re: [Xenomai-help] send() from realtime task causes program shutdown
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <54b161f50611010545m5aa2f545v89f2c477dcba6dcf@domain.hid>
References: <54b161f50611010545m5aa2f545v89f2c477dcba6dcf@domain.hid>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 17:54:31 +0100
Message-Id: <1162400072.4983.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-11-01 at 14:45 +0100, Frits de Klark wrote:
> Hello everyone,
> 
> another question from me. Right now I have a very simple (and dirty)
> server program which listens for an incoming tcp connection, then
> starts a realtime task which sends a string to the connected client
> periodically. This all works fine, until I close the connection from
> the client side; In that case my server program just shuts down. It
> just returns to the command prompt (from where I started the server
> program) without any messages.
> 
> I noticed that this happens when my realtime task calls send() to send
> the string to the client. I do check on send() for a return value, but
> it looks like the program quits before this return value can be
> checked (i.e. somewhere during the send() call).
> 

The sender may receive SIGPIPE. Run your application over GDB to verify
that.

> Does anyone has any idea where this behaviour might come from? 
> 
> Thanks very much.
> 
> Best regards,
> 
> Frits
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



