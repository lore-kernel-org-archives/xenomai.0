Message-ID: <50CC87FD.70305@xenomai.org>
Date: Sat, 15 Dec 2012 15:23:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <14AA522E86E5754F8BC33C742D045A4A8134EFB4@srv0024.corp.thvnet.com>
In-Reply-To: <14AA522E86E5754F8BC33C742D045A4A8134EFB4@srv0024.corp.thvnet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency test results Xeon E5-1650 higher than Xeon
 E5620
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Beaufils Sylvie (IT&LAB)" <sylvie.beaufils@thomson-networks.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/11/2012 06:49 PM, Beaufils Sylvie (IT&LAB) wrote:
> I have read that "The most common reason for high latencies on x86

> are SMIs". But the SMI workaround does not manage the Patsburg LPC
> controller. I tried to add the PCI ID [8086:1d41] to
> ksrc/arch/x86/smi.c with this result: [    1.926417] Xenomai:
> SMI-enabled chipset found [    1.926490] Xenomai: SMI workaround
> failed!
> 
> Should the SMI workaround be managed for the C602 chipset ? Could it
> explain the above latency results ?


Maybe, but as mentioned in the part of the troubleshooting guide you do
not quote, a "pathological" latency is a latency around say 100us.

The result of a latency test running:
- 1 minute
- on an idle system

is absolutely meaningless.

Anyway, if you want to understand the difference, you may use the I-pipe
tracer.

-- 
                                                                Gilles.

