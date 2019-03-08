Subject: Re: INTR-REMAP error with UDD driver
References: <SVZrPK0MQbayn-KPZ4wIvVLcbdluegH0Vxlth0h7DnkST5oo2K5_0Nu6vd-FBcRz3cYtRj5Jl9Wp2nTHSCp-udTCw2_fAcY--f7JNMVUHrg=@protonmail.com>
 <46f899f8-8e3a-8ad5-77d3-5ed0bbc2c546@siemens.com>
 <Mtsj7WK6Smi457BA0VbXiS2OruDJeJ4CvnxF51uGtYcZGGtpR5cCZayoFwt_bxbfxqAvU56y7nmrNxAoT6RthUqGsS1lTYnUDU4vC_3P4Fw=@codecraftsmen.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f29704ba-2c88-e82a-ebf8-359ac6398423@siemens.com>
Date: Fri, 8 Mar 2019 16:00:52 +0100
MIME-Version: 1.0
In-Reply-To: <Mtsj7WK6Smi457BA0VbXiS2OruDJeJ4CvnxF51uGtYcZGGtpR5cCZayoFwt_bxbfxqAvU56y7nmrNxAoT6RthUqGsS1lTYnUDU4vC_3P4Fw=@codecraftsmen.org>
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
To: Jeff Webb <w1@codecraftsmen.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08.03.19 15:07, Jeff Webb wrote:
> On Friday, March 8, 2019 1:14 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> On 08.03.19 02:35, Jeff Webb via Xenomai wrote:
>>
>>> I have implemented a simple UDD mini-driver (interrupt handler) and an associated Xenomai userspace test program. This pair of programs works as intended on one machine. When I tried running the same programs on another machine, I got this error when the first interrupt occurred:
>>> kernel: [ 75.122305] DMAR: DRHD: handling fault status reg 2
>>> kernel: [ 75.123175] DMAR: [INTR-REMAP] Request device [f0:1f.0] fault index ee00 [fault reason 37] Blocked a compatibility format interrupt request
>>
>> This means the device is under IOMMU interrupt remapping regime, but it was
>> programmed to use a standard MSI/MSI-X request, rather than requesting that
>> parameters (address/data tuple) from the Linux interrupt management layer that
>> will assign a remapping slot and hand out the right values. Now you interrupt is
>> stuck in the filter.
>>
>> Before suggesting the workaround/hack to disable interrupt remapping: How did
>> you program MSI/-X? Via proper Linux pci_* helpers?
> 
> The PCI card I am working with does not implement MSI interrupts, but just uses the legacy interrupt pin A.  It's confusing to me that this error is associated with MSI.  Since this behavior is slot-dependent, I figured at first that the error is from another device on the same interrupt line, but I get the same error on several different slots.  There is only one slot where things work as expected.
> 

Ok, then we may have an issue with how we register legacy INTx at the IOAPIC 
when interrupt remapping is on. Basically, the IOAPIC sends MSI-like messages as 
well that are subject to remapping. So its registers need to be programmed with 
the right translatable values, just like the MSI registers of a device. Linux 
does that, it's in charge of the IOMMU. I don't recall how we (Xenomai/I-pipe) 
fill the IOAPIC if a line was not used before under Linux. Possibly, there is 
the wrong Linux function triggered. But maybe it's also something different.

I assume you tested that your card would work find if it used only regular Linux 
driver services, no RTDM, right? That would be good in order to exclude a 
general platform issue, maybe a BIOS (ACPI) bug in describing which PCI slot is 
under which IOMMU regime.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

