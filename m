Message-ID: <2ff1a98a0803180248t6093c094nbd3fae5001ef1558@domain.hid>
Date: Tue, 18 Mar 2008 10:48:21 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4E70056F9205354583FBC4273D5430FFF1AF0F@svr-exc-01.intern.wipotec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4E70056F9205354583FBC4273D5430FFF1AA2A@svr-exc-01.intern.wipotec.de>
	<2ff1a98a0803070833xc04bf5du3efdc9c46b1badf2@domain.hid>
	<4E70056F9205354583FBC4273D5430FFF1AF0F@svr-exc-01.intern.wipotec.de>
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

On Fri, Mar 14, 2008 at 11:02 AM, Laux Karsten-Olaf
<karsten-olaf.laux@domain.hid> wrote:
>
>  > From what I read in the AT91 headers, the difference between SAM9263 and other AT91s is that
>  > the TC interrupt is shared. Are you sure you do not get problems with this ?
>
>  Yepp, this is the "problem". The TCB-clock is not found in at91_ipipe_time.c: the setup-code looks for "at91_tc0", but there is only a "at91_tcb" clock.
>
>  Below is a patch which should avoid this problem. The patch was created on base of linux-2.6.24 + adoes-ipipe-2.6.24-arm-1.9.00.
>
>
>  Thanks for your hint,

Actually, I was not thinking about a clock issue. Anyway, your patch
is fine, will merge, thanks.

-- 
 Gilles Chanteperdrix

