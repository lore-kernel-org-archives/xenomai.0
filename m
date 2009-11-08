Message-ID: <4AF71EA1.4060304@domain.hid>
Date: Sun, 08 Nov 2009 20:40:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9b6d86ab0911050148k55e1d4a2k5c7e373da1357352@domain.hid>
	<4AF46574.6010105@domain.hid>
	<9b6d86ab0911081134j48a89bcbo6f9b0d394ec3b26d@domain.hid>
In-Reply-To: <9b6d86ab0911081134j48a89bcbo6f9b0d394ec3b26d@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [Xenomai-help] Porting Adeos-Ipipe on AVR32 (NGW
	100).
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Vincent Vanbesien <vincent.vanbesien@domain.hid>, Adeos <adeos-main@gna.org>

Vincent Vanbesien wrote:
> 2009/11/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> Vincent Vanbesien wrote:
>>> It is maybe not the first time you receive this email sorry for
>>> disappointment.
>>>
>>> Hello,
>>> We are two students from Nantes (FRANCE) and we have to port adeos-Ipipe
>>> on an AVR32.
>>> We would like to know if there is already something which have been done
>>> about that ? We checked the  Ipipe repository
>>> http://git.denx.de/?p=ipipe-2.6.git;a=summary and we did not find
>>> anything which would have benn done about the architecture AVR32.
>>> best regards
>>> BinomeB and BinomeA
>>> Polytech'Nantes
>> Hi,
>>
>> I do not think there is an ongoing port. Some rumours about a port about
>> to be started came to our ears, but no news since then.
>>
>> Note however, that the project policy about merging a port is to require
>> someone (maybe you ?) to maintain the port, that is maintain
>> the I-pipe patch, and test every release of xenomai on the actual hardware.
>>
>> Regards.
>>
>> --
>>                                           Gilles
>>
>>
>>
> Hello,
> We are starting to port Adeos for the IRQs part. So now we have to program
> the function __ipipe_handle_irq for the AVR32 architecture. First we are
> reading the one for x86. It seems there are generic functions as for example
> "ipipe_apic_vector_irq". We tried to find its definition but we didn't
> achieve.
> Do you know where is the definition? And do you know if there is
> documentation about generic functions?
> We know the following Adeos
> documentation<http://home.gna.org/adeos/doc/api/globals.html>but there
> is no function which begins with "ipipe_"
> Regards
> BinomeA and BinomeB

Your questions would make sense on the Adeos mailing list.

But as a general advice, I think you should read the PPC or ARM port,
not the x86 port, x86 is a very peculiar architecture.

-- 
					    Gilles.

