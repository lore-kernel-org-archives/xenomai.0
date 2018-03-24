MIME-Version: 1.0
From: Gabriel Aguirre-Ollinger <elgao68@gmail.com>
Date: Sat, 24 Mar 2018 21:55:20 +0800
Message-ID: <CADwKwfCSLMHEwJfQdiDnhuFC_fbgZYZkLKe5okG8BGcC82TguA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] rt_event_wait_timed() returns EFAULT error?
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
I'm running Xenomai/cobalt v3.0.5 on an Intel(R) Celeron(R) CPU. Currently
I'm writing a real-time task loop that requires execution to stop until a
signal with a certain integer value is received. Thus I've included a call
to rt_event_wait_timed() to wait for the appropriate value to be written to
the mask; I'm specifying a NULL timeout value. The problem I have is that
rt_event_wait_timed() consistently returns EFAULT ('bad address') and
returns without blocking. I don't know what this error means since it is
not even considered in the Xenomai manual documentation as one of the
possible returns for rt_event_wait_timed(). I have also tried
rt_event_wait() with the exact same result. Any help will be appreciated.

Gabriel
