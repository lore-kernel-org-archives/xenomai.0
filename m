References: <1488597983336.36220@kth.se>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3054c0cd-84f5-54db-a775-a339a666d639@xenomai.org>
Date: Sun, 5 Mar 2017 16:51:23 +0100
MIME-Version: 1.0
In-Reply-To: <1488597983336.36220@kth.se>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency test fails after in a Xenomai patched Ostro
 XT linux distro
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nitin Kulkarni <nitink@kth.se>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/04/2017 04:26 AM, Nitin Kulkarni wrote:
> Hi,
> 
> I have patched the Xenomai 3.0.3 to an Ostro XT linux distribution and after flashing the image and booting on the Intel Joule board I installed the Xenomai libraries natively. When I run the Latency test it gives this message and stops.
> 
> 
> root@intel-corei7-64:~/Xenlib# /usr/xenomai/bin/latency
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> /usr/xenomai/bin/latency: pthread_create(latency): Operation not permitted
> 
> Although I am running as a root user it gives this error. I have not added any user group through the Kernel command line parameter xenomai.allowed_group?.
> when I run the command
> 
> dmesg | grep -i xenomai
> 
> 
> I get this from the Kernel log
> [    0.000000] Command line: rootwait console=tty0 xenomai.sysheap_size=256 xenomai.state=enabled xenomai.smi=detect xenomai.smi_mask=1 console=ttyS2,115200 video=efifb maxcpus=4 noxsave reboot=efi kmemleak=off fsck.mode=skip no-ima ro root=PARTUUID=12345678-9abc-def0-0fed-cba987654321 rootfstype=ext4 installer
> [    0.000000] Kernel command line: rootwait console=tty0 xenomai.sysheap_size=256 xenomai.state=enabled xenomai.smi=detect xenomai.smi_mask=1 console=ttyS2,115200 video=efifb maxcpus=4 noxsave reboot=efi kmemleak=off fsck.mode=skip no-ima ro root=PARTUUID=12345678-9abc-def0-0fed-cba987654321 rootfstype=ext4 installer
> [    0.668993] [Xenomai] scheduling class idle registered.
> [    0.669456] [Xenomai] scheduling class rt registered.
> [    0.670016] I-pipe: head domain Xenomai registered.
> [    0.672804] [Xenomai] Cobalt v3.0.3 (Groovy Cosmic Halo)

v3.0.3 is outdated, with nasty issues. You should use the latest stable
code from: git://git.xenomai.org/xenomai-3.git, branch stable-3.0.x

> 
> ?
> Please let me know how to handle this issue.

Any message visible in the kernel log after enabling
CONFIG_XENO_OPT_DEBUG_COBALT?

-- 
Philippe.

