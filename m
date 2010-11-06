Message-ID: <4CD5B112.8040904@domain.hid>
Date: Sat, 06 Nov 2010 20:48:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimpz6=DWjrKLRoG6O5XGotgQX6FTZR+U2b54awU@mail.gmail.com>	<4CD55D61.7050208@domain.hid>	<AANLkTinw+H2shS4SpxhTS7GNOZptjR8xLpcwpzDtKDmi@domain.hid>	<4CD59C5F.6030808@domain.hid>
	<AANLkTikjovoR71pGkAOasVOENj4SiZ4hLYpSidvVxm06@domain.hid>
In-Reply-To: <AANLkTikjovoR71pGkAOasVOENj4SiZ4hLYpSidvVxm06@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] detect mode switches to primary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

Peter Pastor wrote:
> Hey Gilles,
> 
>>> There is no such thing as unwanted mode switches from secondary mode
> to primary mode.
> Really ?? I want to ensure that my boarder line thread runs in SECONDARY
> mode except when it is accessing the shared memory. The reason for that
> is that I want linux to be able to preempt that thread if necessary. I
> have enabled the Xenomai watchdog to kill real-time threads when they
> starve the linux kernel. Thus, the result is that this watchdog kills
> (or sometimes only preempts?) my boarder line thread (preempting is OK,
> but killing is NOT). I see that the watchdog kicked in in the logs
> (dmesg). This happens roughly every 5-10min or so... My idea is, that if
> I force the thread to run in secondary mode (after accessing the shared
> memory), it will be a regular linux thread (and can be preempted). Thus,
> having it switch to primary mode is unwanted, is it ?
> 
> What am I missing here ?

If the watchdog kills a thread, it means that the thread has an infinite
loop. The bug is this infinite loop, not the fact that the thread is
running in primary mode. You can install a handler for the watchdog
signal to see where the infinite loop is.

-- 
                                                                Gilles.

