Date: Sat, 12 Feb 2011 19:13:32 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110212181332.GA2820@domain.hid>
References: <AANLkTikSnhe5fnSLQm7eSOh9R7YA2cJ=m78n+S3kpW9K@mail.gmail.com>
	<4D4A84ED.7030604@domain.hid> <4D4A8BD8.1060900@domain.hid>
	<4D4A9052.2090508@domain.hid> <4D4A9118.2070602@domain.hid>
	<4D4A957B.6050907@domain.hid> <4D4A9654.80402@domain.hid>
	<4D4AA479.2020808@domain.hid> <4D4AABF4.6030804@domain.hid>
	<AANLkTimdawDBCnZon1v06F6uFf1dqwt8Re11rXPv6ZnY@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTimdawDBCnZon1v06F6uFf1dqwt8Re11rXPv6ZnY@mail.gmail.com>
Subject: Re: [Xenomai-help] RT OS Selection advice for parallel processing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rudolf Meijering <rudolf@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Feb 04, 2011 at 03:33:04PM +0200, Rudolf Meijering wrote:
> I have done some research on the pro's and con's of PREEMPT_RT vs Xenomai.
> As far as I can determine some of the benefits include:
> 1. Programming with Xenomai native API's are more elegant than POSIX
> real-time API’s.
> 2. Xenomai has possibly less overhead than a full preemptive kernel. The
> user interface does not require RT capabilities.
> 
> Are there any other substantial benefits worth considering? Which would you
> use?

In my view, the most important advantage of Xenomai is superior real
time performance. To convince yourself about this, try the following
simple experiment.

1. Compile both RT_PREEMPT and Xenomai for your target hardware.

2. Run cyclictest under various loads and priorities. (For Xenomai, be
   sure to use the version of cyclictest included with the Xenomai libraries.)

For the Freescale P2020 PowerPC platform, I recently tested Xenomai
2.4 (kernel 2.6.30) and the latest RT_PREEMPT (kernel 2.6.33). Xenomai
has maximal latencies around 10 usec, and RT_PREEMPT has around 40
usec, but with occasional spikes to over 400 usec.

Obviously, there are bugs or unfixed latencies in RT_PREEMPT on that
platform. One can always roll up the sleeves and go fixing these
problems, but my point is that Xenomai offers better performance out
of the box.

In general, I would choose a Linux flavor for an application like
this:

1. Does plain old Linux offer good enough real time performance for my
   needs? If yes, then use Linux.

2. Does RT_PREEMPT do it? If yes, use it, because it is closer to
   mainline Linux than Xenomai.

3. Does Xenomai fill the bill? If yes, use it.

4. Out of choices, you can't use Linux after all.

For my needs, I have landed at choice #3 more than once. My experience
with Xenomai has been extremely positive, and after meeting the main
developers (Philippe, Gilles, and Jan) at the first ever Xenomai users
meeting (at the 11th RTLW, 2009, in Dresden) I have tremendous
confidence in them. Also, it was eye opening to see how Xenomai has
been used in several demanding commerical projects.

Another important consideration is which kernel version to use. Both
Xenomai and RT_PREEMPT are only offered on selected kernel
versions. It might be that some new Linux kernel feature is not
present in your RT kernel version, so you have to choose carefully.

Finally, for safety critical applications, it might be hard to get a
Linux based system certified. I have never attempted this, but I
imagine that an analytical correctness "proof" would be infeasible for
a Linux based system.

HTH,

Richard


