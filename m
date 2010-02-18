Message-ID: <4B7D0713.5080602@domain.hid>
Date: Thu, 18 Feb 2010 10:23:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B79A113.2020300@domain.hid>	<1266263285.2375.141.camel@domain.hid>	<4B79B972.9080000@domain.hid>	<4B7AA5B4.8030007@domain.hid>
	<4B7AB628.2010405@domain.hid>	<4B7AC76B.5070801@domain.hid>
	<4B7ACC56.4070802@domain.hid> <4B7AEF36.6030304@domain.hid>
In-Reply-To: <4B7AEF36.6030304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] bug: patch support for intel atom n270
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Chris Cole <clecol@domain.hid>
Cc: adeos-main@gna.org

Chris Cole wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>  
>>> Chris Cole wrote:
>>>    
>>>>> Also, I realize that the patch / kernels do not match up 100%
>>>>> (although the patch applied successfully),
>>>>> so I'm trying that same patch on 2.6.32.7 now to see if I get the
>>>>> same behavior.
>>>>>
>>>>> Chris
>>>>>
>>>>>         
>>>> Indeed, with the adeos patch for 2.6.32.7 and a vanilla 2.6.32.7, my
>>>> system is un-bootable. Is there
>>>> anything I can do to debug it? I'd be willing to help get a fix out
>>>> but I'm not really sure where to
>>>> look.
>>>>       
>>> Let's start with looking at and playing with .configs. Could you provide
>>> yours?
>>>     
>>
>> Also interesting: What does "unbootable" mean? Where does it hang, what
>> is dumped to the serial kernel console up to that point?
>>
>>   
> Jan,
> My config is attached, and by "unbootable" I mean, it says something like
> "Booting the kernel" and then just hangs.

For the time being, you could retry with CONFIG_M586TSC or better.
Adjusting the CPU type is recommended anyway to avoid using legacy
PIC/PIT. And please attach a serial cable and enable console=ttyS0
(maybe even earlycon) so that we get more info about your failing boot.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

