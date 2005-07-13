Message-ID: <42D5892B.8040805@domain.hid>
Date: Wed, 13 Jul 2005 23:35:39 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Fwd: [Adeos-main] LRTBF par-log.c & adeos_critical_enter
	question]
References: <42D2B3B7.30007@domain.hid> <1121117338.6162.38.camel@domain.hid>	
	<42D43C63.2010706@domain.hid> <1121261614.16275.15.camel@domain.hid>
In-Reply-To: <1121261614.16275.15.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Kristian Benoit <kbenoit@domain.hid>
Cc: adeos-main@gna.org, Philippe Gerum <rpm@xenomai.org>

Kristian Benoit wrote:
> On Tue, 2005-07-12 at 23:55 +0200, Hannes Mayer wrote:
> 
>>I mean, is it possible to get information on how many interrupts were
>>lost ?
> 
> 
> Just a though like that, that depend of what you want to do when you
> critical enter.
> 
> Suppose you have the domains root and ham. Where root is the Linux
> domain and ham is your domain that handle your interrupt. Then if you
> add the domain potatoes that is of higher priority than root and ham.
> You can suspend the domain potatoes most of the time, but when you stall
> (stalling instead of critical_enter is the key) the domain ham you can
> resume the domain potatoes that will count the number of interrupt
> receive upon reception of your interrupt. Then when you unstall the
> domain ham, you get the count from the domain potatoes and resuspend it.
> 
> Kristian

Thanks a lot Kristian and Philippe for your answers and tips!
I've got some good pointers now for further research!
If a day would just have 36 hours ;-)

Best regards,
Hannes.


