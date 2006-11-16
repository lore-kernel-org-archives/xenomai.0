Message-ID: <455CB696.8040302@domain.hid>
Date: Thu, 16 Nov 2006 20:05:58 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] invalid parameter for xeno_rtcan_mem.ko
References: <54b161f50611160723r355a603awc1d8e1234e5ed44d@domain.hid>	<455C8766.5030905@domain.hid>
	<54b161f50611160754td24368dx150aa449dca1f80c@domain.hid>
In-Reply-To: <54b161f50611160754td24368dx150aa449dca1f80c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Frits de Klark wrote:
> Hi,
> 
> do you mean I should have better provided a patch? I'd love to do so, 
> but I'm not (yet) much of a Linux developer and I've never created a 
> patch before. But I guess there's no escaping the need of learning how 
> to do so very soon :)

You checkout Xenomai from the SVN repository, edit the file and then "$ 
svn diff" will printout the patch. I will fix the bug in the printk

	printk(KERN_ERR "ERROR! No devices specified! "
	       "Use io=<port1>[,...] irq=<irq1>[,...]\n");
	            ^^                		
a.s.a.p.

Wolfgang.


> 
> Best regards,
> 
> Frits
> 
> On 11/16/06, *Jan Kiszka* <jan.kiszka@domain.hid <mailto:jan.kiszka@domain.hid>> 
> wrote:
> 
>     Frits de Klark wrote:
>      > Hello everyone,
>      >
>      > I tried to load the xeno_rtcan_mem module. I got a message that
>     parameter
>      > 'io' is unknown. After a modinfo I found out that the actual
>     parameter
>      > should be 'mem'. I suggest you fix this, since it can be somewhat
>      > confusing.
> 
>     I simple patch would explain better that you are referring to the
>     message in rtcan_mem_init(). And it would already fix the issue. :)
> 
>     Jan
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


