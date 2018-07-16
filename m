References: <3319d6fa-2541-67bf-f03b-15b440a1b8a6@siemens.com>
 <20180713143732.1bd0fc30@md1pvb1c.ad001.siemens.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <db6854b7-e211-902f-03e1-ab493357199a@xenomai.org>
Date: Mon, 16 Jul 2018 16:48:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180713143732.1bd0fc30@md1pvb1c.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Eager FPU vs. recent kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 07/13/2018 02:37 PM, Henning Schild wrote:
> Am Mon, 9 Jul 2018 19:48:28 +0200
> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
>> Hi,
>>
>> the x86 FPU changes that so far only affected 4.14 and delayed its
>> ipipe progress on that arch. However, CVE-2018-3665 is not making it
>> a topic for every ipipe kernel (that should be kept up to date): lazy
>> FPU is history, now also for security reasons (before that only for
>> performance reasons).
> 
> I have just reached that point in the 4.14 x86 work. And from what i
> can see right now is that it would be a good idea to look into the FPU
> thing independent of 4.14. So i will start working on that for 4.9 and
> probably 4.4 to understand what 4.14 needs.
> 

The Spectre mitigation code in 4.14 will require to use the regular
__switch_to infrastructure for context switching, there are several key
changes in entry_64.S which call for this. This should send fpu
management over the head stage back to the pipeline core where it
belongs, instead of open coding it into Cobalt for x86. At the end of
the day, I believe that this should greatly simplify the implementation
both on the I-pipe and Cobalt sides.

PS: still bringing up I-pipe x86 on 4.14 piece by piece, based on a
fully incremental commit stack. I'm able to boot the basic pipeline
stuff by only introducing the virtual interrupt state management over
KVM at the moment. Still some work ahead for adding the rest of the
changes involving task migration to the head stage and notifiers. I'll
stop before fpu handling and Cobalt port to 4.14.

-- 
Philippe.

