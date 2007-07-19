Message-ID: <2ff1a98a0707190721o12bc9017k7799c463b05f09d5@domain.hid>
Date: Thu, 19 Jul 2007 16:21:52 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <E1IBWhZ-0000YX-PC@mailer.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E1IBWhZ-0000YX-PC@mailer.emlix.com>
Subject: Re: [Adeos-main] [PATCH] [arm] Set the TSC type due to configured
	architecture
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main@gna.org

On 7/19/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> Hi Gilles,
>
> I plan to implement the new userspace TSC feature for decrementing timers but
> stumbled across CONFIG_XENO_ARM_HW_DIRECT_TSC set to 1 independent from the
> configured ARM architecture. See the attached patches for Adeos and Xenomai
> for a possible solution.

I do not remember what I did. But I'd say everything is planned so
that you can add your implementation. I think the place where this
happens is include/asm-arm/syscall.h

-- 
                                               Gilles Chanteperdrix

