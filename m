Message-ID: <4B955D71.5050306@domain.hid>
Date: Mon, 08 Mar 2010 15:26:25 -0500
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <4B95532E.1060409@domain.hid>
In-Reply-To: <4B95532E.1060409@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] BUG: Bad page map
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

Steven A. Falco wrote:
> I'm beginning to write an RTDM driver for a custom PCI
> device.  The plan is to map the device registers into
> user space, and deal with all the details in a Xenomai
> process.  However, I ran into crashes trying to access
> the device's memory from user space (via mmap in the RTDM
> driver).

Turns out to behave the same without IPIPE/Xenomai.  I'll
repost on the ppc dev list.

	Steve

> 
> So I decided to try a simple (non Xenomai) user-space
> program to display random physical memory addresses via
> a direct mmap of /dev/mem.  Thus, the IPIPE and Xenomai
> code is still in the kernel, but it is unused.  This
> simple program crashes too - copy of the program attached.
> 
> The thing that has me confused is that the simple mmap
> program works on a PPC440EPx, (and on an Intel desktop)
> but fails on a PPC405EX, with the error message:
> 
> BUG: Bad page map in process mm  pte:00000452 pmd:0f70c400
> 
> page:c03fe000 flags:00000404 count:1 mapcount:-1 mapping:(null) index:0
> addr:4801f000 vm_flags:400844fb anon_vma:(null) mapping:cf7c15c8 index:0
> vma->vm_ops->fault: 0x0
> vma->vm_file->f_op->mmap: mmap_mem+0x0/0xa4
> Call Trace:
> [ceed1d90] [c0006d8c] show_stack+0x44/0x16c (unreliable)
> [ceed1dd0] [c00a21d8] print_bad_pte+0x140/0x1cc
> [ceed1e00] [c00a31d4] unmap_vmas+0x41c/0x594
> [ceed1e80] [c00a7688] exit_mmap+0xb8/0x150
> [ceed1ea0] [c0022158] mmput+0x50/0x11c
> [ceed1eb0] [c00260d8] exit_mm+0xec/0x10c
> [ceed1ee0] [c00277b4] do_exit+0xb0/0x5fc
> [ceed1f20] [c0027d44] do_group_exit+0x44/0xac
> [ceed1f30] [c0027dc0] sys_exit_group+0x14/0x28
> [ceed1f40] [c000ff04] ret_from_syscall+0x0/0x3c
> Disabling lock debugging due to kernel taint
> BUG: Bad page state in process mm  pfn:00000
> page:c03fe000 flags:00000404 count:0 mapcount:-1 mapping:(null) index:0
> Call Trace:
> [ceed1d80] [c0006d8c] show_stack+0x44/0x16c (unreliable)
> [ceed1dc0] [c0092c00] bad_page+0x94/0x12c
> [ceed1de0] [c0097afc] put_page+0x50/0x190
> [ceed1df0] [c00aec0c] free_page_and_swap_cache+0x34/0x8c
> [ceed1e00] [c00a3024] unmap_vmas+0x26c/0x594
> [ceed1e80] [c00a7688] exit_mmap+0xb8/0x150
> [ceed1ea0] [c0022158] mmput+0x50/0x11c
> [ceed1eb0] [c00260d8] exit_mm+0xec/0x10c
> [ceed1ee0] [c00277b4] do_exit+0xb0/0x5fc
> [ceed1f20] [c0027d44] do_group_exit+0x44/0xac
> [ceed1f30] [c0027dc0] sys_exit_group+0x14/0x28
> [ceed1f40] [c000ff04] ret_from_syscall+0x0/0x3c
> 
> On both the PPC440EPx and the PPC405EX, the kernel version is
> 2.6.30.3, the IPIPE version is 2.7-02, and the Xenomai version
> is 2.4.10.
> 
> I'm going to try rebuilding the kernel without IPIPE/Xenomai,
> to try to isolate the problem.  The purpose of this email is
> to ask for help interpreting the crash dump.  Any suggestions
> would be appreciated!
> 
> The PPC405EX board (AMCC Kilauea) otherwise appears stable, BTW.
> 
> 	Thanks,
> 	Steve
> 


