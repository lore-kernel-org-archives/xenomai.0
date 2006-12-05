Message-ID: <4575A3BF.40605@domain.hid>
Date: Tue, 05 Dec 2006 17:52:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
References: <E1GrHXk-00023w-Oq@domain.hid>
	<457584DD.90600@domain.hid>	<4575888D.8090904@domain.hid>
	<E1GrdKV-00048O-FF@mailer.emlix.com>
In-Reply-To: <E1GrdKV-00048O-FF@mailer.emlix.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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

Sebastian Smolorz wrote:
> Gilles Chanteperdrix wrote:
>>Probably not, the vmalloced area is added only to the page table of the
>>process that calls vmalloc, it is added to other processes table page
>>only once they use it.
> 
> 
> Are there any alternatives? Or do we have to live with this restriction?

The alternative is to implement set_pgdir. I had a look at it, but I
stopped when I realized that the linked list of mm structs which exists
on x86 did not exist on arm.

-- 
                                                 Gilles Chanteperdrix

