Message-ID: <51665AD4.7030503@xenomai.org>
Date: Thu, 11 Apr 2013 08:40:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <FD5EBA50-E222-4012-A755-A20FF5D5971D@mah.priv.at>	<5165E85B.2040609@xenomai.org>	<E9BAB42D-B8E9-4E23-8A15-934A72AC7823@mah.priv.at>
	<51660709.3010809@xenomai.org>
In-Reply-To: <51660709.3010809@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] shared memory compatibility - advice sought
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 04/11/2013 02:42 AM, Gilles Chanteperdrix wrote:

> Let us talk concretely. If I assume you want to share the same piece of
> memory in all the cases (which I originally did not). You would have a
> common kernel module able to allocate a piece of memory and associate it
> with an identifier (a string, ala shm_open/sem_open, for instance).
> 
> Then an rtdm module, with an ioctl allowing to retrieve that piece of
> memory or allocate it given the id, and if called from user-space use
> rtdm_mmap_to_user to put it in the process adress-space, if called from
> kernel-space, return the memory directly. The same RTDM code can be
> compiled both for RTAI and Xenomai and covers 4 cases. And RTDM drivers
> can be called as well from kernel space as from user-space, if I
> remember correctly.
> 
> Then another linux module, with an ioctl and an mmap call allowing to
> retrieve the same piece of memory with the same ID and map it in the
> process user-space.


That is still way too complicated. The only thing you need is a plain
Linux character device driver, with an ioctl and mmap method allowing to
map so kernel memory in user-space, and a kernel-space API giving access
to the kernel memory.

The kernel API would be used in the module initialization/cleanup
routines of your kernel mode applications. The user API would be used by
the non real-time part initialization of user applications in any mode.

As a starting point, you can have a look at the "linux device drivers"
book examples.

-- 
                                                                Gilles.

