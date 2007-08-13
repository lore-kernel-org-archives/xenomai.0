Message-ID: <46C0A02A.1010706@domain.hid>
Date: Mon, 13 Aug 2007 20:17:14 +0200
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid> <46C063E0.1010809@domain.hid>
	<46C07005.8000504@domain.hid> <46C07EDC.4040305@domain.hid>
	<46C08D64.4050903@domain.hid> <46C09773.5070607@domain.hid>
	<46C09B86.3030709@domain.hid>
In-Reply-To: <46C09B86.3030709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input	framebuilding failed.
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>, rtnet-users <rtnet-users@domain.hid>

Hi,

>> The 64 is a value I got from the mailing list. How large can I make this
>> and what am I compromising?
> 
> Each buffer is slightly more than 1.5 KB heavy. Do your maths :). How
> many buffers you need depend on how many incoming and outgoing frames
> might be queued into they are processed. And that depends on the frame
> rate and the time your EML stack has to handle it in the worst case. I
> can't give you numbers on this, that depends on _your_ setup.

That much is clear. Will make it big out of shear inability to 
calculate. The lost memory is of almost no concern.

Thanks.

Roland


> 
> Jan
> 

