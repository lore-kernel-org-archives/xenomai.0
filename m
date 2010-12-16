Message-ID: <20101216183906.107373zy122ag800@domain.hid>
Date: Thu, 16 Dec 2010 18:39:06 +0100
From: Michel He <michel.he@domain.hid>
References: <20101216130423.19383g369jps4nk0@domain.hid>
	<4D0A0615.5080304@domain.hid>
In-Reply-To: <4D0A0615.5080304@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Gumstix / RTNET / INT Problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

Ok, I find out the cause. It is the Xenomai IRQ type management problem.
to resolve that, I added set_irq_type(dev->irq, =20
IRQ_TYPE_EDGE_FALLING); after the rtdm_irq_request, but sometime =20
during the loading of the driver it seems to be locked ? Otherwise it =20
could get jump to the handler after that interrupt declenched

thank you for your advise



Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> a =C3=A9crit=C2=A0:

> Michel He wrote:
>> Hello All,
>>
>>      I'm currently developing a RTNet RTDM driver for the chip SMSC
>> Lan9221 in Gumstix expansion board. I'm using the patch from
>> blog.gmane.org/gmane.linux.real-time...overo-sakoman.diff for Linux
>> 2.6.33.
>
> What version of Xenomai? What version of the I-pipe patch? why do you
> need an additional patch, why not using mainline + I-pipe?
>
> Also, you do not give us a full URL to the patch you are talking about,
> so we can not download it?
>
> --
>                                                                 Gilles.
>



