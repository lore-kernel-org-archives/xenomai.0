Message-ID: <4B95532E.1060409@domain.hid>
Date: Mon, 08 Mar 2010 14:42:38 -0500
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070002020908030209020308"
Subject: [Xenomai-help] BUG: Bad page map
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------070002020908030209020308
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I'm beginning to write an RTDM driver for a custom PCI
device.  The plan is to map the device registers into
user space, and deal with all the details in a Xenomai
process.  However, I ran into crashes trying to access
the device's memory from user space (via mmap in the RTDM
driver).

So I decided to try a simple (non Xenomai) user-space
program to display random physical memory addresses via
a direct mmap of /dev/mem.  Thus, the IPIPE and Xenomai
code is still in the kernel, but it is unused.  This
simple program crashes too - copy of the program attached.

The thing that has me confused is that the simple mmap
program works on a PPC440EPx, (and on an Intel desktop)
but fails on a PPC405EX, with the error message:

BUG: Bad page map in process mm  pte:00000452 pmd:0f70c400

page:c03fe000 flags:00000404 count:1 mapcount:-1 mapping:(null) index:0
addr:4801f000 vm_flags:400844fb anon_vma:(null) mapping:cf7c15c8 index:0
vma->vm_ops->fault: 0x0
vma->vm_file->f_op->mmap: mmap_mem+0x0/0xa4
Call Trace:
[ceed1d90] [c0006d8c] show_stack+0x44/0x16c (unreliable)
[ceed1dd0] [c00a21d8] print_bad_pte+0x140/0x1cc
[ceed1e00] [c00a31d4] unmap_vmas+0x41c/0x594
[ceed1e80] [c00a7688] exit_mmap+0xb8/0x150
[ceed1ea0] [c0022158] mmput+0x50/0x11c
[ceed1eb0] [c00260d8] exit_mm+0xec/0x10c
[ceed1ee0] [c00277b4] do_exit+0xb0/0x5fc
[ceed1f20] [c0027d44] do_group_exit+0x44/0xac
[ceed1f30] [c0027dc0] sys_exit_group+0x14/0x28
[ceed1f40] [c000ff04] ret_from_syscall+0x0/0x3c
Disabling lock debugging due to kernel taint
BUG: Bad page state in process mm  pfn:00000
page:c03fe000 flags:00000404 count:0 mapcount:-1 mapping:(null) index:0
Call Trace:
[ceed1d80] [c0006d8c] show_stack+0x44/0x16c (unreliable)
[ceed1dc0] [c0092c00] bad_page+0x94/0x12c
[ceed1de0] [c0097afc] put_page+0x50/0x190
[ceed1df0] [c00aec0c] free_page_and_swap_cache+0x34/0x8c
[ceed1e00] [c00a3024] unmap_vmas+0x26c/0x594
[ceed1e80] [c00a7688] exit_mmap+0xb8/0x150
[ceed1ea0] [c0022158] mmput+0x50/0x11c
[ceed1eb0] [c00260d8] exit_mm+0xec/0x10c
[ceed1ee0] [c00277b4] do_exit+0xb0/0x5fc
[ceed1f20] [c0027d44] do_group_exit+0x44/0xac
[ceed1f30] [c0027dc0] sys_exit_group+0x14/0x28
[ceed1f40] [c000ff04] ret_from_syscall+0x0/0x3c

On both the PPC440EPx and the PPC405EX, the kernel version is
2.6.30.3, the IPIPE version is 2.7-02, and the Xenomai version
is 2.4.10.

I'm going to try rebuilding the kernel without IPIPE/Xenomai,
to try to isolate the problem.  The purpose of this email is
to ask for help interpreting the crash dump.  Any suggestions
would be appreciated!

The PPC405EX board (AMCC Kilauea) otherwise appears stable, BTW.

	Thanks,
	Steve

--------------070002020908030209020308
Content-Type: text/x-csrc;
 name="mm2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm2.c"

#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>

#include <fcntl.h>
#include <string.h>
#include <unistd.h>

#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>

#define MAP_SIZE			4096UL
#define MAP_MASK 			(MAP_SIZE - 1)

#define DEV_MEM				"/dev/mem"

static unsigned long			addr = 0;
static unsigned long			len = 0x10;

int main()
{
    int			ii;
    int			fd;
    unsigned long	paddr = 0;
    unsigned long	offset;
    unsigned long	*map_lbase;

    if(getpagesize() != MAP_SIZE) {
	fprintf(stderr, "Incorrect page size\n");
	exit(1);
    }

    if((fd = open(DEV_MEM, O_RDWR | O_SYNC)) == -1) {
	fprintf(stderr, "cannot open %s - are you root?\n", DEV_MEM);
	exit(1);
    }

    // Calculate the page number, and the offset within the page.
    paddr  = addr & ~MAP_MASK;
    offset = addr &  MAP_MASK;

    // Map that page.
    map_lbase = (unsigned long *)mmap(NULL, MAP_SIZE,
	    PROT_READ | PROT_WRITE, MAP_SHARED, fd, paddr);
    if((long)map_lbase == -1) {
	perror("cannot mmap");
	exit(1);
    }

    // Get a pointer to the offset within the page.
    map_lbase += offset / 4;

    // Dump the requested bytes.
    for(ii = 0; ii < len; ii++) {
	if(ii % 4 == 0) {
	    printf("%08lx: ", addr + (ii * sizeof(unsigned long)));
	}
	printf("%08lx ", map_lbase[ii]);
	if(ii % 4 == 3) {
	    printf("\n");
	}
    }
    if((ii % 4) != 0) {
	printf("\n");
    }

    exit(0);
}

/*
 * Local Variables:
 *   mode: c
 *   tab-width: 8
 *   c-basic-offset: 4
 *   indent-tabs-mode: t
 * End:
 *
 * vim:ts=8:sw=4:sts=4
 */

--------------070002020908030209020308--

