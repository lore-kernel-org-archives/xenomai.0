Message-ID: <4D6B97E5.5030901@domain.hid>
Date: Mon, 28 Feb 2011 13:41:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
	<4D6B9032.5060907@domain.hid>
	<alpine.DEB.1.10.1102281325340.12109@domain.hid>
	<4D6B92C8.3070505@domain.hid>
	<alpine.DEB.1.10.1102281342180.12109@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1102281342180.12109@domain.hid>
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
>> Sorry, what I mean, is, does the bug happen if no thread ever calls select?
> 
> Yes. I just tried and replaced the select with a loop accept()ing on the now
> nonblocking socket plus some usleep() and still the fault occurs as with
> select(). No other thread in the current setup uses select().

Mmmm busy waiting? But is Linux able to run from time to time?

-- 
                                                                Gilles.

