Message-ID: <48FB7819.3010501@domain.hid>
Date: Sun, 19 Oct 2008 20:10:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B2EEE69E41E524EB7FCDC62A15D68D8018D014F@ARVMAIL1.mra.roland-man.biz>	<200810190258.16939.berlemont.hauw@domain.hid>
	<48FB7299.4040004@domain.hid> <48FB7465.6040607@domain.hid>
	<48FB74DC.7090906@domain.hid>
In-Reply-To: <48FB74DC.7090906@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rtdm_iomap_to_user on PPC
Reply-To: rpm@xenomai.org
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
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>> Alexis Berlemont wrote:
>>>> Hi,
>>>>
>>>> On Friday 17 October 2008 06:46, thomas.debes@domain.hid wrote:
>>>>> No comments or ideas? Providing this feature is essential for our CPCI
>>>>> drivers. We have to port some Linux applications to Xenomai which use=
 that
>>>>> mmap stuff intensely.
>>>>>
>>>>> Thanks again!
>>>>>
>>>>> Thomas
>>>>>
>>>>>> -----Urspr=FCngliche Nachricht-----
>>>>>> Von: xenomai-help-bounces@domain.hid
>>>>>> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von
>>>>>> thomas.debes@domain.hid
>>>>>> Gesendet: Mittwoch, 8. Oktober 2008 11:49
>>>>>> An: xenomai@xenomai.org
>>>>>> Betreff: [Xenomai-help] rtdm_iomap_to_user on PPC
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> in the following thread I was asking for a solution to use
>>>>>> rtdm_iomap_to_user() on PPC (MPC5200, Denx 2.4.25)
>>>> In 2.4 kernel, rtdm_iomap_to_user() is based on the function remap_pag=
e_range=20
>>>> (with vma->vm_flags |=3D VM_RESERVED).
>>>>
>>>> Once, I had to develop a classical Linux driver (for PPC) which provid=
ed mmap=20
>>>> functionalites so as to let a user application mmap a buffer allocated=
 thanks=20
>>>> to __get_free_pages().
>>>>
>>>> On a 2.6 kernel, I used remap_pfn_range() and it works great but on 2.=
4 kernel=20
>>>> the function remap_page_range() did not work as I expected. I had a qu=
ick=20
>>>> look on its implementation and I found that instead of mapping my buff=
er it=20
>>>> mapped newly allocated zeroed pages (if my memories are correct).
>>>>
>>>> If I remember well, these pages were allocated in lazy mode. That coul=
d=20
>>>> explain the freeze of your whole system: in case a RT application in p=
rimary=20
>>>> mode tries to access the mmapped buffer.
>>> Well, normally, the fault should cause the RT application to switch to
>>> secondary mode and be handled gracefully from there, unless there is a
>>> bug hidden in Xenomai or I-pipe. Besides, RT applications usually use
>>> "mlockall", so the kernel should make all the pages present and not rely
>>> on further faults (at least, is it how it works on 2.6).
>>>
>> powerpc may still trigger minor faults upon TLB misses though. That arch=
 has a
>> software-assisted MMU.
>=20
> Ok, and can these faults cause lockups when they happen in primary mode?
>=20

Unless I messed up things in the I-pipe patch, no. Depending on the MMU
management code, some of them will reach the Linux fault handler and trigge=
r the
mode switch via the Xenomai fault handler, others will be processed directly
from the low-level exception code when it is possible to fix up the mapping=
 from
there.

As I mentioned a long time ago, the issue is more likely related to the
protection bits used with PCI memory resources, which do require additional
fixup on powerpc (_PAGE_GUARDED and _PAGE_NO_CACHE come to mind here).

--=20
Philippe.

