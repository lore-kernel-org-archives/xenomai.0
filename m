Subject: Re: INTR-REMAP error with UDD driver
References: <abVhmVLZoPCMWqAbSv547Q_VzyvVJlNAswLDgIKZpMzhMhOvYJNQYRGT6rz470Lgp_xFfkgLpsUSzHdOpFyyXuww10kuZ0VSUH-Nyf82P0I=@protonmail.com>
 <3c48366f-5fec-be5e-1ea0-8e1504a249ed@siemens.com>
 <CzF7Hair8MCzMzyofjGVG75XADx_cYSu_WZPsPGaZxziMjYEyffMw-JgvN5XMUUNHGrz6BKLyTdaaiQ63kf_9EfMf613OnO9toYUQbDigFc=@codecraftsmen.org>
 <e9af8088-382d-63d5-0088-13dedf556fb8@siemens.com>
 <2wKIW_3RM1ITgcnfgLs5MhRJzN0H8IoNQS0bqS5xCseD17bCWWjHGwqgtzQLp8Cm-ecpiviS_6ZxpJMuL1xRG3x6WDp-Smima8DEieDhuwY=@codecraftsmen.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9ed83a4f-b55b-1d10-2829-48d9304d8471@siemens.com>
Date: Fri, 15 Nov 2019 14:07:39 +0100
MIME-Version: 1.0
In-Reply-To: <2wKIW_3RM1ITgcnfgLs5MhRJzN0H8IoNQS0bqS5xCseD17bCWWjHGwqgtzQLp8Cm-ecpiviS_6ZxpJMuL1xRG3x6WDp-Smima8DEieDhuwY=@codecraftsmen.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <w1@codecraftsmen.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "pero@wolfram.com" <pero@wolfram.com>

On 15.11.19 01:16, Jeff Webb wrote:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Thursday, November 14, 2019 3:41 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 14.11.19 14:16, Jeff Webb wrote:
>>> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
>>> On Thursday, November 14, 2019 1:50 AM, Jan Kiszka jan.kiszka@siemens.com wrote:
>>>
>>>> On 14.11.19 06:05, Jeff Webb via Xenomai wrote:
>>>>
>>>>> I would like to revive this thread from several months ago:
>>>>> https://xenomai.org/pipermail/xenomai/2019-March/040498.html
>>>>> The issue is that on some hardware (a specific rack-mount PC with a PICMG daughtercard on a backplane containing PCI and PCIe slots) I get an INTR-REMAP error when trying to receive legacy (not MSI) interrupts from a custom FPGA-based PCI card using a UDD driver. The card did work properly in one out of the five PCI slots on that machine, but UDD interrupts did not work in the other four slots.
>>>>> Please review the original thread for more details about the specific error.
>>>>> Here are a few more tidbits I have gathered:
>>>>>
>>>>> -   The UDD driver / userspace code works fine on the other hardware
>>>>>
>>>>> -   The UDD driver / userspace code works fine in one PCI slot out of five on this hardware.
>>>>>
>>>>> -   With another backplane model, but same processor card, the problem occurs in all four of the PCI slots.
>>>>>
>>>>> -   An almost identical pure-linux UIO version of the driver / userspace code works in all the cases I tested, even when the UDD version fails, and even with the same xenomai-patched kernel used for UDD testing.
>>>>>
>>>>>
>>>>> In one of the previous posts in this thread a few months ago, Per Öberg mentioned experiencing something similar. Based on the information that was shared, I tried my code with linux version 4.9.38, but it still failed. This prompted me to try other linux / ipipe / xenomai combinations. These are my findings:
>>>>> Interrupts work:
>>>>> xenomai-2.6.5 ipipe-core-3.18.20-x86-7.patch (2016-07-05)
>>>>> xenomai-3.0.9+ ipipe-core-3.18.20-x86-7.patch (2016-07-05)
>>>>> xenomai-3.0.9+ ipipe-core-4.1.18-x86-9.patch (2017-05-25)
>>>>> INTR-REMAP error:
>>>>> xenomai-3.0.9+ ipipe-core-4.4.43-x86-6.patch (2017-02-25)
>>>>> xenomai-3.0.9+ ipipe-core-4.4.43-x86-7.patch (2017-05-25)
>>>>> xenomai-3.0.9+ ipipe-core-4.4.43-x86-8.patch (2017-06-14)
>>>>> xenomai-3.1-rc3 ipipe-core-4.4.196-cip38-x86-19.patch (2019-11-04)
>>>>> xenomai-3.0.9+ ipipe-core-4.9.38-x86-4.patch (2017-10-03)
>>>>> xenomai-3.0.9 ipipe-core-4.14.132-x86-6.patch (2019-07-03)
>>>>> The Xenomai 2.6.5 version of course does not use UDD, but uses the old pthread_intr_* userspace functions.
>>>>> Hopefully this additional information can shed a little light on the matter.
>>>>
>>>> This sounds like some RT interrupt enabling issue related to the IOAPIC
>>>> in the x86 I-pipe patch. Please also test 4.19.
>>>
>>> Ok, I will do this.
> 
> Today I had a chance to make a build based on the ipipe-core-4.19.75-x86-7.patch with xenomai-3.1-rc3.  I haven't had a chance to test it thoroughly, but I think it works.  I am sorry I didn't try this earlier, and thanks for the reminder to do so.  Since a 4.19 patch wasn't available back in early March when I first had the trouble, I got fixated on the fact that things worked with very old kernels and forgot to try 4.19 when I started looking into this again.  I will continue to test and let you know if I find any issues.
> 

I'm also not seeing the problems I have with 4.4 + intremap on 4.19, 
despite all debug features on. OK, let's check what we are missing down 
there...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

