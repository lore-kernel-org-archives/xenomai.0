Message-ID: <bc4264770703060753j1c67d6cat2b04e19f2ca376fa@domain.hid>
Date: Tue, 6 Mar 2007 15:53:14 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <45ED84B8.3010307@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<45ED84B8.3010307@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> Just run latency -p 1000 with some load. If you observe abnormal
> latencies with the latency test, then you have a hardware problem. If
> you observe normal latencies with the latency test, then your
> application has a problem.

The results:

RTD|      29.333|      31.009|     179.352|       0|      29.333|     204.495
RTD|      29.333|      31.009|     201.142|       0|      29.333|     204.495
RTD|      29.333|      31.009|     203.657|       0|      29.333|     204.495
RTD|      29.333|      31.847|     201.980|       0|      29.333|     204.495
RTD|      29.333|      31.009|     181.866|       0|      29.333|     204.495
RTD|      29.333|      31.847|     201.142|       0|      29.333|     204.495
RTD|      29.333|      31.009|     202.819|       0|      29.333|     204.495
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      29.333|      31.847|     209.523|       0|      29.333|     209.523
RTD|      29.333|      31.847|     206.171|       0|      29.333|     209.523
RTD|      29.333|      31.847|     204.495|       0|      29.333|     209.523
RTD|      29.333|      31.847|     204.495|       0|      29.333|     209.523
RTD|      29.333|      31.847|     203.657|       0|      29.333|     209.523
RTD|      29.333|      31.847|     203.657|       0|      29.333|     209.523
RTD|      29.333|      31.009|     178.514|       0|      29.333|     209.523
RTD|      29.333|      30.171|     201.142|       0|      29.333|     209.523
RTD|      29.333|      30.171|     199.466|       0|      29.333|     209.523
RTD|      29.333|      31.009|     200.304|       0|      29.333|     209.523
RTD|      29.333|      30.171|     180.190|       0|      29.333|     209.523
RTD|      28.495|      31.009|     201.142|       0|      28.495|     209.523
RTD|      29.333|      31.009|     201.142|       0|      28.495|     209.523
RTD|      29.333|      31.009|     204.495|       0|      28.495|     209.523
RTD|      29.333|      31.009|     200.304|       0|      28.495|     209.523
RTD|      29.333|      31.009|     203.657|       0|      28.495|     209.523
RTD|      29.333|      31.009|     200.304|       0|      28.495|     209.523
RTD|      29.333|      30.171|     201.142|       0|      28.495|     209.523
RTD|      29.333|      30.171|     201.980|       0|      28.495|     209.523
RTD|      29.333|      31.009|     202.819|       0|      28.495|     209.523
---|------------|------------|------------|--------|-------------------------
RTS|      28.495|      30.171|     209.523|       0|    00:00:42/00:00:42


IMHO this looks ok does it not?

Roland

>
> --
>                                                  Gilles Chanteperdrix
>

