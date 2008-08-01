Message-ID: <34db01c8f42b$57a4d350$0109220a@domain.hid>
From: "Henry Bausley" <hbausley@domain.hid>
References: <Pine.LNX.4.64.0804111759280.5433@domain.hid><4800B4FA.1050309@domain.hid><50879.62.235.129.158.1208014366.squirrel@domain.hid><18432.56533.343662.272421@domain.hid><Pine.LNX.4.64.0804171657380.18446@domain.hid><2ff1a98a0804170830v3b2fc392lf320f05a8c7f4e8d@domain.hid><2ff1a98a0804170846p2dddbea5k3b69dbbc57fb6761@domain.hid><480775C4.2060302@domain.hid><Pine.LNX.4.64.0804211731160.26198@domain.hid>
	<480DECDA.3070204@domain.hid>
Date: Fri, 1 Aug 2008 16:07:17 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Recurring Interrupts
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

How do I setup xenomai so that my ISR can be re-entered even if I am 
currently in it.

I have an external edge interrupt wired and it occurs every 250usec.  There 
are instances
when the interrupt can occur while I am currently in my ISR.

If another interrupt occurs while I am currently in my ISR I want my ISR to 
be called again
so I can flag that the condition occurred then exit the re-entered ISR and 
continue executing
the originally called ISR.


I am using a board based off the AMCC 440EP Yosemite and a Denx Kit with 
2.6.24 and Xenomai 2.4.2
This something I did with previously with RT Linux.  I have converted a 
large project from FSM RT Linux
to Xenomai and everything is functioning except this last item.




