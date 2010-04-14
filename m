Message-ID: <4BC5A1D3.5020202@domain.hid>
Date: Wed, 14 Apr 2010 13:06:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <g2u132366a01004140355v13765a3hcd5940f489b25dba@domain.hid>
In-Reply-To: <g2u132366a01004140355v13765a3hcd5940f489b25dba@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] prepare_kernel.sh for PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luc ANTOLINOS <luciogistr@domain.hid>
Cc: xenomai@xenomai.org

Luc ANTOLINOS wrote:
> Hi,
> (Xenomai 2.5.2, Linux 2.6.33, PowerPC)
> I noticed the following behaviour in the prepare_kernel.sh script.
> When using target name "powerpc" all is fine, but when using "ppc" the
> script hangs after patching all files.
> Strace indicate the script hangs waiting for an entry (probably a file
> not found and a grep or other tool wait on the stdin). Strace output
> is at the end of this email.
> 
> Is ppc a correct target name ? In the prepare_kernel.sh script the
> variable $linux_arch seams to have a different value when using ppc.
> arch/ppc directory does not exists in Linux 2.6.33 sources.

arch/ppc existed in other versions of Linux sources, with which we
maintain compatibility.

Could you show us the output of prepare-kernel.sh when you use ppc as
architecture?

-- 
					    Gilles.

