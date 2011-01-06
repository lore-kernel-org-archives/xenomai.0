Message-ID: <4D263341.1080601@domain.hid>
Date: Thu, 06 Jan 2011 22:25:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <12d5cebd852.gprizzi@domain.hid>
In-Reply-To: <12d5cebd852.gprizzi@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] error in executing xenomai tests
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "gprizzi@domain.hid" <gprizzi@domain.hid>
Cc: xenomai@xenomai.org

gprizzi@domain.hid wrote:
> Dear Sir,
> 
> I find your considerations very useful, unfortunately I am not  expert in tuning conventional 
> operating system with real time patch.
> 
> If you can help me I will greatly appreciate your advices.
> 
> I run latency test and got the following results:
> 
> root@domain.hid# ./latency
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|     -1.786|      2.224|     19.821|       0|     0|     -1.786|     19.821
> RTD|     -1.796|      2.330|     19.490|       0|     0|     -1.796|     19.821
> RTD|     -1.831|      2.231|     19.495|       0|     0|     -1.831|     19.821
> RTD|     -1.772|      2.291|     19.743|       0|     0|     -1.831|     19.821
> RTD|     -1.473|      2.460|     19.708|       0|     0|     -1.831|     19.821
> RTD|     -1.524|      2.381|     19.717|       0|     0|     -1.831|     19.821
> RTD|     -1.752|      2.338|     19.807|       0|     0|     -1.831|     19.821
> RTD|     -1.893|      2.297|     19.520|       0|     0|     -1.893|     19.821
> RTD|     -2.192|      2.284|     19.549|       0|     0|     -2.192|     19.821
> RTD|     -1.635|      2.327|     19.530|       0|     0|     -2.192|     19.821
> RTD|     -1.416|      2.406|     19.580|       0|     0|     -2.192|     19.821
> RTD|     -1.305|      2.471|     14.930|       0|     0|     -2.192|     19.821
> RTD|     -1.782|      2.409|     14.999|       0|     0|     -2.192|     19.821
> RTD|     -1.774|      2.364|     18.456|       0|     0|     -2.192|     19.821
> RTD|     -1.784|      2.328|     19.914|       0|     0|     -2.192|     19.914
> RTD|     -1.768|      2.293|     19.639|       0|     0|     -2.192|     19.914
> RTD|     -1.777|      2.263|     19.463|       0|     0|     -2.192|     19.914
> RTD|     -1.228|      2.389|     19.923|       0|     0|     -2.192|     19.923
> RTD|     -1.223|      2.405|     19.579|       0|     0|     -2.192|     19.923
> RTD|     -1.778|      2.431|     14.499|       0|     0|     -2.192|     19.923
> RTD|     -1.983|      2.493|     15.335|       0|     0|     -2.192|     19.923

The info you are missing here, and which is not obvious, I admit, is
that by running latency 30 seconds on an idle system, you are not even
close of knowing the worst case latency of Xenomai on your system.

In order to evaluate the worst case latency of Xenomai on your system,
you have to run the latency test, for a long time, on a loaded system,
and with the frequency of the task whose latency you are interested in.

That said, I insist, unless you know or even have rough estimates of the
way your final application is behaving, this does not give you much of a
clue. Otherwise, you can not answer the question "is this latency
sufficient ?" right away, you have to wait for the application to be
developed and running.

-- 
                                                                Gilles.

