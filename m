Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Jul 2006 13:56:41 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A3F912B@ARVMAIL1.mra.roland-man.biz>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] Xenomai heap services
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Xenomai Version : 2.2-rc2
Skin : native
Kernel : 2.4.25
Arch.: PPC

I try to test my Xenomai system with low memory.
As Linux kills processes which try to allocate more memory than =
available (instead of returning just a NULL-pointer !??), I had to use =
the Xenomai heap services to allocate (nearly) all available memory.

So first I create heaps of about 16MB (why are heaps limited ?) and then =
allocate all the memory of the heap. Roughly like this (not perfect, I =
know) :

   #define MEMORYCHUNKSIZE         16000000
   addsize=3Dmemsize=3DMEMORYCHUNKSIZE; /*max Heapsize 16MB*/
   s.memoryallocated=3D0;
   for(i=3D0;i<20;i++)
   {
      sprintf(nbuf,"bigheap%d",i);
      if(rt_heap_create(&bigheap[i],nbuf,memsize,H_PRIO|H_MAPPABLE))
         break;
      printf("heap %d of size %ld created\n",i,memsize);
      =
if((ret=3Drt_heap_alloc(&bigheap[i],memsize,TM_NONBLOCK,&bigbuf[i])))
      {
         printf("Failed to allocate heap %d of size %ld =
(Ret:%d)\n",i,memsize,ret);
         bigbuf[i]=3DNULL;
         bigsize[i]=3D0;
      }
      else
      {
         s.memoryallocated+=3Dmemsize;
         printf("Heap %d allocated size %ld\n",i,memsize);
         bigsize[i]=3Dmemsize;
      }
   }

First thing I noticed is, that more bytes are used than the size of heap =
:
/proc/xenomai/registry/native/heaps # more bigheap5
type=3Dmappable:size=3D16000000:used=3D16003072

But this is probably all right (some administrative information I guess) =
?

The method described above leaves some spare memory, the size of which I =
try to determine by creating heaps of increasing size (heaps are =
destroyed as soon as they are succesfully created).
After knowing the size of the spare memory, I create a heap a little bit =
smaller (e.g. half the spare size), which is successful.=20
Buuut, when allocating this memory (rt_heap_alloc) I get the error =
-EAGAIN (-11; unfortunately not documented). As EAGAIN suggest I tried =
to allocate memory again and again, but it never is successful.

So, can some friendly guru explain to me :
- why rt_heap_alloc fails
- what the error -EAGAIN means
- why heaps are limited to 16MB
- is there a function telling me how much memory is available (to avoid =
linux tasks beeing killed).


Again I have to thank you in advance for the time you invest for the =
comunity (I don=B4t know what I would do without your advice)

Roderik




