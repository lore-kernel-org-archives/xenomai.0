MIME-Version: 1.0
In-Reply-To: <7504E039-6366-480F-ACA3-018E520122E6@domain.hid>
References: <mailman.6356.1286778008.12503.xenomai@xenomai.org>
	<7504E039-6366-480F-ACA3-018E520122E6@domain.hid>
Date: Mon, 11 Oct 2010 17:35:20 +0200
Message-ID: <AANLkTin__DMjjDxFzBCOiA1Z+ODq01KA6FSWSzEwET3y@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <andi.glatz@domain.hid>
Cc: xenomai@xenomai.org

Thanks for the patches Philippe. I applied them to xenomai 2.5.5.
Tests with a basic application look good, however our bigger project
doesn't. I checked already if we release all mutexes; the base prio 0
thread thread released all of them but stays in primary domain after a
xenomai call.

I'll setup a clean environment, just to be sure, and will investigate
further tomorrow.

On Mon, Oct 11, 2010 at 11:31 AM, Andreas Glatz <andi.glatz@domain.hid> wrote:
>
>>
>> The auto-relax feature is now available from -head (upcoming
>> 2.6.x). You
>> will need all commits from
>> http://git.xenomai.org/?p=xenomai-
>> head.git;a=commit;h=b75cec19387e561f82ac55595db8c993b049f071
>> to
>> http://git.xenomai.org/?p=xenomai-
>> head.git;a=commit;h=6653a9e8eb7339b749989bd74adc3ac3bd29e4da
>>
>> --
>> Philippe.
>>
>>
>
> Very nice. Will try it out soon on my G4 PB Aluminium.
>
> Andreas
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

