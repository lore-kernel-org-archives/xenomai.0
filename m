Message-ID: <5061C643.8080305@xenomai.org>
Date: Tue, 25 Sep 2012 16:57:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50588110.6030701@siemens.com> <50588458.1010802@xenomai.org>
	<505892E8.6080605@siemens.com> <5058CD54.4070509@xenomai.org>
	<5059B76F.7020608@siemens.com> <505B4044.7030103@xenomai.org>
	<5061C394.1050005@siemens.com>
In-Reply-To: <5061C394.1050005@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [GIT PULL] core-5 for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/25/2012 04:45 PM, Wolfgang Mauerer wrote:
> +			if (!cpumask_test_cpu(cpu, mask)
> +			    && t->irq == per_cpu(ipipe_percpu.hrtimer_irq, 0)) {
> +				per_cpu(ipipe_percpu.hrtimer_irq, cpu) = t->irq;
> +				goto found;

This only works if cpu 0 is part of the "supported cpus" mask. I think
we need two loops.

-- 
					    Gilles.

