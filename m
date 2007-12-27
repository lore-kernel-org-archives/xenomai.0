Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Dec 2007 16:39:53 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB2FB@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap and DMA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
>Fillod Stephane wrote:
> > Perrine Martignoni wrote:
> > >Currently, I write an RTDM module and I would like to do DMA and
mmap
> > to perform transfers who have hard constraints.
> > >I would like to know if there is an example in a driver who would
help
> > me to do this.
> >=20
> > I'm looking for the same need, except I'm not using RTDM, and
everything
> > is in userland. Using the attached patch against Xenomai 2.4.0, I
hope
> > to make it to work with something like this:
>
>I propose the attached modifications. Is it Ok for you ?

Yes, your patch is much cleaner, esp. wrt KMALLOC_MAX_SIZE which I was
not aware of.

The documentation needs an update, and a link to RT_HEAP_INFO.
Does any Doxygen guru knows how to make rt_heap_inquire a hyperlink
in the above chunk?

--- ksrc/skins/native/heap.c    17 Dec 2007 14:36:15 -0000      1.6
+++ ksrc/skins/native/heap.c    27 Dec 2007 15:23:06 -0000
@@ -201,8 +201,8 @@
  *
  * - H_DMA causes the block pool associated to the heap to be
  * allocated in physically contiguous memory, suitable for DMA
- * operations with I/O devices. A 128Kb limit exists for @a heapsize
- * when this flag is passed.
+ * operations with I/O devices. The physical address of the
+ * heap can be obtained by a call to rt_heap_inquire.
  *
  * @return 0 is returned upon success. Otherwise:
  *
--- include/native/heap.h       17 Dec 2007 14:36:09 -0000      1.2
+++ include/native/heap.h       27 Dec 2007 15:34:22 -0000
@@ -34,6 +34,10 @@
 #define H_SINGLE   0x400       /* Manage as single-block area. */
 #define H_SHARED   (H_MAPPABLE|H_SINGLE) /* I.e. shared memory segment.
*/

+/** Structure containing heap-information useful to users.
+ *
+ *  @see rt_heap_inquire()
+ */
 typedef struct rt_heap_info {

     int nwaiters;              /* !< Number of pending tasks. */

Thanks!
--=20
Stephane

