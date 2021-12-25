MIME-Version: 1.0
From: Yunjie Gu <yunjie.gu1@gmail.com>
Date: Sat, 25 Dec 2021 10:34:24 +0000
Message-ID: <CAKcohPwzA9Vx7iN6t_jazRSdvZFsvxktKH+OYfzFjtHEsHkZHw@mail.gmail.com>
Subject: spi-bcm2835 for rtdm
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, rpm@xenomai.org

Hi Everyone,

I'm trying to use rtdm spi on raspberry pi, and I find something confusing.
I could see there are two spi-bcm2835.c files in the kernel source (after
xenomai patching), one with rtdm, and one native. But these two drivers use
the same .compatible = "brcm,bcm2835-spi", which means the device-tree
cannot distinguish them. Does this mean I have to manually disable the
native spi driver in Kconfig to avoid binding conflicts if I want to use
the rtdm one?

Best Regards,
Yunjie
