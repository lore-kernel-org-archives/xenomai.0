Message-ID: <45ED84B8.3010307@domain.hid>
Date: Tue, 06 Mar 2007 16:11:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTCAN and tsc
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
In-Reply-To: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> Hi,
> 
> One thought did occur to me wrt to the problem of rtcan breaking RT
> behaviour. I am not using TSC support (IPC's we have are all 486
> processor family). I was told that this will give slightly worse
> latency but at a 1ms period time this should not be a problem.
> 
> Just want to confirm at this stage that this is still correct?

Just run latency -p 1000 with some load. If you observe abnormal
latencies with the latency test, then you have a hardware problem. If
you observe normal latencies with the latency test, then your
application has a problem.

-- 
                                                 Gilles Chanteperdrix

