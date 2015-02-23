From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Mon, 23 Feb 2015 12:44:21 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342902DC9@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rt_heap_bind, Error=-11 -> EWOULDBLOCK why?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi

We have a working system with xeno 2.6.4, Kernel 3.14.17 and a Kontron PC T=
T-Module.

It is a normal situation: a Pci card with an fpga spends memory and the ker=
nel driver create the shared mem with rt_crate_heap.
The userspace program get the memory with rt_bind_heap.
This works fine.

Now I change only the cpu from TT-Module to a Bytrail-Modul, and now I get =
the error that the named heap was not found?
"rt_heap_bind(shmName=3DSLINK4) failed. Error=3D-11"

The kernel says:
[]sd3:826 map pfn expected mapping type uncached-minus for [mem 0x00050000-=
0x0005afff], got write-back

I found out, when I add  "nopat" to the kernel cmd line, the rt_heap_bind f=
unction are lucky.
But I think this is not the best solution, probably I allocate the memory w=
ith wrong flags?

Any ideas what must I do?


With best regards,
Alexander H=E4nel-Baas
