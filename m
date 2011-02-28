Date: Mon, 28 Feb 2011 13:25:46 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D6B9032.5060907@domain.hid>
Message-ID: <alpine.DEB.1.10.1102281325340.12109@domain.hid>
References: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
	<4D6B9032.5060907@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] More blackfin kernel oops under heavy load
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

>> problem, so others may reproduce it more easily. It seems I need a RTDM (dummy?)
>> driver that triggers some hardware interrupts, a thread talking to it, and another
>> thread making system calls such as select() etc...
>
> Does it happen if you use other system calls than select?

According to the "CURRENT PROCESS" info from the kernel message when those faults
occur, it happens also in threads that do not use select() at all. There is one
master server thread that select()s on sockets listening for incoming
connections and several workers that just recv() and send().

Kolja



