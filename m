Message-ID: <4C17762D.4010906@domain.hid>
Date: Tue, 15 Jun 2010 14:46:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C177276.7060005@domain.hid>
In-Reply-To: <4C177276.7060005@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to avoid a tight real time loop
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Daniele Nicolodi wrote:
> Hello. In my application I need to read data from an ADC card in blocks
> of a given number of samples. For efficiency I'm using an mmapped buffer
> to exchange data with the ADC driver. I'm setting up the acquisition,
> and then calling a loop like this:
> 
> unsigned int required = <compute required number of bytes>;
> unsigned int read = 0;
> while (1) {
>   while (read < required) {
>     read = a4l_pool(...);
>   }
>   process(buffer, ...);
> }
> 
> However if I run this loop in a real time thread the tight while loop is
> an obvious cpu hog: the watchdog kicks in and kills the thread.
> 
> There is not an analogy API that can be used to require a certain amount
> of data to the ADC driver. How can I code this loop to let other
> processes to run?

You should define a period, and how much data you want to process during
this period. Then make your task periodic, and wait for the next period
at the beginning of the loop.

> 
> Thanks. Cheers,


-- 
					    Gilles.

