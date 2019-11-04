Subject: Re: Xenomai fails to start when running in QEMU VM
References: <CAJPjb1LG3HTfUC0FFDATAkb3-6f=nj5J+6d+gdLL3yAwxt8avQ@mail.gmail.com>
 <9224513f-51e2-1ddb-107f-58a1142b3085@siemens.com>
 <CAJPjb1+d___e1BE3tk=us9WAr0HcW3QC5ROgWaRUMPXngudqpQ@mail.gmail.com>
 <8148a617-8087-076e-f1f1-bd337e2c7a14@siemens.com>
 <CAJPjb1KgLBHRq+myFgWATpOYi3ifUahj5G2f9VQe7YKgr0UhVQ@mail.gmail.com>
 <CAJPjb1KwBgJp+Zx2CKjCK2y8C6Omj43EQCSm2CnSffbZ01AOSg@mail.gmail.com>
 <CAJPjb1JYRu493q_zpBKDLRS9HhcGb-4YvZqr12nuQN0_JwC4gA@mail.gmail.com>
 <CAJPjb1+qSBrqC5FX5j5E9awpBT6y6Z_wz8+oPR_=hQP_RsnBvA@mail.gmail.com>
 <61b4cc10-1197-2e74-8fff-9c2878287390@web.de>
 <CAJPjb1JCojSH_TmL0jwkBpCVhzNEJbPKsNMVkr_p5Wq2LLE+aQ@mail.gmail.com>
 <96377681-69a9-e2c5-d454-9732bc785938@web.de>
 <CAJPjb1LYUuiS7ZRqnKW5rDj8i23gjpthR1Nz+7AU7dkXO-GUyQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <138a84eb-d45a-7fd3-c175-43aaf31383bd@siemens.com>
Date: Mon, 4 Nov 2019 12:24:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAJPjb1LYUuiS7ZRqnKW5rDj8i23gjpthR1Nz+7AU7dkXO-GUyQ@mail.gmail.com>
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
To: Rob Miller <rob.miller@broadcom.com>
Cc: xenomai <xenomai@xenomai.org>

On 24.10.19 15:38, Rob Miller via Xenomai wrote:
> responses in-line...
> 
> Rob Miller
> rob.miller@broadcom.com
> (919)721-3339
> 
> 
> On Thu, Oct 24, 2019 at 8:12 AM Jan Kiszka <jan.kiszka@web.de> wrote:
> 
>> On 24.10.19 13:46, Rob Miller wrote:
>>> Pls see below
>>>
>>> Rob Miller
>>> rob.miller@broadcom.com <mailto:rob.miller@broadcom.com>
>>> (919)721-3339
>>>
>>>
>>> On Thu, Oct 24, 2019 at 6:25 AM Jan Kiszka <jan.kiszka@web.de
>>> <mailto:jan.kiszka@web.de>> wrote:
>>>
>>>     On 23.10.19 23:23, Rob Miller via Xenomai wrote:
>>>     > Correction, stock images work by removing the enable-kvm and *NOT
>>>     *adding
>>>     > the -no-hpet QEMU cmdline options.
>>>     >
>>>     > also latency numbers are crazy with avg being 1678.126 usec w/
>>>     worst case
>>>     > being 15463.240usec
>>>     >
>>>     > at this point, I'm not sure which way to go:
>>>     >
>>>     > 1) do I hunt down issues in HPET failing w/ KVM mode enabled?
>>>     > 2) just go to dovetail
>>>     > 3) ???
>>>
>>>     Don't have a the reference image around, but I'm pretty sure it would
>>>     work here with QEMU 4300b7c2cd9f3f273804e8cca325842ccb93b1ad (post
>> 4.1)
>>>     and KVM from 5.3.6. At least a different image is being used like
>> that
>>>     for ages, and kernel config in xenomai-image is basically derived
>>>     from it.
>>>
>>> RJM>] Will try
>>>
>>>
>>>     For the xenomai-images check, did you use "start-qemu.sh x86" as-is?
>>>
>>> RJM>] Yes, my 1st failed attempts used unmodified start-qemu.sh x86,
>>> then I mod'd the file to remove the -enable-kvm, and it started to work
>>> UNTIL also added -no-hpet, then I can't even boot up.
>>>
>>
>> Number of host cores >= number of guest CPUs? If not, reduce -smp in the
>> QEMU invocation.
>>
> RJM>] yup, host has 16 cores whilst guest has 4 (using the stock images).
> 
>>
>> Oh, and don't expect any kind of determinism in these setups. KVM and
>> QEMU are for functional testing only.
>>
> RJM>] Ah, good to know.
> 
>>
>> Jan
>>

Were you able to resolve the mystery? I've just retest a fresh build of
xenomai-images from master like this:

kas-docker --isar build kas.yml:opt-xenomai-next.yml:board-qemu-amd64.yml

And then I ran the result on my OpenSUSE 15.1 (qemu-3.1.1-lp151.7.3.3, 
kernel-default-5.3.7-6.1.g387f2bb), and it worked. TSC calibration
happened against PIT.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

