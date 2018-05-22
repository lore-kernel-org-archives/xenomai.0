MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Mon, 21 May 2018 23:09:51 -0700
Message-ID: <CA+K1mPFdYvQ6N_wnc21K5SJGr2241dG1NrpXBPGv0CCJQ+QU7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Only 2 serial ports at a time with xeno_16550A driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Update:
I installed a Moxa 4 port PCI serial card, which has a shared interrupt for
all 4 ports.
I did this:
modprobe xeno_16550A io=0xd040,0xd048,0xd050,0xd058 irq=17,17,17,17
baud_base=921600,921600,921600,921600

This worked fine, I was able to communicate bidirectionally on all four
ports in sequence, indicating that my kernel and xeno_16550A module are
compiled correctly for shared interrupts. I'll try simultaneous use of
these ports tomorrow.

The previous problem must have been the actual serial ports I was using,
which are the ones provided by the motherboard.

thanks,
-C Smith
