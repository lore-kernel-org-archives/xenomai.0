From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Sun, 31 Aug 2008 23:23:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808312323.29665.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] skin RTDM in user mode
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

In ksrc/skins/rtdm/API.CHANGES text file, the TODO list indicates that someone 
may be working on the development of the user-side RTDM skin (for user-space 
drivers).

Is anyone working on that ?

I was wondering what was to be done:

- Is it just the porting of the kernel RTDM API (rtdm_task_*, etc.) ?
- Or do you expect a more complete solution like fuse or fusd ? 

The last few weeks, I was thinking on a complete solution which would allow to 
compile and execute an RTDM driver seamlessly on both mode (user and kernel).

That would imply:
- the porting of the kernel RTDM API on user mode;
- the development of a specific layer so as to redirect the RTDM syscalls 
(open, read, write, close, ioctl) to a user-space process. For that point, I 
think there are two alternatives: either extending the RTDM skin API (with 
hidden syscalls for the user-space driver to retrieve the syscalls to 
execute) or developing a kernel RTDM driver + a library.
- the development of an external library (or header) to implement the minimal 
Linux API which is used in common RTDM drivers (like vmalloc, kmalloc, 
ioremap). (And for PCI, USB, DMA, etc. API, ???)

Compared to fuse or fusd, which I consider as user-specific frameworks. The 
main advantage of such a solution would be the ability to (nearly) seamlessly 
execute the driver on both spaces. The main issue would be to keep in mind 
the performance aspect (especially for rtdm_copy_*_user, on that point there 
are many possibilities I began to investigate).

Do you consider such a work as interesting ?

Alexis.


