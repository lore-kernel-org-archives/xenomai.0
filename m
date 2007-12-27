Message-ID: <2ff1a98a0712270725s7ba0b058wac469f2219566793@domain.hid>
Date: Thu, 27 Dec 2007 16:25:11 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4773C03C.9090207@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0712200643u797cfad2ve3848d88feda3bea@domain.hid>
	<18290.62470.714603.940223@domain.hid>
	<47739370.8000803@domain.hid>
	<2ff1a98a0712270505j6ecfa48dj36c673c0a40ca574@domain.hid>
	<4773C03C.9090207@domain.hid>
Subject: Re: [Xenomai-core] Auto closing of file descriptors and fork.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Dec 27, 2007 4:09 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> > On Dec 27, 2007 12:58 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> Gilles Chanteperdrix wrote:
> >>> Gilles Chanteperdrix wrote:
> >>>  > Hi,
> >>>  >
> >>>  > I have a problem with auto closing of file descriptors and fork. I
> >>>  > have an application (a modified pppd, to name it), which in a certain
> >>>  > mode (pppd "updetach" mode) opens some real-time file descriptors,
> >>>  > forks and exit the parent, continuing to use the file descriptors in
> >>>  > the child. The problem is that when exiting the parent, file
> >>>  > descriptors are automatically destroyed and therefore can not be used
> >>>  > in the child.
> >>>  >
> >>>  > Any ideas for a fix ?
> >>>
> >>> More precisely. We need to trap the "fork" event, and handle it in the
> >>> skins event callbacks. We will need to create a new ppd structure for
> >>> the new process, but what will we do with the skin objects ? If we keep
> >>> the same objects for the child and increment a reference count, we will
> >>> end up with an object that need to be inserted in two per-process
> >>> lists. If we create new objects, how will we manage for user-space
> >>> references (inherited accross fork) to remain valid ?
> >> The only way I see are process-private file descriptor tables +
> >> reference counters for the underlying objects. On fork, the descriptor
> >> table would be cloned and the reference counter of the contained object
> >> would be incremented, creating another reference to them. Or should we
> >> rather re-open those objects, creating another instance?
> >
> > That is essentially the two alternatives I propose.
> >
> > The problem when cloning the file descriptor table is that if there is
> > an xnholder_t (or something similar) in a file descriptor object, the
> > file descriptor can only be linked to one table.
>
> Hmm, where is there difference between this cloning and "normal"
> multi-threaded usage? The only difference I see is that there are now
> two separated address spaces from the user perspective. But for the
> kernel, it stays the same.

If there are two ppds, there are two lists (or hash table, or whatever
data structure). So, we now have an object, with only one xnholder_t
(or list_head) that must be in two lists. This does not work.

>
> >
> > The problem of re-opening the objects is that the user-space
> > references to the re-opened object should be updated. It is impossible
> > for a file descriptor.
>
> The only user space reference is the file descriptor - an index. And as
> this index stays the same across the fork, I don't see the problem.

The user-space file descriptor is __rtdm_fd_start + kernel-space file
descriptor. If you re-open an object, you will obtain a new
kernel-space file descriptor, and hence a different user-space file
descriptor. So, no, the index will not stay the same across the fork.

-- 
                                               Gilles Chanteperdrix

