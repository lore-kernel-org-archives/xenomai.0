Message-ID: <46E4238A.7010108@domain.hid>
Date: Sun, 09 Sep 2007 18:47:06 +0200
MIME-Version: 1.0
References: <46E3FCDE.8060203@domain.hid>
	<18148.5503.43798.880010@domain.hid>
In-Reply-To: <18148.5503.43798.880010@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] acpi and irq
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

Hi Giles,

Thanks. I thought I had already tried all combinations but I was wrong. 
Your advice moved me to mess about a little more. All seems to be 
working now. Phew....


If you would care to comment, is this not a bit of a black art? It seems 
super primitive to have to mess about with PCI slots until there is no 
conflict. Why is this not taken care of more decently by firmware / OS?

No rebuke to anyone (I'm too clueless myself) just very curious. Is it 
so hard or are there fundamental complexities in automatically sorting 
this out? untracktable problem? This question obviously has no relation 
to xenomai. My apologies but it may be ignored of course. :)

Kind regards

Roland.

Gilles Chanteperdrix wrote:
> Roland Tollenaar wrote:
>  > Hi,
>  > 
>  > I am having trouble with shared irq on two NIC's that I am trying to 
>  > sort out.
>  > 
>  > Googling for solutions I notice that acpi has a lot to do with this. I 
>  > recall somewhere that ACPI support can be disabled in the config when 
>  > patching with xenomai. I was jsut wondering whether this can be related 
>  > to the problem I have?
> 
> I'd say you are confusion ACPI and APIC, and yes, enabling the APIC
> makes more IRQs available, so maybe this could help Linux avoiding IRQ
> sharing. Changing cards from slot usually also helps.
> 

