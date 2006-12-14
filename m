Message-ID: <45819645.5020600@domain.hid>
Date: Thu, 14 Dec 2006 19:21:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Latency trace on ARM
References: <E1GutB2-0005VT-Vb@domain.hid>
In-Reply-To: <E1GutB2-0005VT-Vb@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main@gna.org

Sebastian Smolorz wrote:
> Hi,
> 
> we all know that the latency test should not be run with a period of 100 us 
> because it easily gets locked up. The attached trace illustrates this problem 
> in detail. It shows that a timer interrupt needs about 50 us to be processed. 
> Furthermore, there is not enough time between two timer interrupts for the 
> latency task to get all its work done.

A minimum of 50 us is maybe a little bit pessimistic, probably the
effect of the instrumentation itself. But it is true that it is easy to
get high maximum latencies when running the cache calibrator in the
background.

> 
> The current I-pipe tracer patch for ARM is available at 
> http://opensource.emlix.com/ipipe-s3c24xx/download/ipipe-tracer-arm.patch_v4
> 
> Comments welcome.


This tracer for arm is great.

-- 
                                                 Gilles Chanteperdrix

