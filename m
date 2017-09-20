Date: Wed, 20 Sep 2017 10:40:47 +0200
From: Gwenhael Goavec-Merou <gwenj@trabucayre.com>
Message-ID: <20170920104047.52e779c4@x230.trabucayre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] gpio irq problem on Zynq
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

I use a Zynq with the latest Xenomai/Ipipe version and I've problems
when using GPIO interrupts. Currently, my tests are only in the Linux
domain.

1/ When using gpiolib the system freeze after gpio's configuration
through /sys/class/gpio/xxx . I suspect the corresponding IRQ
not masked or not acquitted.
2/ With a driver the ISR is never called but the system is not freezed.

I've looked on gpio-zynq.c but I've no idea about the reason why the
system has these wrong behaviour.

Thank you for all comment/advises about my issue.

Gwenhael Goavec-Merou

