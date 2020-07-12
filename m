MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Sun, 12 Jul 2020 13:54:10 +0800
Message-ID: <CAAvDm6Zrag3Rk0Gn1WDAYZxe+wAVsUy6BXQ9O2_EAAywet1O3Q@mail.gmail.com>
Subject: Is it possible that Xenomai threads block the Linux domain NMIs from
 being processed for some time?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi, list

As the paper on the official website(
https://xenomai.org/documentation/branches/v2.0.x/pdf/Life-with-Adeos.pdf),
which says that:
However, thanks to the virtualization of the interrupt control Adeos
brings, a higher priority domain can still receive interrupts, and
eventually preempt any lower priority domain.

And as far as I know from your website, Xenomai threads have higher
priority than any Linux thread.
But does they have higher priority than Linux domain interrupts?
So several related questions raise:
* If the CPUs are occupied by Xenomai threads for several seconds(e.g.
  1s or 2s), will the NMIs for Linux domain have to wait for the
  Xenomai threads releasing the CPUs?
  Is it possible that Xenomai threads block the Linux domain NMIs from
  being processed for some time?

* If the Linux domain is processing interrupts(normal interrupts and NMIs),
  and a Xenomai thread is ready to ready at the same moment, will the
  Xenomai thread run at once and block the processing of Linux domain
  interrupts?


Thank you for your attention to this matter.
Looking forward to hearing from you.
Best Regards.

