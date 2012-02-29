Message-ID: <4F4E630C.8020301@domain.hid>
Date: Wed, 29 Feb 2012 18:40:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEc6OSwfGvfwXM3vqtAXd7o_XeMhSmuvj8mkd8ziLXQSMyK0aA@mail.gmail.com>
In-Reply-To: <CAEc6OSwfGvfwXM3vqtAXd7o_XeMhSmuvj8mkd8ziLXQSMyK0aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Execution time profiling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Charles Lesire-Cabaniols <charles.lesire@domain.hid>
Cc: xenomai@xenomai.org

On 02/29/2012 06:29 PM, Charles Lesire-Cabaniols wrote:
> Hi guys,
> 
> I have installed a Debian+Xenomai (2.6.0) OS on my Gumstix Overo.
> 
> I want to evaluate the execution time of a simple program, executed as a
> real-time thread.
> 
> I definitely wonder about which functions to use, as I have completely
> inconsistent measures.
> I have tried using rt_timer_read, rt_timer_tsc, clock_gettime.
> I also directly read the CNNT register with ARM instructions (which is the
> only one I think correct) in order to have a (good?) reference.
> (...)
> What am I doing wrong?

So, you should printf("%Lu %Lu\n", rt_timer_read(), rt_timer_tsc());

Not printf("%lu", ...)

-- 
					    Gilles.

