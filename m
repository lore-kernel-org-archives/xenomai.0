MIME-Version: 1.0
From: George Broz <brozgeo@gmail.com>
Date: Mon, 7 Nov 2016 16:35:31 -0800
Message-ID: <CAMcKmiH8q2rW72dsyRLjm0SFGYTwgbPSMUbRcv=S+=3jMtHZow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] mapping peripherals through /dev/mem on xenomai/cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I'm running on an ARM SoC, Xenomai 3.0.3, Linux 3.18.20 and using
the Cobalt/POSIX interface in trying to port a legacy application
from Linux to Xenomai.

The legacy application uses "/dev/mem" from user space to access
peripheral memory. The usual calls:

fd = open("/dev/mem", O_RDWR);
mr = mmap(NULL, PAGE_SZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, devaddr);

work fine under Linux, but mmap returns EINVAL when the same
code is run under Cobalt.

If I use an RTDM (UDD mini-) driver, I can map the peripheral memory
that would otherwise return EINVAL when attempting to map it
through /dev/mem. (This then requires a device tree entry and
"up front" knowledge of the devices in the system.)

Conversely, if I use an address that is below the peripheral range
(i.e. within system memory as defined by the <memory> device tree
node) then the mapping succeeds under Cobalt.


My question:
Is there a way to mmap peripheral memory via /dev/mem under
Cobalt or is an RTDM driver required in this scenario?

Bonus question:
Where in the Xenomai codebase is the EINVAL determination
made in this (/dev/mem) case?


Thanks in advance for any insights!

--George Broz
Moog Industrial Group

