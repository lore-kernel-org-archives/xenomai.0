Message-ID: <49B6C954.4050301@domain.hid>
Date: Tue, 10 Mar 2009 21:11:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9C50C711-0F23-4D77-BE25-DC160A0B474C@comcast.net>
In-Reply-To: <9C50C711-0F23-4D77-BE25-DC160A0B474C@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm timers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Gilles believes he's on the track of our FPU issue when using kernel  
> threads. Would using an RTDM timer to accomplish our need have the  
> same issue? We would not use the FPU in the timer of course, because  
> it is not allowed.
> 
> I just don't want to spend the time converting things if it won't  
> help. Does the list think it would be a worthwhile effort?

We can not say for sure as long as we know what the bug is. But if it
is, as I suspect, a bug in the FPU switching logic for non-fxsr x86_32
cpus, you will not have it with a timer: when the timer fires, there is
no context switch and because of that you should have a lower latency
and a lower overhead of the driver using the timer (the downside, of
course, is that you can not call a function which sleeps). I do not know
however if it makes much difference on x86, to have an idea, compare the
output of klatency -t 1 and klatency -t 2.

-- 
					    Gilles.

