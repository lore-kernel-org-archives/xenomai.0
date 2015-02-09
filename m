MIME-Version: 1.0
Date: Mon, 9 Feb 2015 09:42:55 -0800
Message-ID: <CAEMXjGxixe5fgX-7uijpcGkNoPzoZcocJxEK-D+VqBdopx4puQ@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Bosch CCAN/DCAN driver for RTDM
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
I have put together a quick port of the Linux driver for CCAN/DCAN to work
with RTDM, thanks to Wolfgang Grandegger's Flexcan driver port as an
example.

It's not thoroughly/formally tested, but it works with rtcansend and
rtcanrecv, and works well with my application sending and receiving a few
hundred frames per second at 500k baud, which I think is a good enough
initial test for me.
I can also give the "rtt" test a shot when I have time.

Is there anyone out there who would like to test this? I am wondering what
is the procedure to submit, should I create a patch and attach? I haven't
looked at how to add it into the kernel build process, I have just built it
in its own separate place so far.

Steve
