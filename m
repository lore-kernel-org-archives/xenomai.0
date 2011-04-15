Message-ID: <4DA845AF.9080103@domain.hid>
Date: Fri, 15 Apr 2011 15:18:39 +0200
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
	<4DA3FC97.10807@domain.hid>
	<20110414164923.GB4725@domain.hid>
In-Reply-To: <20110414164923.GB4725@domain.hid>
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
> On Tue, Apr 12, 2011 at 09:17:43AM +0200, Gilles Chanteperdrix wrote:
>> Not only that. The aim of the test is to trigger the worst case path. I
>> suspect you can not trigger it with a 10 minutes tests. As you probably
>> remember, I was once running Xenomai on IXP465, and the latency with
>> Xenomai 2.4 and FCSE was around 150us.
> 
> But that was FCSE best effort, no?

Guaranteed, but with all the load in the noltp_hell script (that is
nework load, I/O load, hackbench, etc...).

-- 
                                                                Gilles.

