Subject: Re: RTnet on Raspberry Pi 3B+
References: <DDED34AC-1834-4932-B053-AD8EEF810205@gmail.com>
 <CAFc1U0uqCWknFJj1FFMk2Ge7XEH1nRUwXek2Ay7nvmBXh03nqg@mail.gmail.com>
 <DD8FF5D6-AF88-4EAB-9E9D-3BA4B9B57CEA@gmail.com>
From: Giulio Moro <g.moro@qmul.ac.uk>
Message-ID: <c137965c-cb45-2b9a-2795-3b1343f0e55a@qmul.ac.uk>
Date: Sun, 11 Oct 2020 23:01:13 +0100
In-Reply-To: <DD8FF5D6-AF88-4EAB-9E9D-3BA4B9B57CEA@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Deniz_U=c4=9fur?= <deniz343@gmail.com>, Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai <xenomai@xenomai.org>

You can download a working Debian image with Xenomai that runs on BB here https://github.com/BelaPlatform/bela-image-builder/releases
This contains Linux 4.14.108-ti-xenomai-r135 with Xenomai 3.0.10

The kernel is built from this branch https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-xenomai-4.14.y

I haven't tried RTDM SPI, but there seems to be a driver for it: https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/kernel/drivers/spi/spi-omap2-mcspi-rt.c



Deniz Uğur via Xenomai wrote:
> Hi Pierre,
> 
> I’ve just checked out BeagleBone Black and it seems applicable for me. If you don’t mind I have some follow-up questions.
> 
> Do you know if RTDM SPI works on BB?
> Which ipipe, xenomai, and linux version combination is working on the BB right now?
> Are there any recent guides for Xenomai 3 on BB?
> 
> Thanks.
> Deniz.
> 
>> On 11 Oct 2020, at 20:39, Pierre FICHEUX <pierre.ficheux@smile.fr> wrote:
>>
>> Hi,
>>
>> Pi Ethernet controller is based on USB, not that good for realtime (AMHA)...
>>
>> May you could switch to BeagleBone Black ?
>>
>> regards
>>
>> Le sam. 10 oct. 2020 à 10:21, Deniz Uğur via Xenomai <xenomai@xenomai.org <mailto:xenomai@xenomai.org>> a écrit :
>> Hello all,
>>
>> I’m currently researching for a real-time sensor data acquisition system and I was thinking about using Raspberry Pi 3B+. Along with my move to making everything real-time, I also want to experiment with RTnet. Although from what I can understand, RPi’s ethernet module is not supported in RTnet.
>>
>> Is RPi not supported in RTnet? If not, is there anything I can do to bring this feature?
>> Do I have any alternative for making TCP socket connection real-time using Xenomai on RPi?
>> Lastly, If RPi is an impossible target for RTnet, do we have any alternative embedded system that works with RTnet?
>>
>> Thanks in advance.
>> Deniz.
>>
>> Some important details:
>> ARCH: ARM
>> SoC: BCM2835
>> Linux: 4.14.36
>> Xenomai: 3.0.7
>> I-Pipe: 4.14.36-arm-1
>>
>>
>> -- 
>> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>
>>                               http://www.smile.fr/ <http://www.smile.fr/>
>>                               https://smile.eu/fr/offres/embarque-iot <https://smile.eu/fr/offres/embarque-iot>
>> I would love to change the world, but they won't give me the source code
> 

