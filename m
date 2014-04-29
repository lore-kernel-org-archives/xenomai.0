MIME-Version: 1.0
Date: Tue, 29 Apr 2014 17:07:53 +0200
Message-ID: <CAF-_xSQO+RJ8UFNZpoPyifKew3k+vbJufuGD5YuxtdEeub9_5Q@mail.gmail.com>
From: Massimo Savina <massimo.savina@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai]  Raspberry Pi UART and SPI RTDM drivers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi guys,
I started to develop an application based on the Raspberry Pi, which makes
use of SPI and UART peripherals, to talk with realtime hardware (1ms loop
on SPI, 10ms loop on UART).
So I need of realtime drivers for the SPI and UART port.
1) Can I use the current 16550A-Compatible UART driver or do I have to
adapt it to the PL011 available on RPi Broadcom?
2) Is already available a SPI rtdm driver for RPi, or where it is better to
start to write one from myself?

Thank in advance,
Massimo.
