MIME-Version: 1.0
Date: Wed, 24 Apr 2013 14:18:47 +0800
Message-ID: <CAFByoKzbx1pMd7dauwoOyKODBOP4q_b=4qtC4H8uNWRwmhgtuA@mail.gmail.com>
From: kidd <gong.kidd@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] problem about task scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi guys
    I post Adeos+xenomai to S3C6410 SOC with Linux-2.6.35.9, and the Linux
kernel and Xenomai are ok when system boot(according the printed
information when system boot). When I run "xeno latency" in console, the
output is
RTT|  00:00:-01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259
RTD|      0.000|      0.000|      0.000|       0|     0|
900568.258|-900568.259

all data is 0. According the source code of latecny.c, I found that the
"main" function started 2 task(latency_task and display_task). The
latency_task is to update the value of timing variables, and the
display_task is to display the upated values. I found there was only one
task (display_task) was always active.
How to start other task? with timer interrupt or other ways? thanks
