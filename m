Message-ID: <5358B713.9040300@easyarm.com>
Date: Thu, 24 Apr 2014 12:32:43 +0530
From: vattipalli <praveen.v@easyarm.com>
MIME-Version: 1.0
References: <5355F933.20200@easyarm.com> <535640F8.1040805@xenomai.org>
In-Reply-To: <535640F8.1040805@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] porting xenomai to 3.2 kernel using SOC Ti Am3359
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,
Thanks for your help.

As per your suggestion, instead of working on linux-3.2 kernel for 
Am3359, I want to configure Xenomai  for 3.13 kernel. Can i get any 
patches for kernel 3.13 kernel.  Because I have gone through 
ksrc/arch/arm/patches/README in Xenomai 2.6.3 sources, I found patches 
for 3.8 kernel for Beaglebone.

Thanks & Regards
Praveen




On Tuesday 22 April 2014 03:44 PM, Gilles Chanteperdrix wrote:
> On 04/22/2014 07:08 AM, vattipalli wrote:
>> hi, I am working on Ti Am3359 processor with linux-3.2 kernel. I am
>> trying to port Xenomai. I have applied ipipe-core-3.2.21-arm-4.patch
>> patch, and compiled the kernel. But when booting uImage it hanged at
>>
>> Uncompressing Linux... done, booting the kernel. I could not see any
>> console after this.
> The I-pipe patch for Linux 3.2 does not support Am33xx processors. And
> in fact has known bugs, so is not recommended at all. We have more
> recent patches for Linux 3.8 and Linux 3.10. See the help for beaglebone
> in ksrc/arch/arm/patches/README in Xenomai 2.6.3 sources.
>
>
>> But the above patch   Support for CSR SiRFSoC ARM
>> Cortex A9 Platform.
> I do not understand this sentence.
>
>> Could i get any patch for ARM Cortex A8
>> Platform(Ti AM3359) for linux-3.2 kernel.
> No.
>


