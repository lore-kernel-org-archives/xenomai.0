MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 13 Jun 2018 10:25:00 -0700
Message-ID: <CA+K1mPGChtz-6Hj3_VE_BTg9QL+4V7c-mRO8MjrM18OQ81BCfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] How to print to dmesg buffer from an RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'd like my Xenomai task to write to both stdout and also to the kernel's
dmesg buffer.
It is a periodic task started with rt_task_create().
When I do rt_vfprintf(stdout, ...)
it prints to stdout OK, but I also want to send the same string to the
dmesg buffer, and
I can't call printk() or rtdm_printk() because this task isn't a kernel
module.

(I'm using Xenomai 2.6.5 on x86.)

Thanks
