MIME-Version: 1.0
In-Reply-To: <4B951426.9040404@domain.hid>
References: <201003021527.30130.sinisa.denic@domain.hid>
	<201003080858.11552.sinisa.denic@domain.hid>
	<4B950116.1020307@domain.hid>
	<201003081559.56967.sinisa.denic@domain.hid>
	<4B951426.9040404@domain.hid>
Date: Sun, 11 Jul 2010 13:32:40 +0200
Message-ID: <AANLkTil2DO6RNVT4x0Kqw2RuBdAIgAy_kdnrSWoeveYI@mail.gmail.com>
From: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] ARM cached,non-cached memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Mon, Mar 8, 2010 at 5:13 PM, Gilles Chanteperdrix
> Anyway, what I am interested in is a quick test with your
> application, measuring performances, so that we know whether
> implementing this feature completely is worth the trouble, and in that
> case, we will investigate further these issues.

Just for the sake of archiving our efforts, in the meantime I
performed some kind of testing and here are some, I hope, representing
results of this patch. System is AT91SAM9260 based (ARM926EJ-S), Linux
2.6.33.4 + Xenomai 2.5.3.

Writes are about 30% faster, while read is on the same performance
rate. Raw results are:

1: Results with Gilles patch, rt_heap created without H_NONCACHED:
 Writing:  11172ms
 Reading:  10232ms

2: Results with Gilles patch, rt_heap created with H_NONCACHED:
 Writing:  13207ms
 Reading: 19369ms

3: Results without Gilles patch, rt_heap created with H_NONCACHED:
 Writing:  18385ms
 Reading:  19425ms

Workload is simple, writing and reading 4 bytes at a time, int by int.
Something like 100mil iterations.

Gilles, thanks again :)

