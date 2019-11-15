Subject: Re: [ANNOUNCE] Xenomai v3.1-rc3 available
References: <y27Ah4Xs-t8bhib0n5wvb0RE8X2b-B4GbVUz2PHHbETtMbl4SjmsFQP7GPGLfWozQrc_BW9MqoZFFIq0RYnMjvl_VQ0ecJz5Tp5fcaXPKcg=@codecraftsmen.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e2ceb276-09e5-2a11-ac34-3926668615e0@siemens.com>
Date: Fri, 15 Nov 2019 11:40:02 +0100
MIME-Version: 1.0
In-Reply-To: <y27Ah4Xs-t8bhib0n5wvb0RE8X2b-B4GbVUz2PHHbETtMbl4SjmsFQP7GPGLfWozQrc_BW9MqoZFFIq0RYnMjvl_VQ0ecJz5Tp5fcaXPKcg=@codecraftsmen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Jeff Webb <w1@codecraftsmen.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 15.11.19 01:31, Jeff Webb via Xenomai wrote:
> I am building a Xenomai cobalt kernel under Ubuntu 18.04 based on:
> 
>     Linux 4.19.75
>     Xenomai 3.1-rc3
>     ipipe-core-4.19.75-x86-7.patch
> 
> After running prepare-kernel.sh and "makeolddefconfig" (using the unmodified default .config), I get this error:
> 
>     WARNING: unmet direct dependencies detected for PARAVIRT
>       Depends on [n]: HYPERVISOR_GUEST [=y] && !IPIPE [=y]
>       Selected by [m]:
>       - HYPERV [=m] && X86 [=y] && ACPI [=y] && X86_LOCAL_APIC [=y] && HYPERVISOR_GUEST [=y]
> 
> I turned off HYPERVISOR_GUEST manually to fix the warning.  I hadn't seen this type of error before, but perhaps something could be done in the patch to make the default config consistent...  Just FYI.

It's HYPERV what causes this, by also pulling PARAVIRT which is not 
compatible with I-pipe. We need to tag that config as well to avoid this.

> 
> Otherwise, everything went fine with the build process and initial testing.  I will be giving this build some more testing over the next week or so and will let you know if I find any issues.

Great to hear, thanks.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

