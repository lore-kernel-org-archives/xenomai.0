MIME-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset="iso-8859-1"
From: Kurijn Buys <Kurijn.Buys@open.ac.uk>
In-Reply-To: <529DDB58.3090709@xenomai.org>
Date: Tue, 3 Dec 2013 15:31:58 +0000
Content-Transfer-Encoding: quoted-printable
Message-ID: <5B55252A-19D2-4A0D-82BE-FC77BFA6AEE1@open.ac.uk>
References: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
 <529DCF2F.1070702@xenomai.org>
 <1507DF58-4A8D-42E0-92B8-4A9EAB4289E3@open.ac.uk>
 <529DDB58.3090709@xenomai.org>
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

Op 3-dec.-2013, om 13:23 heeft Gilles Chanteperdrix het volgende geschreven=
:

> On 12/03/2013 02:07 PM, Kurijn Buys wrote:
>> Thanks for the quick response, ACPI is enabled, I only disabled
>> "Processor" in there... -1 was a typo indeed, it is at 1... I see
>> SCHED_SMT [=3Dy] in my kernel config... shall I recompile the kernel
>> with this disabled then... no other things to try first/at the same
>> time?
>
> To remove hyperthreading, either:
> - disable it in the BIOS configuration;
> - or disable CONFIG_SMP (not SCHED_SMPT) in the kernel configuration.
>
Ah I see, CONFIG_SMP is also enabled...
I've disabled it in BIOS, but no success (tell me if it is worth trying to =
disable it in the kernel config in stead).

>>
>> I realized that the test with sched_rt_runtime_us on -1 I performed
>> was with an earlier set-up. When I set it now to -1, I have better
>> performance, but: 1) still spikes of up to 87us under load with
>> ./latency 2) still some completely shifted occurrences with the other
>> latency test, with a 1000=B5s period (but now only 2 out of 890814),
>> and the rest of the distribution lies in [861-1139]=B5s, which is also
>> rather large I suppose.
>
> sched_rt_runtime_us should not make any difference.
>
> Something else you should try is to disable root thread priority coupling=
.
>
I have tried a config with priority coupling support disabled before, but t=
hen the system was even more vulnerable for such latency peaks (however the=
 mean latency was a little lower!)
(I still have the kernel, but unfortunately the I-pipe tracer isn't install=
ed there)

>>
>> The ipipe trace after test (1) was similar to the one I posted, where
>> this line seems to be the problem I suppose: :|   #end     0x80000001
>> -179! 149.235  ipipe_check_context+0x87 (add_preempt_count+0x15)
>>
...I hoped the I-pipe trace would help..?

>> Merci! ]{urijn
>
> You are welcome. Please avoid top-posting.
>
> Regards.
>
> --
>                                           Gilles.

-- The Open University is incorporated by Royal Charter (RC 000391), an exe=
mpt charity in England & Wales and a charity registered in Scotland (SC 038=
302).

