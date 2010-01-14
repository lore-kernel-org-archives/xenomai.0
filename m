Message-ID: <4B4F2DA5.4000606@domain.hid>
Date: Thu, 14 Jan 2010 15:43:49 +0100
From: Simon Boulay <simon.boulay@domain.hid>
MIME-Version: 1.0
References: <4B4E00B3.5090607@domain.hid>
In-Reply-To: <4B4E00B3.5090607@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem with libanalogy
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

Hi,

On 01/13/2010 06:19 PM, Alessio Margan @ IIT wrote:
> Hi,
>
> I've got "Segmentation fault" from libanalogy.so.1
> Here is part of code ...
>
> int s526Analogy::Open()
> {
> int ret = 0;
> boardIsOpen = false;
>
> ret = a4l_open(&dsc, dev_name);
> if (ret<  0) {
> fprintf(stderr, "s526Analogy::Open : a4l_open %s failed (ret=%d)\n",
> dev_name, ret);
> return boardIsOpen;
> }
>
> fprintf(stderr, "s526Analogy::Open : name : %s\nsubd %d\nrd subd %d\nwr
> subd %d\nfd %d\nmagic %x\nsize %d\n",
> dsc.board_name,
> dsc.nb_subd,
> dsc.idx_read_subd,
> dsc.idx_write_subd,
> dsc.fd,
> dsc.magic,
> dsc.sbsize);
>
> dsc.sbdata = malloc(dsc.sbsize);
> if (dsc.sbdata == NULL) {
> ret = -ENOMEM;
> fprintf(stderr, "s526Analogy::Open : info buffer allocation failed\n");
> return boardIsOpen;
> }
> ret = a4l_fill_desc(&dsc);
> if (ret<  0) {
> fprintf(stderr, "s526Analogy::Open : a4l_fill_desc failed (ret=%d)\n", ret);
> return boardIsOpen;
> }
>
> boardIsOpen = true;
> printf("Open %s\n", dev_name);
>
> return boardIsOpen;
> }
>
> and here is the back trace from gdb ....
>
> s526Analogy::Open : name : analogy_s526
> subd 4
> rd subd 1
> wr subd 2
> fd 0
> magic 1234abcd
> size 1560
>
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0xb7151990 (LWP 6138)]
> 0xb773a64a in a4l_sys_desc () from /usr/xenomai/lib/libanalogy.so.1
> Current language: auto; currently asm
> (gdb) bt
> #0 0xb773a64a in a4l_sys_desc () from /usr/xenomai/lib/libanalogy.so.1
> #1 0xb773a748 in a4l_fill_desc () from /usr/xenomai/lib/libanalogy.so.1
> #2 0x0804ebb2 in s526Analogy::Open (this=0x805e560) at s526Analogy.cpp:55
> #3 0x0804f8c6 in configure_board () at s526Main.cpp:95
> #4 0x0804f96a in main () at s526Main.cpp:115
> (gdb)
>
> dmesg give me ...
>
> app[6454]: segfault at 40 ip b772964a sp bfd372d0 error 4 in
> libanalogy.so.1.0.0[b7728000+3000]
>
>
> Yesterday I pull xenomai-head to get last commits, before I've run the
> application without this segfault.
I can't reproduce your problem.
Does the same thing happen with the following command:
insn_read -v -d analogy0?

Simon.

 >
> TIA
>
> Alessio
>
>


