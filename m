Message-ID: <5262C351.8010704@xenomai.org>
Date: Sat, 19 Oct 2013 19:37:21 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>
In-Reply-To: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0 of 3] Xenomai-forge: Initial implementation
 of registry for pSOS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>, xenomai@xenomai.org

On 10/15/2013 10:50 AM, Kim De Mey wrote:
> This patch set adds an initial implementation of registry for pSOS
> tasks, semaphores and queues. It is similar as the already existing
> vxworks implementation but with more output data.
>
> Important to mention is that the "size" parameter in the read function
> is not used (it is also not used in the vxworks implementation).
> This will be an issue if the data to output is larger than the buffer
> used. This is now possible to happen as I added messages in the queue
> read function and timers in the task read function. In that case an
> implementation which uses size & offset is necessary.
>
> I am busy implementing a second patch that does this.
> It creates a local buffer which is filled with the data on an "open"
> call. A pointer to the local buffer is saved in the fuse_file_info->fh
> field (requires FUSE version >=  2.5). A read will then just read from
> the local buffer with offset and size given. A release is also needed to
> free the buffer.
>
> However while I continue with this I would like to know whether you see
> this as the right way to go.

IIUC, this would add the quite unexpected requirement of having to 
reopen a file for getting fresh data. read() should actually (re-)read 
the current object state each time it is invoked, and not resend some 
frozen state collected by the corresponding open() indefinitely.

e.g. this has to work with code like:

	fd = open("/mnt/xenomai/1235/foo/tasks", O_RDONLY);
	for (;;) {
		ret = read(fd, buf, sizeof(buf));
		... process NEW data ...
	}

As I mentioned earlier, referring to fuse_file_info->fh from a registry 
client is not acceptable. Exposing this fs-private information to the 
clients directly (e.g. psos emulator) would prevent any further use by 
copperplate/registry although it's actually the fs implementation layer 
(not psos). So the day we'd need to store private data for the registry 
fs, we could not use fh, although this is what we should definitely be 
using in this case.

If you really need to provide for holding private data in a fuse _file_ 
object, instead of a copperplate _filesystem_ object (i.e. struct 
fsobj), then the fuse file object should be abstracted first in 
copperplate/registry (e.g. struct fileobj), then passed as an additional 
parameter to all client callbacks. That file (descriptor) object could 
then hold a client-specific private data pointer. In short, this change 
should be introduced in the generic registry layer, not in the psos 
emulator.

The question being: do you really need this?

-- 
Philippe.

