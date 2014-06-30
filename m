MIME-Version: 1.0
Date: Mon, 30 Jun 2014 14:36:05 +0430
Message-ID: <CAKKWdtdYQgAHFr0yH9jReFa5FS-dN2t2FLfng9=GAmktEBUuUw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] a question about interrupt handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

When an interrupt is serviced in Linux or root domain, it is regarded
as a non real time interrupt and the pipe line stage of root domain is
stalled, so if another real time interrupt happnes  at the same time,
it will be logged for root domain and will be delayed, I mean there is
an unpredictable interrupt lateny for real time interrupts.
I wonder if any professional can explain more about this and if the
above statement is correct.
I appreciate much in advance

