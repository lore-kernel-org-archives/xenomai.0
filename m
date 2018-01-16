MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 16 Jan 2018 17:42:16 +0530
Message-ID: <CAOuPNLgu+U_TkT8XgCLF70JVQmrEqug380LqY3FX=yqPCC_X2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] [RTnet] - rtnet module installation issue using rtnet.conf
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@web.de, Pintu Kumar <pintu.ping@gmail.com>

Hi,

I have brought up Xenomai 3.0.6 (dual kernel, cobalt) on a
Ubuntu-32-bit machine with Linux Kernel version 4.9.62.
# cat /proc/xenomai/version
3.0.6

# uname -a
Linux osboxes 4.9.62-pintu-xeno-3.0.6+ #4 SMP Wed Jan 3 18:54:46 IST
2018 i686 i686 i686 GNU/Linux

My Xenomai libraries are installed under:
# ls /usr/xenomai/
bin/     demo/    etc/     include/ lib/     sbin/


I have verified with sample posix and native application and the
xenomai is working fine.

-------------------------
Next, I wanted to check rtdm driver such as RTnet.
So, I noticed that RTNET module needs to be enabled in my patched kernel 4.9.62.
So, I enabled it and installed the modules successfully.

I also see that the modules are installed under:
# ls /lib/modules/4.9.62-pintu-xeno-3.0.6+/kernel/drivers/xenomai/net/drivers/
e1000/          rt_8139too.ko   rt_eepro100.ko  rt_loopback.ko

# ls /lib/modules/4.9.62-pintu-xeno-3.0.6+/kernel/drivers/xenomai/net/stack/
ipv4/     packet/   rtcfg/    rtmac/    rtnet.ko


So, after that, when I try to install the rtnet driver, I get the
following error:
# sudo /usr/xenomai/sbin/rtnet -v start
Turning on verbose mode
modprobe: FATAL: Module rttcp not found in directory
/lib/modules/4.9.62-pintu-xeno-3.0.6+


When, I check the config file, the RTNET module path is listed as:
RTNET_MOD="/lib/modules/`uname -r`/kernel/drivers/xenomai/net"


I tried changing it to the correct path by adding xenomai/net/drivers
or xenomai/net/stack, but still I get the same error.


Please let me know how to correctly install the RTNET driver using the
/usr/xenomai/sbin/rtnet scripts.



Thanks,
Pintu

