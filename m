Message-ID: <47DD3FB4.5080305@domain.hid>
Date: Sun, 16 Mar 2008 16:41:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47DD3BF9.2@domain.hid>
In-Reply-To: <47DD3BF9.2@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] pgprot_noncached for io-remapping?
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Hi,
> 
> doesn't this patch [1] have some relevance for us as well? As we use
> xnarch_remap_io_page_range also for non-IO memory, I'm hesitating to
> suggest that we apply this unconditionally at xnarch level. Ideas welcome.
>

Yes, I think it makes a lot of sense on powerpc at least, since doing so will
set the PAGE_GUARDED bit as well, and we obviously want to avoid any
out-of-order access of I/O memory.

(I don't see the reason to force the VM_RESERVED and VM_IO on the vma though,
since remap_pfn_range will do it anyway.)

I'll merge that bit, thanks.

> Jan
> 
> [1] http://permalink.gmane.org/gmane.linux.kernel/653921
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

