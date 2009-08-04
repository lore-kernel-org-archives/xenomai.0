Date: Tue, 4 Aug 2009 09:21:15 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4A618101.2000608@domain.hid>
Message-ID: <Pine.LNX.4.62.0908040908001.30814@domain.hid>
References: <alpine.DEB.2.00.0907142049190.4341@domain.hid>
	<4A5D88E9.2010305@domain.hid>
	<Pine.LNX.4.62.0907151048370.24398@domain.hid>
	<Pine.LNX.4.62.0907151610090.24888@domain.hid> <4A5F9E8A.3010906@domain.hid>
	<Pine.LNX.4.62.0907171349580.28491@domain.hid> <4A618101.2000608@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] rtdm_mmap_to_user without MMU
Reply-To: Kolja Waschk <xenoka09@domain.hid>
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

> Hmm, thought I got all paths. Such side effects indicate that this way
> is not a stable one. Ok, will try to find a better solution, but may

Hi,

One last note regarding the mmap on blackfin (nommu) thread a few days
ago.

I just noticed that reserving pages with SetPageReserved and clearing
that flag with ClearPageReserved doesn't work as expected. I blindly
copied that code from Jan's (old) RTDM driver example, as below, and now
found that the kernel will fail some seconds after the ClearPageReserved loop:

> / # Bad page state in process 'events/0'
> page:009e29c0 flags:0x00004400 mapping:00000000 mapcount:0 count:0
> Trying to fix it up, but a reboot is needed

If SetPageReserved doesn't work, it may well be the cause for the mmap
trick to fail afterwards. For now, I bypass the page reservation and
mmap and munmap, there is no MMU anyway, so there's no need to hurry.

Here's the code that I refer to:

/* Mark buffer pages as reserved so rtdm_mmap_to_user will work */
unsigned long vaddr;
for (vaddr  = (unsigned long)pool;
      vaddr <= (unsigned long)pool + UFSIZE;
      vaddr += PAGE_SIZE)
{
     SetPageReserved(virt_to_page(vaddr));
}

/* mmap... */
/* munmap... */


/* clear pages reserved */
for (vaddr = (unsigned long)pool;
      vaddr < (unsigned long)pool + BUFSIZE;
      vaddr += PAGE_SIZE)
{
     ClearPageReserved(virt_to_page(vaddr));
}

Kolja


