Message-ID: <5064967E.3040501@xenomai.org>
Date: Thu, 27 Sep 2012 20:10:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5060AFD1.30303@gmail.com>
	<506373F6.80406@xenomai.org>	<5063E8DE.8010303@gmail.com>
	<50640444.8010703@xenomai.org> <50647502.9020204@gmail.com>
In-Reply-To: <50647502.9020204@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel 2.6.37.6 + Xenomai 2.5.6 is ok,
 but with Xenomai 2.6.1 it won't boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jari Lietzen <jari.lietzen@gmail.com>
Cc: xenomai@xenomai.org

On 09/27/2012 05:47 PM, Jari Lietzen wrote:

> This is a snippet from dmesg:
> 
> [    0.443563] Xenomai: hal/x86_64 started.
> [    0.443583] Xenomai: scheduling class idle registered.
> [    0.443585] Xenomai: scheduling class rt registered.
> [    0.444338] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
> [    0.444478] Xenomai: SMI-enabled chipset found, but SMI workaround 
> disabled
> [    0.444480]          (check CONFIG_XENO_HW_SMI_WORKAROUND). You may 
> encounter
> [    0.444481]          high interrupt latencies!
> [    0.444501] Xenomai: starting native API services.
> [    0.444503] Xenomai: starting POSIX services.
> [    0.444542] Xenomai: starting RTDM services.
> 
> 
> Then running /usr/xenomai/bin/xeno-test says:
> 
> Started child 1755: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper 
> /usr/xenomai/bin/xeno-test
> ++ echo 0
> ++ /usr/xenomai/bin/arith
> Xenomai: incompatible ABI revision level
> (user-space requires '4', kernel provides '3').


So, the kernel is booting, this is a different issue:
http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_xenomai_incompatible_abi_revision_level

> I could go on with Xenomai 2.5.6, and that's what I'm using right now. 
> But I'd like to bring my environment up to date. The reason I'm using 
> kernel 2.6.37.6 is that my applications are build on top of IgH EtherCAT 
> Master http://www.etherlab.org/en/ethercat/index.php and the kernel 
> version just comes from there.


You have a bug when updating both Xenomai and I-pipe patch, the test 
you made simply proved us that the bug is introduced by the commits 
between the 2.9-00 patch and 2.9-02 in the I-pipe tree and not by the 
Xenomai update. So, in order to find the bug, the best solution is to 
run a git bisect using the I-pipe git:

git://git.denx.de/ipipe.git
branch ipipe-2.6.37-x86

Regards.

-- 
                                                                Gilles.

