Subject: Re: Open source audio project for Raspberry Pi 3
References: <CAKsggZxO58KU27Uf_-i3yLgk4kcjoOUqSS_PZLC0gndXBNU=GQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f912dfe0-7ac8-dbf9-1451-e6012eae8792@siemens.com>
Date: Thu, 9 Jan 2020 16:36:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAKsggZxO58KU27Uf_-i3yLgk4kcjoOUqSS_PZLC0gndXBNU=GQ@mail.gmail.com>
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
To: Stefano Zambon <stefano@elk.audio>, xenomai@xenomai.org

Hi Stefano,

On 09.01.20 13:05, Stefano Zambon via Xenomai wrote:
> Hi,
> 
> we just finalized to release on Github the full source code for our
> professional audio distribution based on Xenomai:
> https://github.com/elk-audio
> 
> This is somehow similar to the Bela project for Beaglebone which has been
> around for quite a while and also completely open sourced:
> https://github.com/BelaPlatform
> 
> I thought to mention it here since it is quite a complete example for
> Xenomai on the RPi, including a DMA-capable I2S driver, a sensor driver
> (through SPI) that handles both GPIOs and ADCs, multicore support in both
> primary and secondary context, C++17 Xenomai applications, CMake-based
> projects, Yocto/Openembedded configuration.
> 
> We are aware that some parts deviate a little bit from Xenomai's standard
> guidelines, mostly in userspace we don't use the wrapper magic to
> automatically replace POSIX calls with Cobalt alternatives as we prefer
> explicit use of Cobalt functions.
> 
> In order to run the software, you would need a custom Hat for the RPi but
> it shouldn't be hard to customize the drivers for other audio codecs. I
> hope this won't sound like shameless self-promotion, we make very little
> money on the Hardware and the full HW project is open-sourced, including
> the production files so literally anyone can print the boards on its own.
> 
> Cheers,
> Stefano
> 

Thanks for sharing, looks like a really nice user story! Do you consider 
presenting it at some community event(s) as well?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

