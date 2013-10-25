MIME-Version: 1.0
In-Reply-To: 
References: 
From: George Broz <GBroz@moog.com>
Message-ID: <OF415A91C1.3CB4977D-ON85257C0F.0078CAEF-85257C0F.0078CB7B@moog.com>
Date: Fri, 25 Oct 2013 17:59:24 -0400
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [Xenomai] rt_heap_alloc priority inversion
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hello All,

I'm running Linux 2.6.37.6 w/Xenomai 2.6.1, native API=20
on x86 (Atom, SMP, 32-bit).=20

I have two tasks, both running in Xenomai user-space.=20
One is priority=3D99 and blocks on rt=5Fintr=5Fwait(),=20
running every 250 us with 125us margin. This task does=20
not make direct calls to rt=5Fheap=5Falloc/free().

The other task is priority=3D50, wakes 1msec, sleeps 1msec.
This task routinely makes rt=5Fheap=5Falloc/free calls.=20

When the priority=3D50 task makes rt=5Fheap=5Falloc() calls
for "size" greater than 5 MB, the priority=3D99 task
appears to be held off from executing for several ms.

Plenty of memory is available (vmalloc=3D320M as linux=20
boot arg). TM=5FNONBLOCK is used when calling=20
rt=5Fheap=5Falloc(). Both "0" and H=5FPRIO have been tried
for "mode" when creating the area with rt=5Fheap=5Fcreate().

Is this expected behavior?=20

How can large memory allocations be built without a=20
"realloc" equivalent offered in the memory heap=20
services?


Thanks in advance!
---
George Broz
Moog, Inc. Industrial Group=


