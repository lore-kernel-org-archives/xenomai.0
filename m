Subject: Re: [PATCH 2/2] ARM: irq_pipeline: preserve lockdep irq state across
 kernel entries
References: <20210613155522.1851338-1-rpm@xenomai.org>
 <20210613155522.1851338-2-rpm@xenomai.org> <87wnqx7o3k.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e480b487-e30a-bcb8-fa61-5b613756a8d0@siemens.com>
Date: Sun, 13 Jun 2021 19:09:28 +0200
MIME-Version: 1.0
In-Reply-To: <87wnqx7o3k.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 13.06.21 17:58, Philippe Gerum via Xenomai wrote:
> 
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> From: Philippe Gerum <rpm@xenomai.org>
>>
>> When lockdep is enabled, per_cpu(hardirqs_enabled) may not be in sync
>> with the in-band stall bit on kernel entry upon preemption by an
>> IRQ. This may happen since the relevant local_irq_* calls do not
>> manipulate the stall bit and the lockdep irq state atomically (for a
>> good reason). In addition, the raw_local_irq API may be used directly,
>> without lockdep tracking whatsoever (e.g. when manipulating raw
>> spinlocks).
> 
> A similar fix may be needed for x86 in the generic entry code when
> pipelining interrupts.
> 

Is there a good way to tickle the related splat out of the system? At
least locally, I have PROVE_LOCKING on but didn't see this so far.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

