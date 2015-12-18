References: <CAJONJDuLVmoDdUDc3rz3qYN1TtjMo6R3SCw0Z5=x8e69ti3kkw@mail.gmail.com>
 <BLU436-SMTP188D753B1DBA2F4D5B54C3AF00B0@phx.gbl>
From: Joe <joelee271828@gmail.com>
Message-ID: <5673A6B5.3030108@gmail.com>
Date: Fri, 18 Dec 2015 14:24:53 +0800
MIME-Version: 1.0
In-Reply-To: <BLU436-SMTP188D753B1DBA2F4D5B54C3AF00B0@phx.gbl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2 (version #5)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>, xenomai@xenomai.org

On Sunday, December 06, 2015 06:34 AM, Mathieu Rondonneau wrote:
> On 15-12-04 07:42 PM, Joe Lee wrote:
>> Hi Mathieu,
>> I apply the patch by Xenomai latest stable v3.0.1 to my RPI2, and
>> sometimes the booting hang like this:
>>   * Starting configure network device security[ OK ]
>>   * Stopping load modules from /etc/modules[ OK ]
>>   * Stopping userspace bootsplash[ OK ]
>>
>> That's low probability, about 1 of 60 times booting, and the original
>> not patched kernel is OK.
>> The kernel is the latest version from
>> https://github.com/raspberrypi/linux/tree/rpi-3.18.y .
>> First, I apply the ipipe patch "ipipe-core-3.18.20-arm-6.patch" from
>> https://xenomai.org/downloads/ipipe/v3.x/arm/ . Then I apply your RPI
>> patch version #5. The kernel is build follow this instruction
>> https://www.raspberrypi.org/documentation/linux/kernel/building.md .
>> The root file system is Ubuntu 14.04 LTS for RPI2, which from
>> https://wiki.ubuntu.com/ARM/RaspberryPi .
>> Attached is the kernel booting hang log file and kernel config file.
>> What can I do to get more infomation for debugging when kernel booting hang?
>> Look forward to your reply.
>
> Hi Joe,
>
> The only difference with your .config file is that I have earlyprintk
> enabled but that should not cause the issue you are observing.
>
> I am using the raspbian rootfs downloaded from the raspberry pi
> foundation website:
> https://www.raspberrypi.org/downloads/raspbian/
>
> can you try disabling xenomai from the kernel config to see if the
> problem happens also when only the IPIPE patch is turned ON?
>
> Thanks,
> -Mathieu
>
I'm so sorry, that's my RTL8192CUS USB WIFI dongle cause the issue.
Without the dongle the patched kernel with Xenomai 3.0.1 enable is OK.
May be the USB or WIFI driver cause the issue, I'm going to test the 
RT5370 WIFI dongle.

-- 
Joe Lee

