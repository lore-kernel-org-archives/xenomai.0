Message-ID: <4D6BA899.90600@domain.hid>
Date: Mon, 28 Feb 2011 14:52:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
	<4D6B9032.5060907@domain.hid>
	<alpine.DEB.1.10.1102281325340.12109@domain.hid>
	<4D6B92C8.3070505@domain.hid>
	<alpine.DEB.1.10.1102281342180.12109@domain.hid>
	<4D6B97E5.5030901@domain.hid>
	<alpine.DEB.1.10.1102281353490.12109@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1102281353490.12109@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] More blackfin kernel oops under heavy load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

Kolja Waschk wrote:
>>> Yes. I just tried and replaced the select with a loop accept()ing on the now
>>> nonblocking socket plus some usleep() and still the fault occurs as with
>>> select(). No other thread in the current setup uses select().
>> Mmmm busy waiting? But is Linux able to run from time to time?
> 
> Yes, an usleep(100000) after each "check" of all sockets allowed me to telnet
> into the system while the server runs, for example

I do not really understand what we are talking about. Are we talking
about Linux select/accept or Xenomai select/accept? Why not using the
blocking accept?

-- 
					    Gilles.

