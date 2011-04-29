Message-ID: <4DBAB87D.4000302@domain.hid>
Date: Fri, 29 Apr 2011 19:09:17 +0600
From: Alexey Galakhov <agalakhov@domain.hid>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>	<4DB83CBE.5040007@domain.hid>	<4DB94BA0.1020503@domain.hid>	<4DB94C9C.7080904@domain.hid>	<4DB991E6.90403@domain.hid>	<4DB99E47.7000904@domain.hid>	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>	<4DB9B978.2010200@domain.hid>
	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>
	<4DB9C0D3.4030003@domain.hid> <4DBA9C26.2040903@domain.hid>
	<4DBAA1DE.4000108@domain.hid> <4DBAAA45.5070405@domain.hid>
	<4DBAAB9D.7070100@domain.hid>
In-Reply-To: <4DBAAB9D.7070100@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

On 04/29/2011 06:14 PM, Gilles Chanteperdrix wrote:
> Alexey Galakhov wrote:
>> On 04/29/2011 05:32 PM, Gilles Chanteperdrix wrote:
>>> Alexey Galakhov wrote:
>>> Now going to try your asm patch.
>>> Ok. Two things to check:
>>> - if the irqs are handled by handle_edge, try using handle_level instead;
>>> - if the irqs are demuxed gpios, check that ipipe_handle_chained_irq is
>>> used instead of generic_handle_irq.
>>>
>>> I will check on my side tonight.
>> Same with the patch.
> The patch was supposed to fix the hang at "Switching to ipipe_tsc
> source". Does your kernel still hang there?
>
Sorry, my mistake, used an incorrect uImage to boot.

The "ipipe_tsc clocksource" bug is FIXED now. Thank you very much!

Now chasing the first bug, mmc interrupt flood...

--
Alex



