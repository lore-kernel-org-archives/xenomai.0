Message-ID: <49B0ECE9.1050201@domain.hid>
Date: Fri, 06 Mar 2009 10:29:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200903061109.58455.Sergey.Peniaz@domain.hid>
In-Reply-To: <200903061109.58455.Sergey.Peniaz@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Is such latency normal?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sergey PENIAZ <Sergey.Peniaz@domain.hid>
Cc: xenomai@xenomai.org

Sergey PENIAZ wrote:
> Hello,
> 
> I'm novice at xenomai. I just builded xenomai for platform based on "Intel(R) 
> Pentium(R) 4 CPU 1500MHz". And I obtained next latency values. Are such 
> values normal for this cpu? Or maybe is there a way to decrease them? 
> 
> testpc:/usr/xenomai/bin# ./cyclictest -i 200 -p99 -t 5
> 0.02 0.02 0.00 1/70 3272
> 
> T: 0 ( 3268) P:99 I: 200 C: 59941 Min: 2 Act: 12 Avg: 8 Max: 21
> T: 1 ( 3269) P:98 I: 700 C: 17126 Min: 3 Act: 8 Avg: 11 Max: 35
> T: 2 ( 3270) P:97 I: 1200 C: 9991 Min: 9 Act: 20 Avg: 15 Max: 43
> T: 3 ( 3271) P:96 I: 1700 C: 7052 Min: 3 Act: 8 Avg: 13 Max: 52
> T: 4 ( 3272) P:95 I: 2200 C: 5450 Min: 12 Act: 13 Avg: 17 Max: 61

The latencies of other threads than the one which runs with the highest
priority are not all that significant, so, the only figure which matters
is 21us. It does not seem that bad.

However, notice than when running cyclictest or latency, you should
apply a load of some sort, such as dd, ping flood, calibrator, etc...

Also, did you check SMIs?

-- 
                                                 Gilles.

