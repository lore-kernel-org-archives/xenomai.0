Message-ID: <45DE0A43.8030800@domain.hid>
Date: Thu, 22 Feb 2007 22:25:23 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid> <45DD8B42.1020709@domain.hid>	
	<bc4264770702220434v13302afcg3f790e823f08169c@domain.hid>	
	<45DD9294.1060109@domain.hid>	
	<bc4264770702220502p13556486l3d59ad7b4b3ff737@domain.hid>	
	<45DD9814.4060809@domain.hid>	
	<bc4264770702220536veb7de41saf40e41fccbbf377@domain.hid>	
	<45DD9DB0.1010103@domain.hid>	
	<bc4264770702220557x7d43d767m5383e8d8ce60204a@domain.hid>	
	<45DDA504.4070408@domain.hid>
	<bc4264770702220652m138956ceh32713b862ee1080a@domain.hid>
	<45DDB542.2050601@domain.hid> <45DDFF9D.5020104@domain.hid>
In-Reply-To: <45DDFF9D.5020104@domain.hid>
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
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

Roland Tollenaar wrote:
> Hi Wolfgang,
> 
>>>> I said, it can be statically linked into the kernel but it will not 
>>>> work
>>>> (without modification, we can discuss this issue when you have a PCAN
>>>> dongle). What should a driver without hardware be good for?
>>> Good question. On the other hand it would be useful to know which
>>> module I have to
>>> pick out and load. Then I can compile the kernel for that so long and
>>> make a structure that loads it after booting. But that can be done
>>> later too.
>>
>> You can do it now, just try and then ask questions.
> 
> Did it now, now there are questions. :)

OK.

> The README says something about loading modules only it talks about
> 
> insmod xeno_can.o
> and some others I cannot recall now (on windows now haven't got linux 
> handy).
> 
> If I do the make modules and make modules_install I end up with a 
> rtcan_peak_dngl.ko (again only the extension is accurate). modprobing 
> that does not work so I insmod it. I get a message that invalid 
> parameters were supplied or somethign like that.

Well, the modules name is xeno_can_peak_dng.ko as listed when doing:

   $ make modules
   ...
   LD [M]  drivers/xenomai/can/sja1000/xeno_can_peak_dng.ko
                                       ^^^^^^^^^^^^^^^^^^^^


> In a flash I did see something mentioned about loading the modules with 
> parameters (maybe you mentioned it?) but I cannot find the documentation 
> that says something about this. Where must I look?

And I load the modules with the following command:

   $ modprobe xeno_can_peak_dng type=epp io=0x378 irq=7

Wolfgang.


