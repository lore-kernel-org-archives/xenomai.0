MIME-Version: 1.0
References: <CAJte2PC6cFhYMqY9-XGbrkmiw+U5_hQW0S03iCjDWuLKtDW8OA@mail.gmail.com>
 <87o8b27ku5.fsf@xenomai.org>
In-Reply-To: <87o8b27ku5.fsf@xenomai.org>
From: Byron Jacquot <bjacquot@cardinalpeak.com>
Date: Wed, 21 Jul 2021 12:52:09 -0600
Message-ID: <CAJte2PA=Q+OVYgPaV-P3qh-urFLxLoZXwR3RZmu=3ZxJh0MJXw@mail.gmail.com>
Subject: Re: Taking first steps with EVL
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hello Philippe,

Thank you for the response!  I've had a chance to put your advice into a
practical form.

As my ultimate application doesn't need Alsa, I'm moving forward with
porting the RTDM driver.  I've got a crudely hacked version working, and
I'm working on getting some nontrivial application code to stand on top of
it.

A first question I've got: is there a way to tell if my DMA IRQs are IB or
OOB?  /proc/interrupts seems to be counting them regardless of the flag
setting, and the performance appears to be very good either way.

I've seen the recommendations for isolcpus & thread affinity - would you
recommend that for the IRQs, also?

Similarly, I'm watching the numbers in
/sys/devices/virtual/thread/*/stats.  The in-band switch count is constant
after init, but the CPU % utilization number (last number in the row)
doesn't seem to be reflective of the load.  I'm doing trivial work in my
application (catching the return of the OOB ioctl, copying input buffers to
output), and it's showing numbers in the 200 to 300 range.  Does that seem
right?  Looking at the nanoseconds consumed field, it looks like it might
be a count of milliseconds consumed per second?

Thank you,

Byron Jacquot
