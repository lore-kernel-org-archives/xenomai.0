MIME-Version: 1.0
From: Stefano Zambon <stefano@elk.audio>
Date: Thu, 9 Jan 2020 13:05:30 +0100
Message-ID: <CAKsggZxO58KU27Uf_-i3yLgk4kcjoOUqSS_PZLC0gndXBNU=GQ@mail.gmail.com>
Subject: Open source audio project for Raspberry Pi 3
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

we just finalized to release on Github the full source code for our
professional audio distribution based on Xenomai:
https://github.com/elk-audio

This is somehow similar to the Bela project for Beaglebone which has been
around for quite a while and also completely open sourced:
https://github.com/BelaPlatform

I thought to mention it here since it is quite a complete example for
Xenomai on the RPi, including a DMA-capable I2S driver, a sensor driver
(through SPI) that handles both GPIOs and ADCs, multicore support in both
primary and secondary context, C++17 Xenomai applications, CMake-based
projects, Yocto/Openembedded configuration.

We are aware that some parts deviate a little bit from Xenomai's standard
guidelines, mostly in userspace we don't use the wrapper magic to
automatically replace POSIX calls with Cobalt alternatives as we prefer
explicit use of Cobalt functions.

In order to run the software, you would need a custom Hat for the RPi but
it shouldn't be hard to customize the drivers for other audio codecs. I
hope this won't sound like shameless self-promotion, we make very little
money on the Hardware and the full HW project is open-sourced, including
the production files so literally anyone can print the boards on its own.

Cheers,
Stefano
