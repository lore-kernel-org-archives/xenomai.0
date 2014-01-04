MIME-Version: 1.0
Date: Fri, 3 Jan 2014 16:48:11 -0800
Message-ID: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
From: Nima Nourozi <n.nourozi@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm writing an SPI device driver using rtdm skin. If I call rtdm_task_init
from anywhere in the code the system freezes indefinitely with no errors
thrown.

Here is how I call the function in __init function of my module:
retval =3D rtdm_task_init(&heartbeat_task, "spi_transfer", xx_start_transfe=
r,
NULL, 99, 100000000);

I'm using xenomai 2.6.1 patched with
adeos-ipipe-2.6.38.8-arm-1.18-09.patch<http://download.gna.org/adeos/patche=
s/v2.6/arm/adeos-ipipe-2.6.38.8-arm-1.18-09.patch>
Linux 2.6.38.8 and my compiler is Sourcery G++ Lite 2010q1-202

The rtdm_timer_start function works perfectly so the problem is only with
the task function.

I've been trying different kernel versions but I get the same result.

I'm attaching the .config file in case there is a setting that's causing
this issue.

Thanks in advance,

Nima
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config
Type: application/octet-stream
Size: 36797 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140103/ef5b53d=
0/attachment.obj>
