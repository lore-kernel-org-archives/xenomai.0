Message-ID: <4D6B92C8.3070505@domain.hid>
Date: Mon, 28 Feb 2011 13:19:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1102281209570.12109@domain.hid>	<4D6B9032.5060907@domain.hid>
	<alpine.DEB.1.10.1102281325340.12109@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1102281325340.12109@domain.hid>
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
>>> problem, so others may reproduce it more easily. It seems I need a RTDM (dummy?)
>>> driver that triggers some hardware interrupts, a thread talking to it, and another
>>> thread making system calls such as select() etc...
>> Does it happen if you use other system calls than select?
> 
> According to the "CURRENT PROCESS" info from the kernel message when those faults
> occur, it happens also in threads that do not use select() at all. There is one
> master server thread that select()s on sockets listening for incoming
> connections and several workers that just recv() and send().

Sorry, what I mean, is, does the bug happen if no thread ever calls select?

-- 
                                                                Gilles.

