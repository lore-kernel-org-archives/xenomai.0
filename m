References: <CAFZ-hKgWry7tMon0SiDSjkAWgamznLzS_dfjLkUzB_n36-JJtQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Serial Port
In-reply-to: <CAFZ-hKgWry7tMon0SiDSjkAWgamznLzS_dfjLkUzB_n36-JJtQ@mail.gmail.com>
Date: Thu, 11 Feb 2021 13:52:10 +0100
Message-ID: <87r1lmkbr9.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leandro Bucci <guestleandro11@gmail.com>
Cc: xenomai@xenomai.org


Leandro Bucci via Xenomai <xenomai@xenomai.org> writes:

> hello everyone, I wanted to ask if it is possible to make two devices
> (Raspberry with xenomai) communicate through rs232 serial port, without
> having to go to Linux and do domain switch

There is more than a single PI model, you may want to be more
specific. Anyway, there are two types of uarts on a pi, one or more
PL011 uarts and a single mini-uart which is a 8250. The CPU frequency
affects the baud rate of the mini-uart, so using it implies fixing the
governor to get a stable rate. Although there is a RTDM driver for the
8250, there is none for the the PL011.

Back to your question, the answer is yes, provided you implement a RTDM
driver for the PL011 uart unless the capabilities and requirements of
the mini-uart are fine with you.

-- 
Philippe.

