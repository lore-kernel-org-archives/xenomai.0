Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: ipipe-arm64 kernel issue
From: Steve Pavao <stevep@korgrd.com>
In-Reply-To: <58308e88-38d2-e4ea-232e-8f84dfe1fbd4@xenomai.org>
Date: Thu, 13 Dec 2018 07:50:12 -0500
Message-Id: <8AAA419E-875B-4CC7-9118-8DC45BE270A2@korgrd.com>
References: <8C8014A3-6A93-4E44-B753-49AC9FA313A3@korgrd.com>
 <58308e88-38d2-e4ea-232e-8f84dfe1fbd4@xenomai.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


> On Dec 12, 2018, at 5:21 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>=20
> On 12/11/18 10:25 PM, Steve Pavao via Xenomai wrote:
>> I have 2 different, basic apps that oops in a very similar way on =
ipipe-arm64 running on R Pi 3B.  One of them is rpm, another is my own =
program.
>>=20
>> Here is the partial backtrace for the =E2=80=98rpm=E2=80=99 oops.  =
The backtrace for my other program is almost identical.  (I=E2=80=99ve =
left out interim calls to keep this email concise.)
>>=20
>> [  124.816179] [<ffffff8008260480>] __find_get_block+0x2a0/0x400
>> ...
>> [  124.816311] [<ffffff8008778b88>] do_page_fault+0x268/0x4e0
>> [  124.816320] [<ffffff8008778e6c>] do_translation_fault+0x6c/0x7c
>> [  124.816330] [<ffffff80080814ec>] do_mem_abort+0x54/0xc8
>>=20
>> The BUG finally occurs at line 1279 of buffer.c:
>>=20
>> static inline void check_irqs_on(void)
>> {
>> #ifdef irqs_disabled
>> 	BUG_ON(irqs_disabled());   //  <=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
 here
>> #endif
>> }
>>=20
>> The above BUG happens during the page fault recovery process.  (FYI, =
some of the calls between do_page_fault_and __find_get_block are ext4 =
calls.)
>>=20
>> In both apps, the oops happens around the time of file creation on =
the SD card:  For rpm, it is during an install of a valid rpm package, =
for the other app, it occurs at the time a sqlite database is opened.  =
This is basic stuff that should just work.
>>=20
>> I am looking for ideas about what could be wrong with the =
setup/configuration of my ipipe-arm64 system, such that some apps that =
read/write to the SD card are oopsing this way when doing page fault =
recovery.
>=20
> This is a bug in the I-pipe layer. Assuming you are still running =
kernel
> 4.9, please try 4.14 from [1], it fixes several issues which still =
exist
> in the 4.9 pipeline.
>=20
> [1] =
https://gitlab.denx.de/Xenomai/ipipe-arm64/commits/stable/4.14.71-arm64 =
<https://gitlab.denx.de/Xenomai/ipipe-arm64/commits/stable/4.14.71-arm64>
>=20
>=20
> --=20
> Philippe.

Thank you very much!  That code does fix the kernel oops problem.

As I continue to bring up my app, I notice I=E2=80=99m having a segfault =
(SIGSEGV) trying to access the general purpose IO pins.

I notice that /dev/gpiomem is missing from the environment.

Would this be due to an out-of-date or too lean dtb file for the Pi 3B, =
or might it not be available for some other reason?

I am using the dtb from the ipipe-arm64 build.

Steve Pavao
Korg R&D






