Message-ID: <4861F7F1.7080805@domain.hid>
Date: Wed, 25 Jun 2008 09:46:57 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <838862596@domain.hid>
In-Reply-To: <838862596@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] latency in kernel mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Joachim Meyer <Jogi95@domain.hid>
Cc: xenomai@xenomai.org

Joachim Meyer wrote:
> I still don't know what to do with the latency test in kernel mode.
[...]
> Here's the output:
> ---------------------------------------------------------------------------------------------
> bash-3.00# cd /usr/xenomai/testsuite/latency/
> bash-3.00# ./run -- -t1
> *
> *
> * Type ^C to stop this application.
> *
> *
> == Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25

Did you compile and load the kernel driver xeno_timerbench.ko?

-- 
Sebastian

