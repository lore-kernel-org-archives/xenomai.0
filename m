From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.1 is out!
Message-ID: <5e8d9df2-071b-2243-97ac-9a983b404fc7@siemens.com>
Date: Tue, 4 Feb 2020 18:43:04 +0100
MIME-Version: 1.0
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
To: Xenomai <xenomai@xenomai.org>

Hi all,

finally: release 3.1 is ready. This is the second major release of the 
Xenomai 3 generation and, as this project is moving with a rather 
careful speed, a big step for all of us.

I'm trying to summarize a bit the 471 commits since 3.0.7 (+2 commits, 
that's were we finally forked):

  - support for ARM64
  - support for kernels up to 4.19
  - discontinued support for blackfin and powerpc64
  - priority ceiling protocol for mutexes, fast path syscall-free
  - lazy (syscall free) schedparam propagation from user to kernel space
  - improved debugging of RT application
    (synchronous stop and resume of RT threads)
  - reworked and enhances RT-TCP implementation
  - RTDM-based GPIO PWM generator driver
  - am335x (beaglebone black) omap4 spi real-time driver
  - flexcan driver update
  - improved teardown on RTDM driver removal
  - expanded smokey testsuite
  - ...and many smaller improvements

Makes 484 files changed, 33719 insertions(+), 23060 deletions(-). There 
are a lot of fixes in the there as well, but as long as they were 
affecting also 3.0.x, they went into stable already. Note that 3.0.x is 
not dead. We will continue to maintain it as stable version being used 
not only in our products.

This release had 21 different contributors, which is a good, stable 
number - though this can always be improved. Thanks to all your work on 
Xenomai, keep up with it!

Jan

PS: Download, webpage and docs still need to be updated, give me a day.

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

