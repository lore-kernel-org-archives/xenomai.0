Message-ID: <4DA3FC97.10807@domain.hid>
Date: Tue, 12 Apr 2011 09:17:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA17996.3010103@domain.hid>
	<20110411171437.GA3715@domain.hid>
	<4DA37209.4000503@domain.hid>
	<20110412054348.GA2973@domain.hid>
In-Reply-To: <20110412054348.GA2973@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

Richard Cochran wrote:
> On Mon, Apr 11, 2011 at 11:26:33PM +0200, Gilles Chanteperdrix wrote:
>> Wait a minute. You are comparing results obtained after 2 or 3, or 10
>> minutes of runtime? I am not sure such results are meaningful. I do my
>> benchmarks with the noltp_hell test:
>> http://git.xenomai.org/?p=mkrootfs.git;a=blob_plain;f=tests/noltp_hell;hb=HEAD
> 
> Of course, the longer the test, the more confidence you have.

Not only that. The aim of the test is to trigger the worst case path. I
suspect you can not trigger it with a 10 minutes tests. As you probably
remember, I was once running Xenomai on IXP465, and the latency with
Xenomai 2.4 and FCSE was around 150us. So, I suspect the test you show
us are not really meaningful. Improving the worst case latency sometimes
results in a higher average latency.

Each release of the I-pipe patch is tested with the boards at my
disposal, and the latency on the oldest board I have, a csb637, has been
the same for a long time. But I can test again a 2.4.10 to confirm this.

In any case, if you want to investigate the difference, the best tool is
the I-pipe tracer. As I said, I am not sure it worked with all versions,
but I can help get it working.

> 
> But, when tracking down kernel freezes and toggling two component
> versions and a half dozen CONFIG options, sometimes you do short tests
> just to "sample" the combination.

Exactly, and IMO, we should not get sidetracked in premature statements
and conclusions about performance of the system when we are tracking a
stability issue. Let us solve the stability issue first, then we will
look into any potential performance issue, and we will do it with a
proper load of the system, and with a four hours test.

What compiler are you using by the way?

-- 
                                                                Gilles.

