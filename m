From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 0/4] i.MX serial driver fixes
Date: Fri, 29 Mar 2019 18:40:59 +0100
Message-Id: <20190329174103.8158-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Another set of changes for the i.MX serial driver, addressing some
issues observed here.

Patch #1 updates the init and configuration code to align with
mainline; it also fixes random lockups caused by the reset probe loop
spinning indefinitely. This was specifically observed when re-opening
the device for multiple runs (first run was generally ok).

Patch #2 is a must-have, the Cobalt interface requires it.

Tested on i.MX6Q. Patch #1 needs further testing by other parties to
make sure it does not introduce regression(s).

Philippe Gerum (4):
  drivers/serial: imx: robustify device setup/cleanup
  drivers/serial: always propagate -EINTR downstream
  drivers/serial: imx: simplify RX loop
  drivers/serial: imx: dismiss noisy IRQ events

 kernel/drivers/serial/rt_imx_uart.c | 130 ++++++++++++++++++----------
 1 file changed, 82 insertions(+), 48 deletions(-)

-- 
2.20.1


