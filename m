Message-ID: <49049480.20306@domain.hid>
Date: Sun, 26 Oct 2008 17:02:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200810242348.05336.niklaus.giger@domain.hid>
In-Reply-To: <200810242348.05336.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] solo/vxWorks: add rngLib (with testsuite)
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Niklaus Giger <niklaus.giger@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
> Hi
> 
> I just found the time to prepare a patch for a substitute for the vxWorks
> rngLib library I have written quite some time ago.
> 
> The remark from the vxWorks description applies here too
> "In particular, ring buffers by themselves provide no task synchronization or mutual exclusion."
> (http://www.slac.stanford.edu/exp/glast/flight/sw/vxdocs/vxworks/ref/rngLib.html)
> 
> Therefore this library is only good were there is exactly one writer an one reader
> envolved.
>

Fair enough, but we would have to pin all VxWorks tasks to the same CPU on SMP
systems; otherwise, out-of-order memory accesses would kill that code.

> It would be nice if it could find a place in the xenomai-solo. I am willing to
> address any criticism/nitpicking needed to get it into a good shape.
> 
> Best regards
> 
> Signed-off-by: Niklaus Giger <niklaus.giger@domain.hid>
> ---
>  include/vxworks/Makefile.am |    1 +
>  include/vxworks/Makefile.in |    1 +
>  vxworks/Makefile.am         |    2 +
>  vxworks/Makefile.in         |   18 ++++-
>  vxworks/rngLib.c            |  152 +++++++++++++++++++++++++++++++++++++++++++
>  vxworks/rngLib.h            |   34 ++++++++++


Something must be missing here. vxworks/rngLib.h should contain internal
definitions, used by the ring buffer implementation code, and that is correct in
your code. However, include/vxworks/rngLib.h should provide the interface to
applications; it seems we are missing such a file.

Since we don't want to export the innards of a ring buffer implementation to
applications, the interface header should only define the opaque ring buffer
handle type (i.e. typedef intptr_t RING_ID), and the RNG routine prototypes.

>  vxworks/testsuite/Makefile  |    2 +-
>  vxworks/testsuite/rng-1.c   |  118 +++++++++++++++++++++++++++++++++
>  8 files changed, 323 insertions(+), 5 deletions(-)
>  create mode 100644 vxworks/rngLib.c
>  create mode 100644 vxworks/rngLib.h
>  create mode 100644 vxworks/testsuite/rng-1.c
>


[snip]

 diff --git a/vxworks/rngLib.c b/vxworks/rngLib.c
> new file mode 100644
> index 0000000..d033db9
> --- /dev/null
> +++ b/vxworks/rngLib.c
> @@ -0,0 +1,152 @@
> +/*
> + * Copyright (C) 2008 Niklaus Giger <niklaus.giger@domain.hid>.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> +
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
> + */
> +
> +#include <stdlib.h>
> +#include <vxworks/errnoLib.h>
> +#include "rngLib.h"
> +
> +#define WIND_RING_MAGIC 0x5432affe
> +
> +RING_ID rngCreate(int nbytes)
> +{
> +	RING_DESCRIPTOR *ring;
> +	void *ring_mem;
> +
> +	if ( nbytes<=0) { errnoSet(S_memLib_NOT_ENOUGH_MEMORY); return 0; }

Please use the linux-c coding style, basically K&R + preposterously large indent
tabs (8 chars)

Emacs can be taught this way:

(defun linux-c-mode ()
  "C mode with adjusted defaults for use with Xenomai."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))

Indent will reformat almost properly with (-T should be used to teach indent
about the known non-standard types as well):

$ indent -npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1

> +	ring_mem = malloc( sizeof(RING_DESCRIPTOR*) + nbytes);

The sizeof() argument is wrong. Out-of-bound memory writes are knocking at the door.

Also, please use xnmalloc(). This call will pull memory from the allocator
selected at built time for the SOLO stack, either TLSF, or standard malloc().
--enable-malloc is false by default (i.e. TLSF enabled).

> +	if ( ring_mem == 0) { errno = errnoSet(S_memLib_NOT_ENOUGH_MEMORY); return 0; }
> +

Please compare pointers to NULL (and return null pointers the same way), that
gives a better hint about the pointerness of the data involved.

> +	ring = (RING_DESCRIPTOR *) ring_mem;

Cast is useless; let's remove visual clutter as much as we can. Actually,
ring_mem is useless as well; you could optimally work only using the ring
variable directly. Reducing the number of variable hops allows people to work
late at night with half a brain.

> +	ring->magic = WIND_RING_MAGIC;
> +	ring->bufSize = nbytes;
> +	ring->readPos = 0;
> +	ring->writePos = 0;

Nitpicking alert: line-feed please. It is visually easier to locate the main
return value.

> +	return (RING_ID) ring_mem;
> +}
> +
> +
> +void rngDelete(RING_ID ring_id)
> +{
> +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> +	if (ring->magic != WIND_RING_MAGIC) return;

K&R

> +	ring->magic = 0;
> +	free(ring);

xnfree() is the converse call for xnmalloc().

> +}
> +
> +
> +void rngFlush(RING_ID ring_id)
> +{
> +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> +	if (ring->magic != WIND_RING_MAGIC) return;
> +	ring->readPos = 0;
> +	ring->writePos = 0;
> +}
> +
> +
> +int rngBufGet(RING_ID ring_id,
> +	char *  buffer,
> +	int     maxbytes)
> +{
> +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> +	int j, bytesRead=0;
> +	unsigned int savedWritePos = ring->writePos;

linefeed please. Splitting declarations and pure executable statements makes it
easier for the eyes as well.

> +	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;

Mm, I guess VxWorks is not even checking there, right? If it does not, then I
would rather raise an assertion when a bad magic is detected, that would only
trigger with --enable-debug/--enable-assert.

> +	for (j=0; j < maxbytes; j++)
> +	{
> +		if ((ring->readPos) % (ring->bufSize + 1) == savedWritePos)

ring->readPos should never be out of bounds anyway. Do we actually need to
constrain the value to bufSize again?

> +		{

Single statement, save energy spent typing, no brace needed.

> +			break;
> +		}
> +		buffer[j] = ring->buffer[ring->readPos];
> +		++bytesRead;
> +		ring->readPos = (ring->readPos + 1) % (ring->bufSize + 1);
> +	}
> +	return bytesRead;
> +}
> +
> +
> +int rngBufPut(RING_ID ring_id,
> +	char *  buffer,
> +	int     nbytes)
> +{
> +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> +	int j, bytesWritten=0;
> +	unsigned int savedReadPos = ring->readPos;
> +	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
> +	for (j=0; j < nbytes; j++)
> +	{
> +		if ((ring->writePos + 1) % (ring->bufSize + 1) == savedReadPos)
> +		{
> +			break;
> +		}
> +		ring->buffer[ring->writePos] = buffer[j];
> +		++bytesWritten;
> +		ring->writePos = (ring->writePos + 1) % (ring->bufSize + 1);
> +	}
> +	return bytesWritten;
> +}

