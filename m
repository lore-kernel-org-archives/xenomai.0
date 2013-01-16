Message-ID: <50F64ED2.7060503@zultron.com>
Date: Wed, 16 Jan 2013 00:55:14 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <D9F55F45-EC38-45B2-A922-08F24868BA87@mah.priv.at>
	<50F3F296.5000008@xenomai.org>
	<3F8DFF0B-6F81-48E1-9D64-83B08DA6A599@mah.priv.at>
	<50F41136.3070200@xenomai.org>
In-Reply-To: <50F41136.3070200@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] universal application binary: how to
 auto-detect	Xenomai/RT-PREEMPT/vanilla kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 01/14/2013 08:07 AM, Philippe Gerum wrote:
> On 01/14/2013 01:05 PM, Michael Haberler wrote:
>> Is there any chance somebody runs Xenomai AND RT_PREEMPT patches
>> applied? I heard a rumor but havent actually seen that
> 
> Yes, this works. The current target is ppc 85xx, but I don't see any
>  showstopper for running such combo on other archs, provided the
> I-pipe patch is adapted to a -rt kernel. This requires Xenomai
> 2.6.1+, stock.

Comparing the xenomai-2.6.2 x86/patches directory and
http://www.kernel.org/pub/linux/kernel/projects/rt, it appears there's a
common kernel version in 3.2.21.

I'm preparing RPM packages for 3.5 because I assume that's where most
development and bug fixing is going on, and because I hope the work will
be useful beyond the LinuxCNC community.  Unfortunately, RT_PREEMPT
seems to skip linux 3.5 entirely, jumping from 3.4 to 3.6.

	John

