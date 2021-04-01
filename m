MIME-Version: 1.0
References: <CAC-NLwzFEyQVeHUXHa6jYG9BesxaoA=1c4BHJiBRuKWhSB6Svg@mail.gmail.com>
In-Reply-To: <CAC-NLwzFEyQVeHUXHa6jYG9BesxaoA=1c4BHJiBRuKWhSB6Svg@mail.gmail.com>
From: ashwin damle <ashwindamle@gmail.com>
Date: Thu, 1 Apr 2021 23:39:36 +0530
Message-ID: <CAC-NLwzi7dQq22sWLXjHixqgy3=BFC750i_sZtQc4Z5-rAy+3Q@mail.gmail.com>
Subject: Re: How to use RTnet on xenomai3?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Support,

I was able to locate the drivers for rtnet (/lib/modules/uname
-r/kernel/drivers/xenomai/net/drivers) and rtnet.conf is located at
/usr/xenomai/etc. It did not require compiling RTnet separately.

I tried following steps mentioned at
https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet_Setup. The
non-realtime driver is e100 for my Ethernet controller. I followed the
steps and also loaded the rt_eepro100 hoping that is the real-time driver I
should use. The ethernet controller I have is Intel Corporation PRO/100 VE.

Output of sudo lspci -nn
*04:08.0 Ethernet controller [0200]: Intel Corporation PRO/100 VE Network
Connection [8086:1094] (rev 01)*

However, when I unload the e100 driver, loading the rt_eepro100 driver, and
configuring rtnet.conf as mentioned on the RTnet_Setup page, I could only
see the loopback.
from running sudo ../sbin/rtifconfig

rtlo      Medium: Local Loopback
          IP address: 127.0.0.1
          UP LOOPBACK RUNNING  MTU: 1500

There was a solution posted at
https://www.mail-archive.com/rtnet-users@lists.sourceforge.net/msg02766.html
is

diff --git a/drivers/rt_eepro100.c b/drivers/rt_eepro100.c
index 15282e4..c6a1c93 100644
--- a/drivers/rt_eepro100.c
+++ b/drivers/rt_eepro100.c
@@ -1975,6 +1975,7 @@ static struct pci_device_id eepro100_pci_tbl[]
__devinitdata = {
        { PCI_VENDOR_ID_INTEL, 0x103C, PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, 0x103D, PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, 0x103E, PCI_ANY_ID, PCI_ANY_ID, },
+       { PCI_VENDOR_ID_INTEL, 0x1092, PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, 0x1227, PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, 0x1228, PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, 0x2449, PCI_ANY_ID, PCI_ANY_ID, },
I seems to work for Breno, but I cannot understand what to do with it.

I am using Trisquel Linux kernel Linux gnu 4.19.89 with Xenomai 3.1.

I think I am close to running RTnet and would appreciate it if some
guidance is provided.

Ashwin Damle


On Mon, 29 Mar 2021 at 23:51, ashwin damle <ashwindamle@gmail.com> wrote:

>
> Dear Xenomai support,
>
> I am successfully able to run xenomai3.1 on 4.19.89 on my core-2-duo
> machine. Xenomai works nice. Further I want to use RTnet.
>
> From
> https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet#installation-folder-overview
> I learnt that RTNet is built into Xenomai 3 and so I need not download from
> the rtnet page and build it separately. If so then where do I start using
> RTNET? Is there any example? The folder mentioned at
> https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet_Setup do appear on
> my computer.
>
> From https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet_Setup I
> understand that /usr/local/rtnet/ is the directory where the RTNET files
> including documentation would be, but this folder is not created on my
> system. Therefore, I tried building RTNET from source using the
> instructions in the README: I get the error as below
>
> I request your help with an error.
> "checking for RT-extension... configure: error: *** RT-extended kernel not
> found in /lib/modules/4.19.89_xenomai/build
> makefile:51: recipe for target 'config.status' failed
> "
> I found that many have resolved the problems from by searching for the
> error and 5 pages direct to the same solution and that is
>
>  ./configure --with-linux=/path/to/linux-source-with-xenomai-extension
>  --with-rtext-config=/path/to/xeno-config
>
> My doubts are
>
> 1. Is it necessary to build RTNet from source or is it built in Xenomai 3?
> If it is built in then how do I use it. Some steps will be helpful.
>
> 2. If the RTNet is to be built from source then how to solve the above
> error. I pointed to the Linux source tree I used to build the xenomai
> kernel but it throws the same error.
>
> 3. What does " /path/to/linux-source-with-xenomai-extension mean the Linux
> source folder of Xenomai patched kernel? or does it mean
> "/lib/modules/uname-r/build"....None works for me. /path/to/xeno-config
> seems to be /usr/xenomai on my machine since xeno-config resides there.
>
> Please help with this. Let me know if you require any more information.
>
> --
> Ashwin Damle
>


-- 
Ashwin Damle
