References: <DB6PR0701MB24563716802B31DB4E93C0F0B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cc324658-e5ff-52e5-cd9b-0c334e1fd83c@xenomai.org>
Date: Mon, 15 May 2017 16:56:42 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24563716802B31DB4E93C0F0B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai]
 =?utf-8?q?too_few_arguments_to_function_=E2=80=98handle?=
 =?utf-8?q?=5Fmm=5Ffault=60?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/15/2017 04:43 PM, Giulio Moro wrote:
> The recent commit=20
> 9a865549170f82561389eaa6d4dbda6f8a46d2e1
> "    cobalt/arm: fixups for kernel 4.8+"
> seems to have broken 4.4 kernel, see build log below:
>=20
> arch/arm/xenomai/machine.c: In function =91mach_arm_prefault=92:
> arch/arm/xenomai/machine.c:38:20: warning: passing argument 1 of =91handl=
e_mm_fault=92 from incompatible pointer type [-Wincompatible-pointer-types]
>     handle_mm_fault(vma, addr, flags);
>                     ^
> In file included from arch/arm/xenomai/machine.c:21:0:
> include/linux/mm.h:1165:12: note: expected =91struct mm_struct *=92 but a=
rgument is of type =91struct vm_area_struct *=92
>  extern int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *=
vma,
>             ^
> arch/arm/xenomai/machine.c:38:25: warning: passing argument 2 of =91handl=
e_mm_fault=92 makes pointer from integer without a cast [-Wint-conversion]
>     handle_mm_fault(vma, addr, flags);
>                          ^
> In file included from arch/arm/xenomai/machine.c:21:0:
> include/linux/mm.h:1165:12: note: expected =91struct vm_area_struct *=92 =
but argument is of type =91long unsigned int=92
>  extern int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *=
vma,
>             ^
> arch/arm/xenomai/machine.c:38:4: error: too few arguments to function =91=
handle_mm_fault=92
>     handle_mm_fault(vma, addr, flags);
>     ^
> In file included from arch/arm/xenomai/machine.c:21:0:
> include/linux/mm.h:1165:12: note: declared here
>  extern int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *=
vma,
> scripts/Makefile.build:258: recipe for target 'arch/arm/xenomai/machine.o=
' failed
>=20
>=20

diff --git a/kernel/cobalt/arch/arm/machine.c b/kernel/cobalt/arch/arm/mach=
ine.c
index 6768f90..50c14b4 100644
--- a/kernel/cobalt/arch/arm/machine.c
+++ b/kernel/cobalt/arch/arm/machine.c
@@ -35,7 +35,11 @@ static void mach_arm_prefault(struct vm_area_struct *vma)
 		flags =3D (vma->vm_flags & VM_MAYWRITE) ? FAULT_FLAG_WRITE : 0;
 		for (addr =3D vma->vm_start;
 		     addr !=3D vma->vm_end; addr +=3D PAGE_SIZE)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
+			handle_mm_fault(vma->vm_mm, vma, addr, flags);
+#else
 			handle_mm_fault(vma, addr, flags);
+#endif
 	}
 }
=20
--=20
Philippe.

