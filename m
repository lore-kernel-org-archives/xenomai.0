Message-ID: <486B7E19.2040604@domain.hid>
Date: Wed, 02 Jul 2008 15:09:45 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <853493434@domain.hid>
In-Reply-To: <853493434@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
> Sorry, for my late answer.
> 
> I enabled the timerbench module, and installed it with the other modules (IRQ Benchmark and Context Switch).
> The Switchtest test works, so I think the modules are correct installed and the tests are able to load them.
> Does this mean the timerbench module isn't ok? Or are there other possible reasons, why the latency test still says:
> 
> bash-3.00# ./run -- -t 1
> *
> *
> * Type ^C to stop this application.
> *
> *
> == Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25

-ENOTTY. This is strange because it means that the IO-Control 
RTTST_RTIOC_TMBENCH_START is unknown by the timerbench driver. Do you 
happen to use different versions of Xenomai in kernel and userland? It 
could also help if you modify your latency and timerbench code to print 
out the values of RTTST_RTIOC_TMBENCH_START in order to detect a 
discrepancy between kernel and userland. If you don't know how to do 
this please tell us so we can provide you with a patch.

-- 
Sebastian

