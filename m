Message-ID: <4E38F4CF.4030702@domain.hid>
Date: Wed, 03 Aug 2011 09:12:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <loom.20110803T060604-81@domain.hid>
In-Reply-To: <loom.20110803T060604-81@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] latency: failed to set periodic, code -110
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ke zhou <zhou_ke2001@domain.hid>
Cc: xenomai@xenomai.org

On 08/03/2011 06:09 AM, ke zhou wrote:
> hello ,everyone!
> I`m trying to patch the 2.6.25 kernel with Adeos Ipipe.And the xenomai
> version is xenomai-2.4.4.tar.gz.
> But when I execute " ./latency -t0 -T60 -p100 -h " on the s3c2440 board,there 
> are some errors : 
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> latency: failed to set periodic, code -110
> latency: failed to pend on semaphore, code -110
> 
> Any idea about that ?

The latencies on s3c24x will not allow you to run with a 100us period.
Also, you should use xenomai 2.5.6.

-- 
                                                                Gilles.

