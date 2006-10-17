Message-ID: <453508CD.7090108@domain.hid>
Date: Tue, 17 Oct 2006 18:46:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] which way to obtain irq#
References: <4533C841.3040108@domain.hid>
	<4533D031.4040306@domain.hid>	<4534A243.7070303@domain.hid>
	<4534A4B4.5070100@domain.hid>
In-Reply-To: <4534A4B4.5070100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Marcelo Coelho <mjcoelho@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Marcelo Coelho wrote:
> 
>>> [I think you swapped the terms "real" and "virtual" here, no?]
> 
> 
> At a first look I don't think so. The first option gives a number
> between 1 and 255 and the second gives between 1 and 15.

The second option probably give you the irq as choosen by the BIOS,
whereas the first option is the irq assigned by Linux. The correct one
is the first one.

-- 
                                                  Gilles Chanteperdrix

