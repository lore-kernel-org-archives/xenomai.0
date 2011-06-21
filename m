Message-ID: <4E005580.6010205@domain.hid>
Date: Tue, 21 Jun 2011 10:25:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=xprfSAwzV6g=GmC7q1sEUz4_t_g@domain.hid>
In-Reply-To: <BANLkTi=xprfSAwzV6g=GmC7q1sEUz4_t_g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] unsupported arm machine
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/21/2011 10:05 AM, suresh reddy wrote:
> Dear all,
> 
> Iam compiling the patched kernel that i got from the xenomai git repository.
> 
> during configuration i did not done any changes. Removing all other boards
> from TI except Pandaboard .
> 
> during building uImage iam getting error as below
> 
> In file included from
> /home/balijepalli/omap4/ipipe-gch/kernel/xenomai/arch/generic/hal.c:47:
> /home/balijepalli/omap4/ipipe-gch/arch/arm/include/asm/xenomai/hal.h:77:
> error: #error "Unsupported ARM machine"
> make[5]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
> make[4]: *** [kernel/xenomai/arch/generic] Error 2
> make[3]: *** [kernel/xenomai/arch] Error 2
> make[2]: *** [kernel/xenomai] Error 2
> make[1]: *** [kernel] Error 2
> make: *** [sub-make] Error 2
> 
> 
> There is an hal file from xenomai git ,  Last time i replaced the errored
> hal file with the file from git . Is it the way i should follow for this
> kernel?

You will need more than that. The best thing to do is to checkout
Xenomai git.

-- 
					    Gilles.

