Message-ID: <4B5885B3.9030001@domain.hid>
Date: Thu, 21 Jan 2010 17:49:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <065A7D06F7D4E546A18E80E08D066E18146A3016C3@domain.hid>	<4B4B64AF.3040704@domain.hid>	<065A7D06F7D4E546A18E80E08D066E18146A301A0A@ILMA1.IL.NDS.COM>		<4B4C5EDA.5000703@domain.hid>	<065A7D06F7D4E546A18E80E08D066E18146A341B1B@ILMA1.IL.NDS.COM>	<4B4F2F05.1040407@domain.hid>	<065A7D06F7D4E546A18E80E08D066E18146A3CE4CA@ILMA1.IL.NDS.COM>	
	<4B5881AB.4080102@domain.hid>
	<4B5883B8.3090406@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A3CE4D0@domain.hid>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E18146A3CE4D0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai user app working very slowly - "select"
 issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Landau, Bracha wrote:
> Each thread represents a different physical resource. The message
> queue feeding into the thread contains messages that may be serviced
> by any one of the resources.
> 
> 1) Why would there be spurious wakeups?

Read my mail again. I explained it.

> 2) I did the mq_open as nonblocking. 3) It did "work", but all the
> messages were serviced by a single thread. This is as opposed to the
> regular (non-xenomai) implementation, in which the messages are
> distributed evenly among the threads.

It is the second time you tell me this. And this mail is the third time
I ask you to show me some code proving your affirmations.

Maybe you are right, maybe you are not and your code is buggy.
Therefore, until I receive a valid test case proving your affirmations,
I will do nothing about them.

-- 
					    Gilles.

