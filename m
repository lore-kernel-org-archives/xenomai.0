MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Tue, 18 Jan 2022 15:12:49 +0800
Message-ID: <CAAvDm6YgEyJuX98RzioWFTrWdY2zGDPGdptLnL9oivVHmsCZsg@mail.gmail.com>
Subject: About the kernel configuration(CONFIG_CPU_FREQ and CONFIG_CPU_IDLE.)
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
I am using Xenomai-3.1 + Linux 4.19.84.
Hardware name: UNO-2372G-J021AE.

As per this official document
(https://source.denx.de/Xenomai/xenomai/-/wikis/Troubleshooting#kconf),
which says tells me that I should disable both CONFIG_CPU_FREQ
and CONFIG_CPU_IDLE.

For your convenience, the aforementioned document is listed below:
>Common kernel configuration issues
>When configuring the Linux kernel, some options should be avoided.
>CONFIG_CPU_FREQ
>CONFIG_CPU_IDLE
>...

It's strange that the frequency of the CPU is not constant if I both
disable CONFIG_CPU_FREQ and CONFIG_CPU_IDLE
whereas
the frequency of the CPU is not constant if I only disable CONFIG_CPU_FREQ
(left CONFIG_CPU_IDLE int enabled state).

Could somebody please shed some light on this matter?
