MIME-Version: 1.0
Date: Sat, 5 Jun 2010 10:22:41 +0800
Message-ID: <AANLkTil10j3uoPdVXmgE8kIPrMQRSAArQB5gz3swDruD@mail.gmail.com>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] RTDM rs232 strange behavior
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi All,

I am playing around with xenomai and RTDM serial driver on a
1.7Ghz Pentium-M machine running xenomai 2.5.3. The example cross-link
produced this result:

main : starting read-task
 Nr |   write->irq    |    irq->read    |   write->read   |
-----------------------------------------------------------
  0 |          118948 |          614135 |          733083
  1 |          115598 |          614281 |          729879
  2 |          108917 |          614982 |          723899
  3 |          106101 |          616560 |          722661
  4 |          113457 |          614971 |          728428
  5 |          110358 |          614265 |          724623
  6 |          106499 |          614406 |          720905
  7 |          110363 |          615015 |          725378
  8 |          115478 |          614840 |          730318
  9 |          110766 |          614168 |          724934
 10 |          108986 |          616435 |          725421
 11 |          108030 |          614299 |          722329
 12 |          109369 |          614420 |          723789
 13 |          105862 |          614456 |          720318
 14 |          110428 |          616301 |          726729

Is 0.7 millisecond between write and read a reasonable number?


I then changed the example a little: I let write task only
write 4 characters and instruct read task to read 10 characters.
I thought the read task will tell me when that only 4 characters
is read. But to my surprise, it waited until write-task
filled all 10 characters before finish reading. How can I
change the code to just do the read to whatever charaters
are avaliable without waiting to fill all the characters I
asked for? I will use this capability to read a GPS. It's
output length is unknow before reading.

Most GPS can also produce a precisive time pulse when data
is ready. Is it be possible to connect this to a pin in rs232 (CTS, for example)
to triger a IRQ so the data can be read in a timely manner?

Many thanks in advance.

Everett

