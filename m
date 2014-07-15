From: Jan Jaap Kempenaar <janjaapkempenaar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEB36BE3-3DA6-4594-9064-213B66B059ED@gmail.com>
Date: Tue, 15 Jul 2014 17:45:34 +0200
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: [Xenomai] modprobe cannot find RTDM kernel module during boot
	sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

We have a setup for controlling robots consisting of a Gumstix Overo =
Fire and an FPGA. These devices are connected using a GPMC.
In order be able to exchange data with the FPGA we wrote a small kernel =
module according to the RTDM, this kernel modules compiles and functions =
as expected. However loading the module is a problem:

We copied the module to:
/lib/modules/3.2.21/kernel/drivers/gpmc/rt_gpmc_module.ko
Then as root performed:
depmod -a

After these two actions we are able to load the module using:
modprobe rt_gpmc_module

Also:
modprobe --list
will list the .ko file.

Now for ease of use, we want to load the particular kernel module at =
boot. To achieve this we added rt_gpmc_module to the /etc/modules file.
However when setting the /etc/init.d/module-init-tools to Verbose, the =
modprobe command gives the following error:
FATAL: Module rt_gpmc_module not found

Adding modprobe --list in front, shows that rt_gpmc_module.ko is in the =
mod probe listing.

In order to verify that nothing is wrong with the kernel module boot =
loading, a version was created as a "normal" none RTDM driver. This =
module loads at boot as it should.

This brings me to the question, how can one load a RTDM kernel module =
driver at boot time, using the /etc/modules feature?
Or does it require a different approach.

Any advice is much appreciated.

System:
Xenomai 2.6.3
Linux 3.2.21
Gumstix Overo Fire
Custom FPGA base board.=

