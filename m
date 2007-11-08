Message-ID: <4733A2B8.8070100@domain.hid>
Date: Fri, 09 Nov 2007 00:58:48 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <473391B0.5040809@domain.hid>
In-Reply-To: <473391B0.5040809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] User space drivers on PPC440
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
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> The rt_misc_get_io_region() has the "start" argument as an unsigned 
> long.  On the PPC440, we have a 36-bit address space, where the I/O 
> registers are generally above the 4GB area.  For example, the UART is at 
> address 0x1ef600300.
> 
> The Linux request_region call has "start" typed as a resource_size_t, 
> which is a u64 on the PPC440 (i.e. CONFIG_RESOURCES_64BIT is set even 
> though this is a 23-bit processor).
> 
> Is this something that should be handled by xeno-config?  It could 
> append a CFLAG indicating the size of a resource.

Or use a 64bit long unconditionally, to keep the same kernel-based
implementation, since there is no performance issue for this call. In
any case, we need to fix the API before 2.4 final is out -- which will
also affect the ABI, but it already changed during the 2.4 development
phase anyway.

> 
>     Steve
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

