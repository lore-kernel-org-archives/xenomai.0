Message-ID: <BLU437-SMTP62CAA597299A3591E31BB9F0760@phx.gbl>
Date: Tue, 4 Aug 2015 06:30:57 -0700
From: Mathieu <mathieu_rondonneau@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  Raspberry Pi 2 patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Miguel Rubio-Roy <mrubioroy@gmail.com>, mobin.seven@live.com, intelligentcodemail@gmail.com

Some status on RPI2: kernel is now booting with CONFIG_IPIPE (only) (at 
least passing the interrupt issue).

The part I was missing is the interrupt binding in 
arch_irq_handler_default().

I also used the system timer instead of the arm timer.
I am not sure the reason but I have the feeling it is because ipipe 
needs a oneshot timer.

I also got the rpi2 connected to a jtag and debugging using eclipse but 
it did not help much for this particular issue (and it is rather slow 
and not really stable).

There is a (major) issue: the mmc can not get the clock.
[    4.108224] mmc-bcm2835 3f300000.mmc: could not get clk

I am guessing this is due to the switch from ARM timer to system timer.
I will have to fix this eventually (any suggestion welcome).

The next step is to enable CONFIG_XENOMAI.

Thanks,
-- 
Mathieu

