Message-ID: <4784B3CC.9030307@domain.hid>
Date: Wed, 09 Jan 2008 12:45:16 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <478497ED.3050809@domain.hid>
In-Reply-To: <478497ED.3050809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] #include <linux/uaccess.h> fails with Linux 2.4
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hello,
> 
> recent versions of Xenomai include the header file "linux/uaccess.h" in
> "xenomai/include/asm-generic/syscall.h" which does not exist under Linux
> 2.4. "asm/uaccess" should be used instead. Any clever idea how to fix it
> (without using #ifdefs)?

Actually, we should be fine with asm/uaccess.h in any case. Fixed in the
repo.

-- 
Philippe.

