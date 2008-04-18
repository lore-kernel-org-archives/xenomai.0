Message-ID: <2ff1a98a0804180821x26128c84l9b6be41ef2a82e47@domain.hid>
Date: Fri, 18 Apr 2008 17:21:09 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150804180808y4d399365gad93fee2f1f9caa0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150804180733k3e2b2bc0p1255b84e16062f05@domain.hid>
	<2ff1a98a0804180748o4dc88c91of90e8e26c36d32ed@domain.hid>
	<d6c8ef150804180808y4d399365gad93fee2f1f9caa0@domain.hid>
Subject: Re: [Xenomai-help] Handling interrupt - jitter
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Fri, Apr 18, 2008 at 5:08 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> On Fri, Apr 18, 2008 at 4:48 PM, Gilles Chanteperdrix
>  <gilles.chanteperdrix@xenomai.org> wrote:
>
>  >  It's funny to notice how much you asked for the 2.6.24 patch for
>  >  actually not using it.
>
>  :) Actually, I've tried with the 2.6.24.3, Adeos 1.9-01 & Xenomai
>  2.4.3 before I posted my mail, but results are the same. And, yes, I'm
>  using it heavily, but because of some other 'compatibility issues' I
>  still haven't fully migrated to the 2.6.24. Thank you very much for
>  migrating Adeos to 2.6.24, I really appreciate it.
>
>
>  >  - handle interrupts in kernel space, so that you will be limited by
>  >  interrupt latency, not user-space scheduling latency
>  >  - use trunk so that user-space context switches involving real-time
>  >  threads do not happen with hardware interrupts off.
>
>  Will I get anything using xenomai-trunk, and still handling interrupt
>  from user-space?

No, the 250us switch time is due to the full cache flush which happens
at each user-space context switch on ARM (this happens because of the
ARM VIVT cache).

The only way to avoid it would be to use ucLinux. Unfortunately, the
status of ucLinux on ARM is quite fuzzy at the moment. It seems some
nommu patches have been merged in the mainstream Linux, but the kernel
still needs further patching. Which is why I have not yet tried
Xenomai over ucLinux on ARM.

Another approach is to use the FCSE extension found on some ARMs
cores, (I think ARM 926EJ-S and onwards). Using this extension imposes
some limitations (maximum number of processes and maximum RAM size for
each process). Richard Cochran posted a patch to modify Linux to use
this extension on Adeos mailing list. I had no time yet to test it,
but I think adapting Xenomai to this patch requires little work if
any.

-- 
 Gilles

