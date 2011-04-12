Date: Tue, 12 Apr 2011 07:43:48 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110412054348.GA2973@domain.hid>
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA17996.3010103@domain.hid>
	<20110411171437.GA3715@domain.hid>
	<4DA37209.4000503@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DA37209.4000503@domain.hid>
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Apr 11, 2011 at 11:26:33PM +0200, Gilles Chanteperdrix wrote:
> Wait a minute. You are comparing results obtained after 2 or 3, or 10
> minutes of runtime? I am not sure such results are meaningful. I do my
> benchmarks with the noltp_hell test:
> http://git.xenomai.org/?p=mkrootfs.git;a=blob_plain;f=tests/noltp_hell;hb=HEAD

Of course, the longer the test, the more confidence you have.

But, when tracking down kernel freezes and toggling two component
versions and a half dozen CONFIG options, sometimes you do short tests
just to "sample" the combination.

I will follow these up with overnight tests, but I think the trend is
already becoming clear...

Thanks,

Richard


