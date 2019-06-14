Message-ID: <a4aa24290a89f22416023b74362d88d25c7a005b.camel@sprinte.eu>
Subject: serial driver for imx28
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Fri, 14 Jun 2019 13:53:42 +0200
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi,

We’re currently trying to make the serial port working on a custom
board based on an imx28 som.

The serial port is correctly handled by the linux mxs-uart driver.
However, under (slightly) heavy xenomai loads, we experience data loss
(we suspect xenomai is delaying interrupts for too long for the linux
kernel to handle them, resulting in the data loss).

To fix this issue, we’re trying to migrate from the linux non-rt driver
to the xenomai rt_imx_uart driver (other suggestions welcome).

Our kernel is 4.9.24, and xenomai is 3.0.5. An upgrade to 3.0.7 fixes
the compilation issue.

However, we can't manage to make this driver recognize the uart, nor to
find any documentation / pointers on how to configure it for our needs.

So, the questions are :
- is the imx28 supported ?
- are there any pointers / samples as to how to configure it (correct
address / irq, etc.).

Regards,

Julien


