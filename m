MIME-Version: 1.0
From: Grant Liu <grant7788@gmail.com>
Date: Tue, 25 Oct 2016 10:37:14 +0800
Message-ID: <CALxt+8tmhvRVB3wpem5OP41C65Qs+QP+yWKqYSiQmMN7uKxzRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] xenomai 2.6.4 ToD drift hunge in linux kernel 3.14.17
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello xenomai,

I have one Intel atom e3826 platform from Neousys technology,
(http://www.neousys-tech.com/products/embedded/poc-120/)
and I want to install xenomai 2.6.4 on linux kernel 3.14.17,
but the result of clocktest is un-acceptable (ToD drift more than 1000us/S).
After tuned the parameters for several times, the issue remain unchanged.
So I turn to  other kernel, and found out the on kernel 3.8.13, the ToD
drift is around -40us/S, which is very good.
I used the same config file, and all build procedure are the same.
Would you please kindly let me know what's the root cause?
I attached config file and screen capture for your reference.
Thank you in advance.

I compared the clock source on both kernel:
available_clocksource: tsc hpet acpi_pm
current_clocksource: tsc
well cpu frequency shows some difference:
on kernel 3.8.13: 1466.726
on kernel 3.14.17: 1465.200

BRs,
Grant
