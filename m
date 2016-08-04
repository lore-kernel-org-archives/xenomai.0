From: Alex Plits <alex_plits@radwin.com>
Date: Thu, 4 Aug 2016 06:12:11 +0000
Message-ID: <AM4PR0601MB2162E2F39CB8D4BD792D2DD88F070@AM4PR0601MB2162.eurprd06.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Page fault on io mapping resulting secondary mode switches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

We wanted to share an issue we were having with the following setup and it'=
s solution
Kernel 3.14.43 (Vendor)
Xenomai 3.0.2
Cobalt core.
ARM cortex A7 (SMP) based board.

We have mapped (in numerous ways/APIs) a register space of some device to u=
ser space using various methods
For IO mapping -
mmap
rtdm_iomap_to_user
rtdm_mmap_iomem
etc.

And for unknown at the time reason we have seen page faults on writes to th=
ese mapping which resulted
In mode switches no matter what method of mapping APIs we used. It is impor=
tant to note that mapping the same registrer space in Kernel
i.e. devm_ioremap_resource for example did not result in page faults.

After some investigation we found this had to do with the actual mapping pe=
rmissions being read-only on initial mapping to user space and after the pa=
ge fault handling - each faulted page changed permission to read-write.

The solution to for this was to add L_PTE_DIRTY mask to pgprot for that map=
ping and in retrospect we found this patch
https://lkml.org/lkml/2015/9/12/29
which addressed the issue.

I'm unsure whether this patch found its way to 3.14, I think for Xenomai on=
 ARM this can be very relevant so please consider adding to the mapping flo=
w.

Thanks,
Alex Plits.



