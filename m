Message-ID: <463AFA1C.9050609@domain.hid>
Date: Fri, 04 May 2007 11:17:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid> <1178198991.29605.54.camel@domain.hid>
	<463AE79E.2090901@domain.hid>
In-Reply-To: <463AE79E.2090901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

Johan Borkhuis wrote:
> When running latency at a higher priority than the cyclictest program 
> the max increases from around 4 to 8 usec when the cyclictest stops. But 
> when running the latency program at a lower priority (60, while 
> cylictest is running at 80 - 71) the maximum increases dramatically:
> 
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 60)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat 
> worst
> RTD|      -0.096|       0.168|       3.843|       0|      -0.096|       
> 6.510
> RTD|      -0.072|       0.216|      23.135|       0|      -0.096|      
> 23.135
> RTD|       0.048|       0.480|      14.270|       0|      -0.096|      
> 23.135
> RTD|       0.048|       0.480|      14.030|       0|      -0.096|      
> 23.135
> RTD|      -0.096|       0.552|     613.741|       7|      -0.096|     
> 613.741
> RTD|      -0.096|       0.168|       7.975|       7|      -0.096|     
> 613.741
> RTD|      -0.072|       0.168|       3.843|       7|      -0.096|     
> 613.741
> 
> If you want I can send you my version of the cyclictest program.

What you can do is enabling the I-pipe tracer, see:
http://www.xenomai.org/index.php/I-pipe:Tracer

and run latency with the -f flag, to get a recording of the worst case
scenario.

-- 
                                                 Gilles Chanteperdrix

