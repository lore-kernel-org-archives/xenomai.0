Message-ID: <48FB7465.6040607@domain.hid>
Date: Sun, 19 Oct 2008 19:54:45 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B2EEE69E41E524EB7FCDC62A15D68D8018D014F@ARVMAIL1.mra.roland-man.biz>	<200810190258.16939.berlemont.hauw@domain.hid>
	<48FB7299.4040004@domain.hid>
In-Reply-To: <48FB7299.4040004@domain.hid>
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
> Alexis Berlemont wrote:
>> Hi,
>>
>> On Friday 17 October 2008 06:46, thomas.debes@domain.hid wrote:
>>> No comments or ideas? Providing this feature is essential for our CPCI
>>> drivers. We have to port some Linux applications to Xenomai which use t=
hat
>>> mmap stuff intensely.
>>>
>>> Thanks again!
>>>
>>> Thomas
>>>
>>>> -----Urspr=FCngliche Nachricht-----
>>>> Von: xenomai-help-bounces@domain.hid
>>>> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von
>>>> thomas.debes@domain.hid
>>>> Gesendet: Mittwoch, 8. Oktober 2008 11:49
>>>> An: xenomai@xenomai.org
>>>> Betreff: [Xenomai-help] rtdm_iomap_to_user on PPC
>>>>
>>>> Hello,
>>>>
>>>> in the following thread I was asking for a solution to use
>>>> rtdm_iomap_to_user() on PPC (MPC5200, Denx 2.4.25)
>>
>> In 2.4 kernel, rtdm_iomap_to_user() is based on the function remap_page_=
range=20
>> (with vma->vm_flags |=3D VM_RESERVED).
>>
>> Once, I had to develop a classical Linux driver (for PPC) which provided=
 mmap=20
>> functionalites so as to let a user application mmap a buffer allocated t=
hanks=20
>> to __get_free_pages().
>>
>> On a 2.6 kernel, I used remap_pfn_range() and it works great but on 2.4 =
kernel=20
>> the function remap_page_range() did not work as I expected. I had a quic=
k=20
>> look on its implementation and I found that instead of mapping my buffer=
 it=20
>> mapped newly allocated zeroed pages (if my memories are correct).
>>
>> If I remember well, these pages were allocated in lazy mode. That could =

>> explain the freeze of your whole system: in case a RT application in pri=
mary=20
>> mode tries to access the mmapped buffer.
>=20
> Well, normally, the fault should cause the RT application to switch to
> secondary mode and be handled gracefully from there, unless there is a
> bug hidden in Xenomai or I-pipe. Besides, RT applications usually use
> "mlockall", so the kernel should make all the pages present and not rely
> on further faults (at least, is it how it works on 2.6).
>=20

powerpc may still trigger minor faults upon TLB misses though. That arch ha=
s a
software-assisted MMU.

--=20
Philippe.

