Message-ID: <585902E8.2050904@numalliance.com>
Date: Tue, 20 Dec 2016 11:07:36 +0100
From: Benjamin ROUZAUD <brouzaud@numalliance.com>
MIME-Version: 1.0
References: <585798F8.1060309@numalliance.com>
In-Reply-To: <585798F8.1060309@numalliance.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Fwd: rt,Heap segfault with unittest
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hello,

After your answer, we run our test application over GDB and inspect the
stack backtrace for locate the offending code.
We run the two applications with a session (run --session=3Dmysession) an=
d
the second return a seg fault with this backtrace :

#0  0xb7fa58bb in alloc_block () from /usr/xenomai/lib/libcopperplate.so.=
0
No symbol table info available.
#1  0xb7fb30f5 in rt_heap_create () from /usr/xenomai/lib/libalchemy.so.0
No symbol table info available.
#2  0x08049653 in mbuff_alloc (nom=3Dnom@entry=3D0x804a7b0 "outil_automat=
",
taille=3Dtaille@entry=3D3353) at projetC.cpp:69
         ptr =3D 0xb6865578 ""
         err =3D <optimized out>
         already_allocated =3D 6144
         loc_taille =3D <optimized out>
#3  0x08049129 in main () at projetC.cpp:31

We try to debug and we find the line bug. This is the file

/lib/copperplate/heapobj-pshared.c

in the function

static void  *alloc_block(struct shared_heap *heap, size_t size)

at the line

heap->buckets[ilog].freelist =3D *((memoff_t *)block);

The bug appears when we try to allocate an existing block memory with
the function

rt_heap_create () from /usr/xenomai/lib/libalchemy.so.0

using xnmalloc()

We use a new 32 bits system with the xenomai-3.0.3 version (work with
the old xenomai-3. version). We find again the differents file at this
google drive (cf
https://drive.google.com/drive/folders/0B7MmKH2j6iMYWjJfTzVOcFVTRDQ?usp=3D=
sharing).

Cordially,
B. Rouzaud
R&D Numalliance




Le 03/12/2016 18:16, Philippe Gerum a =E9crit :
> On 12/01/2016 04:21 PM, Benjamin ROUZAUD wrote:
>
>> the process C tries to create or link differents allocation areas but =
it
>> crashes with segfault after many
>> creation.
>>
> Then you may want to run your test application over GDB, and inspect th=
e
> stack backtrace for locating the offending code. You could also build i=
t
> for Mercury in debug mode (--enable-debug=3Dfull) instead of Cobalt, an=
d
> use Valgrind to detect memory errors.
>



