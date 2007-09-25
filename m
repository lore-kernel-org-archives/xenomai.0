Message-ID: <2ff1a98a0709250152m5d96437br8e98ba405fd4d471@domain.hid>
Date: Tue, 25 Sep 2007 10:52:46 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <OFB8A3FC86.9A858D18-ONC1257360.003E332F-C1257361.00240ACF@datacon.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18164.5365.820554.634410@domain.hid>
	<OFB8A3FC86.9A858D18-ONC1257360.003E332F-C1257361.00240ACF@datacon.at>
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
> Hello Gilles!
>
>  Thank you very much for your reponse.
>
>  LAPIC is disabled in BIOS, so "make menuconfig" does not even give me the possibility to change it at all.
>  in the .config file I could find CONFIG_X86_LOCAL_APIC=y.
>  I f I set it to =n and start "make menuconfig" again, it resets it to y even if I do not change anything manually.

The reason why make menuconfig does not let you change the LAPIC
setting is that you selected the "SMP" option. Since your box only has
one CPU, you should disable SMP. Then you will be able to enable or
disable the local APIC. Note that if your box has an APIC, using it
gives better performances.

-- 
                                               Gilles Chanteperdrix

