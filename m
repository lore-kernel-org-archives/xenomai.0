Message-ID: <2ff1a98a0801090154m27419fafi288a86587037227c@domain.hid>
Date: Wed, 9 Jan 2008 10:54:55 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <478497ED.3050809@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <478497ED.3050809@domain.hid>
Subject: Re: [Xenomai-core] #include <linux/uaccess.h> fails with Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Jan 9, 2008 10:46 AM, Wolfgang Grandegger <wg@domain.hid> wrote:
> Hello,
>
> recent versions of Xenomai include the header file "linux/uaccess.h" in
> "xenomai/include/asm-generic/syscall.h" which does not exist under Linux
> 2.4. "asm/uaccess" should be used instead. Any clever idea how to fix it
> (without using #ifdefs)?

Add include/compat/linux/uaccess.h that does #include <asm/uaccess.h>

-- 
                                               Gilles Chanteperdrix

