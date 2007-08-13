Message-ID: <46C0719B.1010102@domain.hid>
Date: Mon, 13 Aug 2007 16:58:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] rtcan bufferoverflow but no evidence
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi,

I seem to be getting major buffer overflow. Yet when I check the 
messages with rtcanrecv with relative time stamp I get confirmation of 
the fact that there are only two messages on the bus every ms and the 
EASILY fit withing the 1ms task. I have tried to mask all errors but see 
nothing. Why would i get about one billion messagebuffer overflow errors 
to syslog? How can I make these mysterious messages visible?

Or is there a setting that i may have wrong such that the rtcan rev 
function does not empty the ring buffer?

I hope there is something obvious I am doing wrong because this rtcan is 
really giving me a headache.

Kind regards,

Roland

