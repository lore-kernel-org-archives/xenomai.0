Message-ID: <455CB074.9030301@domain.hid>
Date: Thu, 16 Nov 2006 19:39:48 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] invalid parameter for xeno_rtcan_mem.ko
References: <54b161f50611160723r355a603awc1d8e1234e5ed44d@domain.hid>
In-Reply-To: <54b161f50611160723r355a603awc1d8e1234e5ed44d@domain.hid>
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
Cc: xenomai@xenomai.org

Frits de Klark wrote:
> Hello everyone,
> 
> I tried to load the xeno_rtcan_mem module. I got a message that 
> parameter 'io' is unknown. After a modinfo I found out that the actual 
> parameter should be 'mem'. I suggest you fix this, since it can be 
> somewhat confusing.

Thanks for reporting. It will be fixed with my next RT-Socket-CAN update.

Wolfgang.


