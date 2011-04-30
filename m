Message-ID: <4DBC86C7.30808@domain.hid>
Date: Sun, 01 May 2011 00:01:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>	<4DB83CBE.5040007@domain.hid>	<4DB94BA0.1020503@domain.hid>	<4DB94C9C.7080904@domain.hid>	<4DB991E6.90403@domain.hid>	<4DB99E47.7000904@domain.hid>	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>	<4DB9B978.2010200@domain.hid>	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>	<4DB9C0D3.4030003@domain.hid>	<4DBA9C26.2040903@domain.hid>	<4DBAA1DE.4000108@domain.hid>	<4DBBDCA9.1040609@domain.hid>	<BANLkTintQjX=O0DBYbyW2=jhyNQuyeZ=pQ@mail.gmail.com>	<4DBC6D98.2070306@domain.hid>
	<BANLkTi=Q07ByVtHNobQBR1uNkHwRAsoo5g@domain.hid>
In-Reply-To: <BANLkTi=Q07ByVtHNobQBR1uNkHwRAsoo5g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

Alexey Galakhov wrote:
> 2011/5/1 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> Ok. Could you try only keeping the part with ipipe_handle_chained_irq,
>> leaving the handle_edge_irqs?
>>
> 
> Sure. I'll do it tomorrow.
> 
> There is another one issue: the board hangs after about 2-3 minutes running.
> I found that it is caused by a semi-permanent (order of 2^64 iterations)
> loop in (untouched) kernel timer code, most likely due to weird return value
> of __ipipe_tsc_get. I haven't found the source of this problem yet. I tried
> a small fix:

So, there is an issue when the asm code wraps. I will try and reproduce
this.

-- 
                                                                Gilles.

