From: Johannes Holtz <johannes.holtz@compador.de>
Subject: EAFNOSUPPORT despite kernel build in
Message-ID: <c84647b1-bdc6-87f3-2f56-3d9e1b3264b6@compador.de>
Date: Tue, 4 Dec 2018 12:04:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

When I request a socket with AF_RTIPC I get an EAFNOSUPPORT in return.
int sock = socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_IDDP);

rtipc.h is included
#include <rtdm/rtipc.h>

I have build the support for RTIPC into the kernel (not a module) and
expected this to work more or less out of the box. Did I forget something
or must this feature be a module?
I have searched for a solution but haven't found anything.

Here information about the system:

virtual machine (VBox) with 1 CPU,  2.5GB RAM, 15GB disk

base kernel version is 3.18.20

xenomai  version is 2.6.5 (from the download page not from the git repo)

using the included ipipe patch
xenomai-2.6.5/ksrc/arch/x86/patches/ipipe-core-3.18.20-x86-7.patch

the kernel config has the feature enabled
root@xeno:~/kernelbuild# grep RTIPC /boot/config-3.18.20
CONFIG_XENO_DRIVERS_RTIPC=y
CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
CONFIG_XENO_DRIVERS_RTIPC_BUFP=y



