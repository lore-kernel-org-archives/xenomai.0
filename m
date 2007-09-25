Message-ID: <2ff1a98a0709250625y5bfc46e0k9ac41d04c8d68270@domain.hid>
Date: Tue, 25 Sep 2007 15:25:16 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <OF905A8D7D.169331D8-ONC1257361.003BBCD9-C1257361.0046E005@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0709250152m5d96437br8e98ba405fd4d471@domain.hid>
	<OF905A8D7D.169331D8-ONC1257361.003BBCD9-C1257361.0046E005@domain.hid>
Subject: Re: [Xenomai-help] POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "juergen.lanner@domain.hid" <juergen.lanner@domain.hid>
Cc: xenomai@xenomai.org

On 9/25/07, juergen.lanner@domain.hid <juergen.lanner@domain.hid> wrote:
>
>
>
> Hi Gilles!
>
>
>  Yes, you're right, it was the SMP option that hid the LAPIC.
>
>  Unfortunately switching it on and enabling it at boot gives the same result as before, although the startup log seems ok as well.
>  (see here complete boot log: (See attached file: boot_with_lapic_on_in_kernel_and_boot.txt))
>
>
>  Deactivating LAPIC in kernel: same problem, no change
>  (see here the complete boot log:(See attached file: boot_with_lapic_off_in_kernel.txt) )
>
>  ==> maybe LAPIC is not really an issue here?
>  At least it doesn't change anything if active or not.
>
>
>
>
>  Maybe that is important:
>   I saw that when installing the kernel there were some messages due to files not found.
>
>  The funny thing is that I am using xenomai 2.3.3, not 2.3.0
>  Could the problem be due to this?

This 2.3.0 comes from your kernel configuration, it should not matter.

But there is something in your kernel configuration that prevents
Xenomai syscalls from working properly. In order to find what it is,
could you try and start from a minimal kernel configuration and enable
additional features one by one ?

-- 
                                               Gilles Chanteperdrix

