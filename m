From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Mon, 15 May 2017 14:43:12 +0000
Message-ID: <DB6PR0701MB24563716802B31DB4E93C0F0B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] =?windows-1252?q?too_few_arguments_to_function_=91handl?=
	=?windows-1252?q?e=5Fmm=5Ffault=60?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

The recent commit=20
9a865549170f82561389eaa6d4dbda6f8a46d2e1
"    cobalt/arm: fixups for kernel 4.8+"
seems to have broken 4.4 kernel, see build log below:

arch/arm/xenomai/machine.c: In function =91mach_arm_prefault=92:
arch/arm/xenomai/machine.c:38:20: warning: passing argument 1 of =91handle_=
mm_fault=92 from incompatible pointer type [-Wincompatible-pointer-types]
    handle_mm_fault(vma, addr, flags);
                    ^
In file included from arch/arm/xenomai/machine.c:21:0:
include/linux/mm.h:1165:12: note: expected =91struct mm_struct *=92 but arg=
ument is of type =91struct vm_area_struct *=92
 extern int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vm=
a,
            ^
arch/arm/xenomai/machine.c:38:25: warning: passing argument 2 of =91handle_=
mm_fault=92 makes pointer from integer without a cast [-Wint-conversion]
    handle_mm_fault(vma, addr, flags);
                         ^
In file included from arch/arm/xenomai/machine.c:21:0:
include/linux/mm.h:1165:12: note: expected =91struct vm_area_struct *=92 bu=
t argument is of type =91long unsigned int=92
 extern int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vm=
a,
            ^
arch/arm/xenomai/machine.c:38:4: error: too few arguments to function =91ha=
ndle_mm_fault=92
    handle_mm_fault(vma, addr, flags);
    ^
In file included from arch/arm/xenomai/machine.c:21:0:
include/linux/mm.h:1165:12: note: declared here
 extern int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vm=
a,
scripts/Makefile.build:258: recipe for target 'arch/arm/xenomai/machine.o' =
failed


