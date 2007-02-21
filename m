Message-ID: <45DC0939.6070207@domain.hid>
Date: Wed, 21 Feb 2007 09:56:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Enhanced RTDM device closure
References: <45DC0623.3080706@domain.hid>
In-Reply-To: <45DC0623.3080706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> a few changes of the RTDM layer were committed to trunk recently. They
> make handling of RTDM file descriptors more handy:
> 
>  o rt_dev_close/POSIX-close now polls as long as the underlying device
>    reports -EAGAIN. No more looping inside the application is required.
>    This applies to the usual non-RT invocation of close, the corner
>    case "close from RT context" can still return EAGAIN.
> 
>  o Automatic cleanup of open file descriptors has been implemented. This
>    is not yet the perfect design (*), but a straightforward approach to
>    ease the cleanup after application crashes or other unexpected
>    terminations.
> 
> The code is still young, so testers are welcome.
> 
> Jan
> 
> 
> (*) Actually, I would like to see generic per-process file descriptor
> tables one day, used by both the POSIX and the RTDM skin. The FD table
> should be obtained via xnshadow_ppd_get().

I agree for the file descriptor table, but I do not see why it should be
bound to xnshadow_ppd_get. The file descriptor table could be
implemented in an object like fashion, where the caller is responsible
to pass the same pointer to the creation, use and desctruction routines.
This would allow, for example, to have a descriptor table for
kernel-space threads. Another feature that would be interesting for the
posix skin would be to have a callback called at process fork time in
order to duplicate the fd table.


 But first this requires
> lock-less xnshadow_ppd_get() based on ipipe_get_ptd() to keep the
> overhead limited. Yet another story.

xnshadow_ppd_get is already lockless, usual callers have to hold the
nklock for other reasons anyway.

-- 
                                                 Gilles Chanteperdrix

