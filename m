Message-ID: <2ff1a98a0707200615q30e86381ne9dfdd73ae142c31@domain.hid>
Date: Fri, 20 Jul 2007 15:15:25 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <E1IBs3G-0000Ky-Pg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E1IBs3G-0000Ky-Pg@domain.hid>
Subject: Re: [Adeos-main] [PATCH] [arm] user space tsc emulation support for
	s3c24xx
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

On 7/20/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> Hi,
>
> On s3c24xx user space tsc emulation is now supported with this patch. Note
> that the patch for time.c is made against the patch I sent on Wednesday to
> this list.

Same remark for __ipipe_tscinfo as for __xn_tscinfo.
I would also vote for creating another variable initialized with tsc + 1

-- 
                                               Gilles Chanteperdrix

