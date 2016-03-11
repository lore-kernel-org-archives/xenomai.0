MIME-Version: 1.0
From: Nicolas SCHURANDO <schurann@ext.essilor.com>
Date: Fri, 11 Mar 2016 17:24:57 +0100
Message-ID: <CA+CJOCy8Y_juOdkNYKv0pJCbn1fjKrJCBDxn_mr8A4S-bsHfPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Raspberry Pi RTDM SPI Driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: massimo.savana@gmail.com

Hello everyone,

I have written a Xenomai 3.0 RTDM SPI driver for the Raspberry Pi 1 and 2,
and I thought I would share it here as I believe it could be of use to some
of you.

There is room for improvement as only polling transfer has been implemented
so far. But if anyone feels the courage to implement interrupt-based or
dma-based transfer, your contribution is welcome!

https://github.com/nicolas-schurando/spi-bcm283x-rtdm

Regards,

Nicolas
