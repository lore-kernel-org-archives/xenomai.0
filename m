MIME-Version: 1.0
From: Benjamin Alix <alixbenjamin53@gmail.com>
Date: Mon, 12 Jun 2017 11:28:45 +0200
Message-ID: <CAHz_r8CzA4cC1ny7f99CV2Nnt57Mr4=yb1cVF1r8NOBMkHD39Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai]  Destroy rtdm task
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

I'm writing rtdm modules under Xenomai 2.6.4 and Linux 3.18.13.

I'm trying to understand how to destroy a rtdm task. In my close
function I simply destroy all tasks and then destroy the events. But
it seems that one of the tasks isn't destroyed and the call to
rt_dev_close in the Xenomai application I'm running is pending.

This task is waiting on an event but even when I'm sending a signal to
this event and then try to destroy the task I get the same results.

So I was wondering if there was a better way to destroy a rtdm task
which is waiting an avent signal ?

Thanks

Benjamin ALIX

