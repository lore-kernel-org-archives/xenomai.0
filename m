From: "Herrera-Bendezu, Luis" <lherrera@harris.com>
Date: Mon, 22 Oct 2012 19:51:46 +0000
Message-ID: <584FFDF8F96BB74593285A7D65886EC01EF7325D@ROCMXUS21.cs.myharris.net>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  Missed interrupt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello:

I am having an issue with RTDM interrupts at the kernel level. The system
used is as follows:
CPU: PowerPC 405EX
Linux: 2.6.30.3
I-Pipe: 2.7-02
Xenomai: 2.4.10
Configuration: config_file (attached)

There is a periodic interrupt at 16 mSec driven by an FPGA. This interrupt
is occasionally missed in what appears to be a case of disabled interrupt
for more than 40 mSec. This problem occurs mostly when flash memory is
written.

The RTDM driver registers non-shared IRQ using rtdm_irq_request()

I had searched Xenomai's mailing list and only found an instance were
interrupts are disabled in I-Pipe but for version Xenomai 2.6:
http://www.xenomai.org/pipermail/xenomai-help/2012-03/msg00119.html

Is there any known issue on version 2.4.10 related to interrupts and/or USB?
Any recommendations for narrowing the scope of this problem?

Thanks,
Luis


-------------- next part --------------
A non-text attachment was scrubbed...
Name: config_file
Type: application/octet-stream
Size: 44259 bytes
Desc: config_file
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121022/f00ebc1c/attachment.obj>
