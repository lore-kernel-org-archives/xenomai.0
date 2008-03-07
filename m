Message-ID: <2ff1a98a0803070833xc04bf5du3efdc9c46b1badf2@domain.hid>
Date: Fri, 7 Mar 2008 17:33:54 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4E70056F9205354583FBC4273D5430FFF1AA2A@svr-exc-01.intern.wipotec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4E70056F9205354583FBC4273D5430FFF1AA2A@svr-exc-01.intern.wipotec.de>
Subject: Re: [Adeos-main] AT91SAM9263 and ipipe
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Laux Karsten-Olaf <karsten-olaf.laux@domain.hid>
Cc: adeos-main@gna.org

On Fri, Mar 7, 2008 at 5:26 PM, Laux Karsten-Olaf
<karsten-olaf.laux@domain.hid> wrote:
> Hello,
>
>  I'm trying to get Linux with ipipe running on the AT91SAM9263EK board.
>
>  As basis, I am using the patched kernel-sources from TimeSys/Linuxlink contained in the free BSP-package. This in fact is a linux 2.6.20.11 kernel with added AT91SAM9263 support.
>
>  After applying the adeos-ipipe-2.6.20-arm-1.8-03.patch and after adding ipipe timer-support for the SAM9263 (alike the existing SAM9261 implementation), I can compile and run the kernel.
>
>  Everything looks fine so far: kernel starts, the device-drivers get initialized, root-fs gets mounted, init gets started ...
>  but then STOP.
>  No login appears on the serial console. USB disconnect events still get shown, but nothing else. Ethernet negotiation starts, but no success-message appears.
>
>
>  Has someone an idea, what is wrong here?

>From what I read in the AT91 headers, the difference between SAM9263
and other AT91s is that the TC interrupt is shared. Are you sure you
do not get problems with this ?

-- 
 Gilles Chanteperdrix

