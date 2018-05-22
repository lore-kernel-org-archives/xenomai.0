References: <CY4PR0901MB2211C40E748F61C0C92D976DA1900@CY4PR0901MB2211.namprd09.prod.outlook.com>
 <afc4023f-295b-0f0f-2c8a-e9f9496107f9@xenomai.org>
From: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Message-ID: <21f3928b-46d5-3de2-b18c-cdcc58492344@oss-tech.org>
Date: Mon, 21 May 2018 22:06:24 -0700
MIME-Version: 1.0
In-Reply-To: <afc4023f-295b-0f0f-2c8a-e9f9496107f9@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3 Multi-core Semaphore latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Singh, Raman" <rasingh@mitre.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/20/2018 08:07 AM, Philippe Gerum wrote:
> On 05/18/2018 06:24 PM, Singh, Raman wrote:
>> Environment: ARM Cortex-A53 quad-core processor (ARM 64-bit) on a
>> Zynq Ultrascale+ ZCU102 dev board, Xenomai 3 next branch from May 
>> 14, 2018 (SHA1: 410a4cc1109ba4e0d05b7ece7b4a5210287e1183 ), 
>> Cobalt configuration with POSIX skin, Linux Kernel version 4.9.24
>>
>> I've been having issues with semaphore latency when threads access 
>> semaphores while executing on different cores. When both threads accessing 
>> a semaphore execute on the same processor core, the latency between
>> one thread posting a semaphore and another waking up after waiting on it 
>> is fairly small. However, as soon as one of the threads is moved to a 
>> different core, the latency between a semaphore post from one thread to a 
>> waiting thread waking up in response starts to become large enough to 
>> affect real time performance.  The latencies I've been seeing are on the order
>> of 100's of milliseconds.
>>
> 
> Reproduced on hikey here: the rescheduling IPIs Xenomai is sending for
> waking up threads on remote CPUs don't flow to the other end properly
> (ipipe_send_ipi()), which explains the behavior you have been seeing.
> 
> @Dmitriy: this may be an issue with the range of SGIs available to the
> kernel when a secure firmware is enabled, which may be restricted to
> SGI[0-7].
> 
> For the rescheduling IPI on ARM64, the interrupt pipeline attempts to
> trigger SGI8 which may be reserved by the ATF in secure mode, therefore
> may never be received on the remote end.
> 
> Fixing this will require some work in the interrupt pipeline, typically
> for multiplexing our IPIs on a single SGI below SGI8. As a matter of
> fact, the same issue exists on the ARM side, but since running a secure
> firmware there is uncommon for Xenomai users, this went unnoticed (at
> least not reported yet AFAIR). We need to sync up on this not to
> duplicate work.
> 

I see this on Hikey with the latest ipipe-arm64 tree as well. I can confirm the
reschedule IPI isn't being received although it is sent. Rearranging the IPIs
to move reschedule up a few spots resolves the issue, so I think this confirms
the root cause.

Philippe, are there architectures that already do this type of multiplexing, or
does this mechanism need to be designed from scratch?

