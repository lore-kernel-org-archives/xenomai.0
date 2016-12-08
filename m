References: <50ba3868-6953-faef-5ad5-a650c0c0ea24@numalliance.com>
 <20161208083019.4df0c9a8@md1em3qc>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <16441335-9c47-0eae-08be-34499d886f53@numalliance.com>
Date: Thu, 8 Dec 2016 08:38:01 +0100
MIME-Version: 1.0
In-Reply-To: <20161208083019.4df0c9a8@md1em3qc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] memory allocation performance in kernel ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



Le 08/12/2016 =C3=A0 08:30, Henning Schild a =C3=A9crit :
> Am Wed, 7 Dec 2016 15:15:39 +0100
> schrieb St=C3=A9phane Ancelot <sancelot@numalliance.com>:
>
>> Hi,
>>
>> I noticed very bad memory allocation performance on some of my
>> graphic programs (standard linux applications).
>>
>> If you run any classic program, you won't sea any difference, but it
>> has been visible in the following context :
>>
>> I have an application that allocates thousends of graphic widgets,
>> label, input fields  at startup (a data editor) .
>>
>> Using the standard kernel, the applications starts very quickly. But
>> once the ipipe patch is applied to kernel, this application makes lot
>> of seconds before appearing.
> You could profile/trace the application on both kernels and compare the
> profiles from both kernels. That should allow you to narrow down on the
> operations that are slower on ipipe. But with the high level
> description you gave so far, it is hard to tell what is going on.
> A third kernel you could try is the ipipe-patched kernel with ipipe
> disabled, see how that works.
>
> Henning
An interesting note I can add :
if the same program is launched on a remote session with ssh -X , the=20
program starts efficiently and quickly.

>> I am using a 3.18 kernel.
>>
>> I made a diff on both standards and ipipe kernel configs :
>> 236a237
>>   > CONFIG_KPROBES_ON_FTRACE=3Dy
>> 372a374,382
>>   > CONFIG_PARAVIRT=3Dy
>>   > # CONFIG_PARAVIRT_DEBUG is not set
>>   > # CONFIG_PARAVIRT_SPINLOCKS is not set
>>   > # CONFIG_XEN is not set
>>   > CONFIG_KVM_GUEST=3Dy
>>   > # CONFIG_KVM_DEBUG_FS is not set
>>   > # CONFIG_LGUEST_GUEST is not set
>>   > # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
>>   > CONFIG_PARAVIRT_CLOCK=3Dy
>> 427,435d436
>> < CONFIG_IPIPE=3Dy
>> < # CONFIG_IPIPE_LEGACY is not set
>> < CONFIG_IPIPE_CORE=3Dy
>> < CONFIG_IPIPE_WANT_CLOCKSOURCE=3Dy
>> < CONFIG_IPIPE_WANT_PTE_PINNING=3Dy
>> < CONFIG_IPIPE_CORE_APIREV=3D2
>> < CONFIG_IPIPE_TARGET_APIREV=3D2
>> < CONFIG_IPIPE_HAVE_HOSTRT=3Dy
>> < CONFIG_IPIPE_HAVE_VM_NOTIFIER=3Dy
>> 512a514,516
>>   > CONFIG_TRANSPARENT_HUGEPAGE=3Dy
>>   > CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy
>>   > # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
>> 6237d6240
>> < # CONFIG_IPIPE_DEBUG is not set
>> 6356a6360,6361
>>   > CONFIG_DYNAMIC_FTRACE=3Dy
>>   > CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
>> 6357a6363
>>   > CONFIG_FTRACE_MCOUNT_RECORD=3Dy
>>
>>
>> Regards,
>> S.Ancelot
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

