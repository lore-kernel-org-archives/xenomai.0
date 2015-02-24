Date: Tue, 24 Feb 2015 14:29:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150224132911.GA14148@hermes.click-hack.org>
References: <9BA84827B30CBE4996725F98F7DC912342902FDB@SMExchange01.siebmeyer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342902FDB@SMExchange01.siebmeyer.org>
Subject: Re: [Xenomai] rt_heap_bind, Error=-11 -> EWOULDBLOCK why?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Feb 24, 2015 at 01:08:00PM +0000, Hänel-Baas, Alexander wrote:
> Hi,
> 
> Wrong email address and I understand your reply not correctly you are right -> sorry.
> 
> Ok, so now I changed the flags to H_SINGLE | H_SHARED | H_DMA | H_NONCACHED. (it is possible? DMA + NONCACHED)

Sure, on architectures without snooping, using cached mapping means
you have to manually invalidate the cache after a DMA transfer to
the mapping (or flush it before a DMA transfer from the mapping).
With uncached mappings, you do not have this problem.

> 
> By the way, we have 3 shm areas:
> 2 of them was created from the user space application with the flags: H_SINGLE | H_SHARED | H_NONCACHED
> 1 of them created from the kernel driver with : H_SINGLE | H_SHARED | H_DMA (contiguous memory for dma)
> 
> I spend my time to check the situation, here my notice:
> 
> ------
> FLAGS: H_SINGLE | H_SHARED | H_DMA
> shmMu_initialize: Open or create SHM "SLINK4" with 256 bytes header and 36864 bytes data.
> createNewHeap: FLAGS_: 0x0700
> createNewHeap: Heap SLINK4 (Id = 0x9f0f05c6, size=37120, flags=0x00000700, address: f57f0c00) successfully created.
> allocateHeap: +RTAPI+ rt_heap_alloc( shm = "SLINK4" ) success. Shm-area is at c0051000
> rtapi_shmInitialize: shm-area SLINK4 (id = 0x9f0f05c6) allocated at c0051000 size = 37120
> SM. Shared Memory Area SLINK4 at c0051000
> 
> Ok, the kernel driver creates shm with the name SLINK4 but the user space side doesn't see it:
> 
> rt_heap_bind(shmName=SLINK4) failed. Error=-11 -> EWOULDBLOCK
> SHM area (Name SLINK4, Id 0x9f0f05c6)  at (nil) is INVALID!!!

For the third time: that is because the mapping is not uncached, as
shown by the message you showed us on the kernel console. The
problem is probably that the mmap method of the driver you use does
not want to map cached regions.

-- 
					    Gilles.

