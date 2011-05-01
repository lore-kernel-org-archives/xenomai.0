Message-ID: <4DBD6F87.1080002@domain.hid>
Date: Sun, 01 May 2011 16:34:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>	<4DB83CBE.5040007@domain.hid>	<4DB94BA0.1020503@domain.hid>	<4DB94C9C.7080904@domain.hid>	<4DB991E6.90403@domain.hid>	<4DB99E47.7000904@domain.hid>	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>	<4DB9B978.2010200@domain.hid>	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>	<4DB9C0D3.4030003@domain.hid>	<4DBA9C26.2040903@domain.hid>	<4DBAA1DE.4000108@domain.hid>	<4DBBDCA9.1040609@domain.hid>	<BANLkTintQjX=O0DBYbyW2=jhyNQuyeZ=pQ@mail.gmail.com>	<4DBC6D98.2070306@domain.hid>	<BANLkTi=Q07ByVtHNobQBR1uNkHwRAsoo5g@domain.hid>	<4DBC8EEF.40109@domain.hid>
	<BANLkTinQLa9HQniMFS6L7T8PWmYR7C+3LA@mail.gmail.com>
In-Reply-To: <BANLkTinQLa9HQniMFS6L7T8PWmYR7C+3LA@mail.gmail.com>
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

On 05/01/2011 04:23 PM, Alexey Galakhov wrote:
> 2011/5/1 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>>
>> There is a bug in ipipe_tsc_update for decrementers. The all-in-one patch I
>> would like you to try is:
>>
>>
> This hangs ("infinite IRQs 30,37" symptom). It works fine after re-applying
> this:
> - set_irq_handler(irqno, handle_edge_irq);
> + set_irq_handler(irqno, handle_level_irq);
> 
> Seems that handle_edge_irq is broken while handle_level_irq works just fine.
> 
> Now the board seems to work. At least, there are no obvious hangups. Thanks!

Ok. I am going to merge the three changes. Thanks for your patience.

-- 
                                                                Gilles.

