Message-ID: <4656CD9E.4010003@domain.hid>
Date: Fri, 25 May 2007 13:50:54 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <4656C2D0.7000705@domain.hid> <4656C583.5040303@domain.hid>
	<4656C784.9090200@domain.hid> <4656C9AB.1040903@domain.hid>
In-Reply-To: <4656C9AB.1040903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with interrupt enabling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

Jan Kiszka wrote:
> OK, then your code should be fine. Which I-pipe patch are you using?
>   
bash-3.00# cat /proc/ipipe/version
1.5-01
bash-3.00# uname -a
Linux MVME3100 2.6.14.Xenomai #51 Fri May 25 11:36:18 CEST 2007 ppc ppc 
ppc GNU/Linux

>> This driver is ported from a standard Linux driver, and in this driver
>> an extra call is also not needed.
>>     
>
> Yep. Sounds like a BUG in I-pipe for me (PPC over Xenomai in general is
> known to be fine). Wolfgang, Philippe, any ideas if/why we might lack
> proper IRQ ending here?
>
> Jan
>   

Kind regard,
    Johan Borkhuis

