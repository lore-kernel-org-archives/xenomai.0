Message-ID: <4651AC93.5010500@domain.hid>
Date: Mon, 21 May 2007 16:28:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <46519AD0.80804@domain.hid>
In-Reply-To: <46519AD0.80804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] 10us periodical task (Xenomai vs. RTAI)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: plyatov@domain.hid
Cc: xenomai@xenomai.org

Igor Plyatov wrote:
> Is it possible to get 10us results in Xenomai or not?

Running a task with a period of 10us is usually considered a bit out of
the scope of Xenomai. Nevertheles, there were some recent improvements
on Xenomai trunk that might make this possible. It would be interesting
if you tested this with trunk and tell us whether it works.

Also note that in order to get ultra-low latencies, you have to properly
calibrate the nucleus latency (/proc/xenomai/latency).

> May be better to use only ADEOS functions for my task, is it faster then
> RTDM?

Adeos has no notion of a "task", so, you would have to implement your
task in an interrupt handler, and yes, you would get better performance
(see for example the difference between latency -t 2 and latency -t 1).

> What is the state of RTAI nowadays, is it still a live?

Well, you are not asking on the right mailing list. Try RTAI mailing list.

-- 
                                                 Gilles Chanteperdrix

