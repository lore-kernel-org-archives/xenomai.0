Message-ID: <529DDB58.3090709@xenomai.org>
Date: Tue, 03 Dec 2013 14:23:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
 <529DCF2F.1070702@xenomai.org>
 <1507DF58-4A8D-42E0-92B8-4A9EAB4289E3@open.ac.uk>
In-Reply-To: <1507DF58-4A8D-42E0-92B8-4A9EAB4289E3@open.ac.uk>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kurijn Buys <Kurijn.Buys@open.ac.uk>
Cc: Xenomai@xenomai.org

On 12/03/2013 02:07 PM, Kurijn Buys wrote:
> Thanks for the quick response, ACPI is enabled, I only disabled
> "Processor" in there... -1 was a typo indeed, it is at 1... I see
> SCHED_SMT [=y] in my kernel config... shall I recompile the kernel
> with this disabled then... no other things to try first/at the same
> time?

To remove hyperthreading, either:
- disable it in the BIOS configuration;
- or disable CONFIG_SMP (not SCHED_SMPT) in the kernel configuration.

>
> I realized that the test with sched_rt_runtime_us on -1 I performed
> was with an earlier set-up. When I set it now to -1, I have better
> performance, but: 1) still spikes of up to 87us under load with
> ./latency 2) still some completely shifted occurrences with the other
> latency test, with a 1000µs period (but now only 2 out of 890814),
> and the rest of the distribution lies in [861-1139]µs, which is also
> rather large I suppose.

sched_rt_runtime_us should not make any difference.

Something else you should try is to disable root thread priority coupling.

>
> The ipipe trace after test (1) was similar to the one I posted, where
> this line seems to be the problem I suppose: :|   #end     0x80000001
> -179! 149.235  ipipe_check_context+0x87 (add_preempt_count+0x15)
>
> Merci! ]{urijn

You are welcome. Please avoid top-posting.

Regards.

-- 
					    Gilles.

