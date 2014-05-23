MIME-Version: 1.0
From: Manu S Madhav <manusmad@gmail.com>
Date: Fri, 23 May 2014 17:43:51 -0400
Message-ID: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Troubleshooting Analogy DIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

I am running Ubuntu Precise (12.04) with kernel version 3.4.6 and
xenomai-2.6.2.1. I have a NI PCIe 6259 which I am trying to configure for
Digital I/O. Currently, the code itself is non-RT, I am trying first to
figure out how to do I/O as well as obtain counter / quadrature information
from my DAQ card.

Using Analogy, and with a bit of reading, I was able to get analog input
and output up and running without too much trouble, but digital I/O is
completely evading me. I am just trying to turn on all digital outputs to 1
using synchronous instruction to the DIO subdevice (#2, in my case). Size
of the subdevice is 4 (32 bits).

None of the following attempts worked. From the mailing list archives, I
found a suggestion to compile xenomai libs with --fno-omit-frame-pointer,
and that also didn't help. Any suggestions would be appreciated.


*First try (Using command-line insn_bits)*

********************
insn_bits -v -d analogy0 -s 2 0xffffffff 0xffffffff

insn_bits: device analogy0 opened (fd=0)
insn_bits: basic descriptor retrieved
     subdevices count = 14
     read subdevice index = 0
     write subdevice index = 0
insn_bits: complex descriptor retrieved
insn_bits: selected subdevice index = 2
insn_bits: mask = 0xffffffff
insn_bits: value = 0xffffffff
insn_bits: result = 0x0
********************

*Second try (Using a4l_sync_dio)*

********************
// dsc = is a4l_desc_t , previously configured
 int subd_DIO = 2;

uint32_t mask = 0xffffffff;
uint32_t buf = 0xffffffff;
a4l_sync_dio(&dsc, idx_subd_DIO, &mask, &buf);

********************

Again, even when I am getting a return of 0 (success), I am not measuring a
digital 1 at the physical pins.

*Third try (Using a4l_send_insn)*:

********************
// dsc = is a4l_desc_t , previously configured
int subd_DIO = 2;
unsigned char values[16];

    a4l_insn_t insn;
    insn.type = A4L_INSN_BITS;
    insn.idx_subd = idx_subd_DIO;
    insn.data = values;
    values[0] = 0xff;
    values[1] = 0xff;
    insn.data_size = 2 * sizeof(uint32_t);

    a4l_snd_insn(&dsc, &insn);

********************

Manu S Madhav
