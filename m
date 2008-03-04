Message-ID: <47CD4964.2050307@domain.hid>
Date: Tue, 04 Mar 2008 14:06:44 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <d3f72a390803040449i2111e0a7r5b0acf3d62674931@domain.hid>
In-Reply-To: <d3f72a390803040449i2111e0a7r5b0acf3d62674931@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] USING FLOATING POINT KERNEL SIDE
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

axel axel wrote:
> Hi,
> 
> i want to use floating point in module with some xenomai task.
> I understand that i can use floating point if i implement some functions
> ( xnarch_fpu_init...... ).
> 
> Ok for this but if i try to compile the module, the compiler ( gcc 3.4.3
> for arm ) says me there are unresolved symbol like __mulsf3.
> 
> Have you ever try a xenomai task that use floating point in kernel space ?

Does your ARM processor have a FPU? If not, you need a FP emulation
library to link with.

Wolfgang.

