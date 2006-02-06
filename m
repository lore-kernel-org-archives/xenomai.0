From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap alternative
Date: Mon, 6 Feb 2006 19:00:35 -0200
References: <20060203192739.87567.qmail@domain.hid>
	<43E4A197.6030801@domain.hid> <43E4A102.4070207@domain.hid>
In-Reply-To: <43E4A102.4070207@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200602061900.35411.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan,

>...
>What precisely? I suggested to look at remap_pfn_range() or
>io_remap_page_range(). Do you see problems when using one of them?

This is the function prototype:

int remap_pfn_range(struct vm_area_struct *vma,
unsigned long virt_addr, unsigned long pfn,
unsigned long size, pgprot_t prot);

When a mmap call is issued, the vma structure is already initially filled. =
I=20
don't know how to fill it and LDD3 doesn't explain it:

"The arguments to remap_pfn_range are fairly straightforward, and most of t=
hem=20
are already provided to you in the VMA when your mmap method is called."

"Note that the kernel maintains lists and trees of VMAs to optimize area=20
lookup, and several fields of vm_area_struct are used to maintain this=20
organization. Therefore, VMAs can=E2=80=99t be created at will by a driver,=
 or the=20
structures break."

So, I don't know how to implement a mmap like ioctl. Any sugestions?

Thanks,

Rodrigo.

	

	
		
_______________________________________________________ 
Yahoo! doce lar. Fa�a do Yahoo! sua homepage. 
http://br.yahoo.com/homepageset.html 



