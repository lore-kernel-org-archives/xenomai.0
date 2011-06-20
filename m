Message-ID: <4DFF610F.5070602@domain.hid>
Date: Mon, 20 Jun 2011 17:02:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF9CA75.1040903@domain.hid>	<4DF9DCE3.70703@domain.hid>	<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>	<4DFBA463.3090902@domain.hid>	<4DFBAEB9.8060106@domain.hid>	<4DFBB08B.5020005@domain.hid>	<4DFCC18F.3060207@domain.hid>
	<BANLkTin00xA-LMikumq1C4_nFyFbCdgi+Q@mail.gmail.com>
In-Reply-To: <BANLkTin00xA-LMikumq1C4_nFyFbCdgi+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/20/2011 04:34 PM, Jakub Nowacki wrote:
> Interestingly, I'm getting the same results for core2 kernel without
> SMI workaround working. I was just getting high latencies approx. 70
> us for generic kernel. I'm not sure though how is it possible. Also,
> the higher latencies of above 10 us are arriving not too often but
> relatively regularly (without any visible pattern, though). I'm not
> sure if such a latencies are rather normal or caused by something
> 'bad'.

To make proper benchmarks, you should:
- let the latency run long
- provide some load, you can use the dohell script in xenomai-head to
generate the load.

That said, having some spikes is not abnormal. The real question is to
know whether the latencies your get are sufficient for your application.

> ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory

You have to increase CONFIG_XENO_OPT_SYS_STACKPOOLSZ.

-- 
					    Gilles.