Same remarks as for rngBufGet().

More generally, I see off-by-one errors in both rngGet() and rngPut(), the way
they determine the next readable/writable byte index. In the following scenario
for instance, we would write two bytes to the ring buffer at indices #0 et #1,
albeit we only have space for a single character.

rngCreate(1);
rngPut(rng, buf, 1);
rngGet(rng, buf, 1);
rngPut(rng, buf, 1);

Dynamically maintaining a count of free bytes in the ring would allow easy
watermark checks in rngPut() and rngGet(), while providing a straigthforward
implementation for rngIsEmpy(), rngIsFull() and rngFreeBytes().

> +
> +
> +BOOL rngIsEmpty(RING_ID ring_id)
> +{
> +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> +	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
> +	return rngFreeBytes(ring_id) == (int) ring->bufSize;
> +}
> +
> +
> +BOOL rngIsFull(RING_ID ring_id)
> +{
> +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> +	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
> +	return rngFreeBytes(ring_id) == 0;
> +}
> +
> +
> +int rngFreeBytes(RING_ID ring_id)
> +{
> +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> +	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
> +	return ((ring->bufSize - (ring->writePos - ring->readPos)) % (ring->bufSize+1));
> +}
> +
> +
> +int rngNBytes(RING_ID ring_id)
> +{
> +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> +	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
> +	return ring->bufSize - rngFreeBytes(ring_id);
> +}
> +

Missing code in the following routines?

> +void rngPutAhead(RING_ID ring_id,
> +	char    byte,
> +	int     offset)
> +{
> +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> +	if (ring->magic != WIND_RING_MAGIC) return;
> +	return;
> +}
> +
> +
> +void rngMoveAhead(RING_ID ring_id,
> +	int     n)
> +{
> +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> +	if (ring->magic != WIND_RING_MAGIC) return;
> +	return;
> +}
> diff --git a/vxworks/rngLib.h b/vxworks/rngLib.h
> new file mode 100644
> index 0000000..d646614
> --- /dev/null
> +++ b/vxworks/rngLib.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright (C) 2008 Philippe Gerum <rpm@xenomai.org>.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> +
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
> + */
> +
> +#ifndef _VXWORKS_RNGLIB_H
> +#define _VXWORKS_RNGLIB_H
> +
> +#include <xenomai/syncobj.h>
> +#include <xenomai/heapobj.h>
> +#include <vxworks/rngLib.h>
> +
> +typedef struct  {
> +	unsigned int magic;
> +	unsigned int bufSize;
> +	unsigned int readPos;
> +	unsigned int writePos;
> +	char buffer[];
> +} RING_DESCRIPTOR ;
> +

-- 
Philippe.

