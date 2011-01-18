Message-ID: <4D35CFE3.2020801@domain.hid>
Date: Tue, 18 Jan 2011 18:37:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CEE8FF0.6000704@domain.hid>	
	<1295370797.1857.86.camel@domain.hid>	<4D35CC68.5010204@domain.hid>
	<1295371648.1857.88.camel@domain.hid> <4D35CE4B.8030006@domain.hid>
In-Reply-To: <4D35CE4B.8030006@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [git pull] Updates for ipipe-2.6.36-noarch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jan Kiszka wrote:
> On 2011-01-18 18:27, Philippe Gerum wrote:
>> On Tue, 2011-01-18 at 18:22 +0100, Jan Kiszka wrote:
>>> On 2011-01-18 18:13, Philippe Gerum wrote:
>>>> On Thu, 2010-11-25 at 17:33 +0100, Jan Kiszka wrote:
>>>>> The following changes since commit 4c83ab8e3ac5b194695e38bbc253f78e6072ad24:
>>>>>
>>>>>   ipipe: tell __ipipe_run_irqtail about the latest IRQ number (2010-11-05 13:52:55 +0100)
>>>>>
>>>>> are available in the git repository at:
>>>>>   git://git.kiszka.org/ipipe-2.6 queues/2.6.35-noarch
>>>>>
>>>>> [edited log]
>>>>> Jan Kiszka (4):
>>>>>       ipipe: Provide wrapper for IRQ mask/unmask at chip level
>>>> Could you give me some hints about the intended usage of these?
>>> The idea was (and still is but effort stalled ATM) to emulate MSI
>>> masking on top of that.
>> Ok, let's keep this on the shelf until we come with a complete solution.
>> I suspect we will have to resync the Xenomai and I-pipe interfaces to
>> this end.
> 
> Definitely. So the patch was intended as a starting point, enbling
> refactoring on Xenomai side. Quite a lot of work is actually to be done
> on the rthal, also to clean up lots of duplicate irq descriptor
> translations over there.

As a maintainer of low end architectures, I am not too fond with
introducing one more level of function pointers. A substantial part of
the worst case interrupt latency on ARM is spent in these routines, so,
it would be nice if we could avoid make this even longer. And still on
ARM, acking/masking an interrupt line is just about writing some bit to
some MMIO memory, so, the cost of the function pointer is definitely not
negligible.

-- 
                                                                Gilles.

