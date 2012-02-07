Message-ID: <4F314970.5040904@domain.hid>
Date: Tue, 07 Feb 2012 16:55:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F312091.5080001@domain.hid>
In-Reply-To: <4F312091.5080001@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] Port to AT91SAM9G45
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gregory CLEMENT <gregory.clement@domain.hid>
Cc: Thomas Petazzoni <thomas.petazzoni@domain.hid>, Maxime Ripard <maxime.ripard@domain.hid>, Nicolas Ferre <nicolas.ferre@domain.hid>, xenomai@xenomai.org

On 02/07/2012 02:01 PM, Gregory CLEMENT wrote:
> Hello,
> 
> I've done the port for AT91SAM9G45 on a AT91SAM9M10G45-EK board. The
> following patch have to be applied on top of the
> adeos-ipipe-2.6.38.8-arm-1.18-04.patch patch.
> 
> I also ran latency test under heavy stress using:
> - hackbench to stress the scheduler
> - netcat to stress the Ethernet interface and generate a lot of interrupts
> - ls and dd( reading a /dev/mtdblock and writing on a tmpfs) for global stress
> 
> I join the results I had after running each latency test during 10 hours.
> 
> If the results I get seem the correct could you apply this patch in
> Xenomai?
> 
> Should I also submit this patch to adeos project?

We will merge this patch in the adeos patch, yes. Thanks. Note that
xenomai-2.6.0 provides a "dohell" command in order to generate some
load, and a "xeno-test" script which runs latency under dohell load.

Are the results obtained with or without the FCSE option enabled?

-- 
                                                                Gilles.

