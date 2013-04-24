Message-ID: <5177865E.4060206@xenomai.org>
Date: Wed, 24 Apr 2013 09:14:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFByoKzbx1pMd7dauwoOyKODBOP4q_b=4qtC4H8uNWRwmhgtuA@mail.gmail.com>
	<51778026.6080803@xenomai.org>
In-Reply-To: <51778026.6080803@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] problem about task scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kidd <gong.kidd@gmail.com>
Cc: xenomai@xenomai.org

On 04/24/2013 08:48 AM, Gilles Chanteperdrix wrote:

> On 04/24/2013 08:18 AM, kidd wrote:
> 
>> Hi guys
>>     I post Adeos+xenomai to S3C6410 SOC with Linux-2.6.35.9, and the Linux
>> kernel and Xenomai are ok when system boot(according the printed
>> information when system boot). When I run "xeno latency" in console, the
>> output is
>> RTT|  00:00:-01  (periodic user-mode task, 1000 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
>> worst
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>> RTD|      0.000|      0.000|      0.000|       0|     0|
>> 900568.258|-900568.259
>>
>> all data is 0. According the source code of latecny.c, I found that the
>> "main" function started 2 task(latency_task and display_task). The
>> latency_task is to update the value of timing variables, and the
>> display_task is to display the upated values. I found there was only one
>> task (display_task) was always active.
>> How to start other task? with timer interrupt or other ways? thanks
> 
> 
> It is simple: Xenomai works on other ARM platforms. So, there is nothing
> wrong with Xenomai or the latency test, what is wrong is likely your
> port to the S3C6410.
> 
> So, again, please use the following document:
> http://xenomai.org/index.php/I-pipe-core:ArmPorting
> 
> As a list of things to check to be sure that your port is working.
> 

Or rather:
http://xenomai.org/index.php/I-pipe:ArmPorting

For 2.6.35

-- 
                                                                Gilles.

