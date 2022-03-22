Message-ID: <742b47b4-5a36-c9eb-6446-f7f74584109d@siemens.com>
Date: Tue, 22 Mar 2022 19:57:01 +0100
MIME-Version: 1.0
Subject: Re: Bug in xenomai 3.2.x on ARM
Content-Language: en-US
References: <cff-6239fe00-4d-24d08100@67302606>
 <CALLqZ8Q7ozVT_9rzcAuQUvMutCHLUW+uNfk-XA3T3p0hDkGE6Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CALLqZ8Q7ozVT_9rzcAuQUvMutCHLUW+uNfk-XA3T3p0hDkGE6Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org

On 22.03.22 18:31, Greg Gallagher via Xenomai wrote:
> On Tue, Mar 22, 2022 at 12:49 PM François Legal via Xenomai <
> xenomai@xenomai.org> wrote:
> 
>> Hello,
>>
>> trying to port a running Xenomai 3.1.x/Linux 4.4.x system to Xenomai
>> 3.2.x/Linux 4.4.x running on Zynq7000, I found a (maybe) bug in intr.c
>>
>> In xnintr_attach, the call to ipipe_set_irq_affinity (when in SMP) expects
>> a 0 return code. However, on my platform, I end up in irq_gic.c in
>> gic_set_affinity() which returns IRQ_SET_MASK_OK_DONE (2) when everything
>> is fine.
>>
>> This IRQ_SET_MASK_OK_DONE does not seem very common in the kernel (I could
>> find a few occurences, on Gic v3 so maybe AARCH64 has the same problem,
>> plus some PCI devices).
>>
>> I was wondering if this was something to fix in ipipe or xenomai ?
>>
>> François
> 
> 
> Do the newer kernels have the same return value? Do we test 3.2.x on the
> older kernels? Maybe just cip ?
> 

We limited testing to 4.4-cip with 3.0.x. Newer kernels require newer
Xenomai, and vice versa.

But let's first understand if the issue if 4.4-specific.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

