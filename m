Message-ID: <4A43E58B.3020809@domain.hid>
Date: Thu, 25 Jun 2009 23:00:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1245226350.3614.10.camel@domain.hid>	<4A38AD4D.9090802@domain.hid>	<E5CDD68F7A516B4F863D651CDA2DBF71010A9E64@domain.hid>	<4A43820B.2020701@domain.hid>	<E5CDD68F7A516B4F863D651CDA2DBF71010A9E66@domain.hid>
	<4A4392F7.4050600@domain.hid> <4A43E4C5.9010308@domain.hid>
In-Reply-To: <4A43E4C5.9010308@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RE : RE :  problem with gtk
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Gilles Chanteperdrix schrieb:
>> [...]
>> Besides, I am having SATA controller problems with the latest 2.6.26
>> kernel from debian (unpatched I mean), so I would recommend to stay away
>> from it.
>>   
> 2.6.26-16 or 2.6.26-17 ?
> 
> debian changelog linux 2.6.26-17 (stable, 2009-06-21):
> 
>  linux-2.6 (2.6.26-17) stable; urgency=high
> 
>  * Revert "sata_nv: avoid link reset on controllers where it's broken"
>    due to regression. (closes: #533657)

I am using debian stable, so all I have is the package name 2.6.26-2,
and it is an ahci sata, I would expect sata_nv to be nvidia ?

-- 
					    Gilles.

