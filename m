Message-ID: <2ff1a98a0803040533v29f5455g3b6097dc830d0666@domain.hid>
Date: Tue, 4 Mar 2008 14:33:09 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390803040449i2111e0a7r5b0acf3d62674931@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390803040449i2111e0a7r5b0acf3d62674931@domain.hid>
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

On Tue, Mar 4, 2008 at 1:49 PM, axel axel <softaxel@domain.hid> wrote:
> Hi,
>
> i want to use floating point in module with some xenomai task.
> I understand that i can use floating point if i implement some functions (
> xnarch_fpu_init...... ).
>
> Ok for this but if i try to compile the module, the compiler ( gcc 3.4.3 for
> arm ) says me there are unresolved symbol like __mulsf3.

Compile your module with V=1 and you will understand what happens.

-- 
                                               Gilles Chanteperdrix

