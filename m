Message-ID: <54b161f50611010545m5aa2f545v89f2c477dcba6dcf@domain.hid>
Date: Wed, 1 Nov 2006 14:45:35 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27204_17007507.1162388735771"
Subject: [Xenomai-help] send() from realtime task causes program shutdown
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

------=_Part_27204_17007507.1162388735771
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,

another question from me. Right now I have a very simple (and dirty) server
program which listens for an incoming tcp connection, then starts a realtime
task which sends a string to the connected client periodically. This all
works fine, until I close the connection from the client side; In that case
my server program just shuts down. It just returns to the command prompt
(from where I started the server program) without any messages.

I noticed that this happens when my realtime task calls send() to send the
string to the client. I do check on send() for a return value, but it looks
like the program quits before this return value can be checked (i.e.
somewhere during the send() call).

Does anyone has any idea where this behaviour might come from?

Thanks very much.

Best regards,

Frits

------=_Part_27204_17007507.1162388735771
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,<br>
<br>
another question from me. Right now I have a very simple (and dirty)
server program which listens for an incoming tcp connection, then
starts a realtime task which sends a string to the connected client
periodically. This all works fine, until I close the connection from
the client side; In that case my server program just shuts down. It
just returns to the command prompt (from where I started the server
program) without any messages.<br>
<br>
I noticed that this happens when my realtime task calls send() to send
the string to the client. I do check on send() for a return value, but
it looks like the program quits before this return value can be checked
(i.e. somewhere during the send() call).<br>
<br>
Does anyone has any idea where this behaviour might come from? <br>
<br>
Thanks very much.<br>
<br>
Best regards,<br>
<br>
Frits<br>

------=_Part_27204_17007507.1162388735771--

