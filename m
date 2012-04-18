Message-ID: <4F8EAAAE.4050603@domain.hid>
Date: Wed, 18 Apr 2012 13:51:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F56387B.40702@domain.hid>
	<4F575BA3.7060404@domain.hid>	<4F576622.1030509@domain.hid>
	<4F57A567.7030008@domain.hid>	<4F7C127D.2010400@domain.hid>
	<4F7C1484.5090406@domain.hid>	<4F7C183F.5040009@domain.hid>
	<4F7F0D4E.8080906@domain.hid>	<4F7F0E8A.70702@domain.hid>
	<4F7F20F0.9070007@domain.hid>	<4F80BD10.2060200@domain.hid>
	<4F83F2C3.50704@domain.hid>	<4F83F321.2030300@domain.hid>
	<4F83F645.7040402@domain.hid> <4F83F828.4000508@domain.hid>
	<4F83F929.5000300@domain.hid> <4F83FBAB.7040301@domain.hid>
	<4F83FF49.90608@domain.hid> <4F840DD8.2030407@domain.hid>
	<4F841E32.50101@domain.hid> <4F8428AA.1040404@domain.hid>
	<4F842A4B.8040106@domain.hid> <4F852BBB.5050400@domain.hid>
	<4F85749C.808@domain.hid> <4F86AA98.6010805@domain.hid>
	<4F87099F.2020707@domain.hid> <4F87139E.6050805@domain.hid>
	<4F87E781.8020801@domain.hid> <4F882E7B.7010909@domain.hid>
	<4F8E7EF1.4070205@domain.hid> <4F8E871D.8030207@domain.hid>
	<4F8E9746.8060209@domain.hid>
In-Reply-To: <4F8E9746.8060209@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] porting xenomai on imx25
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 04/18/2012 12:28 PM, Roberto Bielli wrote:
> Hi Gilles,
> 
> i try to give only another accurate information.
> 
> i made another test:
> i write a xenomai driver for reading the timer and avic register and i 
> see a strange behaviour.
> when there is the problem the interrupt is NOT masqueraded in avic but 
> the timer has the interrupt not acked.

Ah, that is good news, at least now we have a clue. Note that it could
also mean that the timer has ticked, but the irq is not generated for
another reason. I think you should dump all the timer registers, and see
if anything is wrong by decoding their values with the datasheet.

A quick test also, assuming that the write to the MX3_TSTAT regiter in
gpt_irq_acknowledge may be posted, try rereading the register after
writing it.

> 
> After this i understand that now are my problems.
> Do you know somebody that can help me understanding the problem only for 
> xenomai side?

If you need someone's help, you need to give access to your board to
that person or company. Because indirect debugging is really
inefficient: look at how many mails I had to send you over how much time
to get you to do what anybody with xenomai experience would have done in
just a few hours.

-- 
                                                                Gilles.

