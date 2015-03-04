MIME-Version: 1.0
Date: Wed, 4 Mar 2015 08:59:47 -0800
Message-ID: <CAEMXjGyiUw52yB3SD1vZT5pwnmAR6Sh_qCgxbc_-RTu1kKRDdA@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] RTDM device driver interrupts over primary mode task?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello,

Is it possible that my hardware interrupts tied to RTDM device drivers are
able to pre-empt my high priority task running in primary mode, or do the
interrupts get serviced after the task yields the CPU?

Thanks,

Steve
