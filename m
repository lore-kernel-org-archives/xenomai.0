References: <b64eb377-5c88-a933-b7b6-a7ad3c194e30@iit.it>
 <CALLqZ8TPGMLN=rq3a3zAiRPBQZw710Ec4FHpeKHeOFFpnhiVMw@mail.gmail.com>
From: alessio margan <alessio.margan@iit.it>
Message-ID: <36155513-4fc7-7e28-3908-ab4473e992e8@iit.it>
Date: Mon, 19 Feb 2018 13:20:15 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8TPGMLN=rq3a3zAiRPBQZw710Ec4FHpeKHeOFFpnhiVMw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Xenomai] Nvidia TX1/TX2 Boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks.

I' ve red about RPI as reference board, does rtnet works on them ? which 
boards/model should I give a try ?

Alessio


On 16/02/2018 17:41, Greg Gallagher wrote:
>      As far as I know there is no Ipipe patch for L4T so you'd have to
> use mainline Linux if you'd like to run Xenomai on the TX1 or TX2.
> I'm not sure what tools this would leave you with for the GPU but I
> don't think Cuda works with the nouveau drivers.
>      The other issue that I've seen on x86 boards with Nvidia gpus is
> it's unknown how long the Nvidia driver turn interrupts off for, so
> latency may be affected.  I don't think there are plans to port the
> ipipe to L4T but if you would like to try I'm sure people here would
> be willing to answer questions.
>
> -Greg
>
> On Fri, Feb 16, 2018 at 10:10 AM, alessio margan <alessio.margan@iit.it> wrote:
>> Hi all,
>>
>> does anybody have successfully run Xenomai-3+RTnet on NVIDIA Jetson TX1/TX2
>> compute modules ?
>>
>> this is a TX1 lscpu output
>>
>> nvidia@tegra-ubuntu:~$ lscpu
>>
>> Architecture:          aarch64
>> Byte Order:            Little Endian
>> CPU(s):                4
>> On-line CPU(s) list:   0-3
>> Thread(s) per core:    1
>> Core(s) per socket:    4
>> Socket(s):             1
>> Model name:            ARMv8 Processor rev 1 (v8l)
>> CPU max MHz:           1734.0000
>> CPU min MHz:           102.0000
>> Hypervisor vendor:     (null)
>> Virtualization type:   full
>> L1d cache:             32K
>> L1i cache:             48K
>> L2 cache:              2048K
>>

