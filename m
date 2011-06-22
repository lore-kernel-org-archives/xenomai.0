Message-ID: <4E01977E.1080202@domain.hid>
Date: Wed, 22 Jun 2011 09:19:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=qe3CqD9U_T3nF6xBN+nZNbxF7Gg@domain.hid>
	<4E00A476.2080006@domain.hid>
In-Reply-To: <4E00A476.2080006@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] regarding ARMv.s error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/21/2011 04:02 PM, Gilles Chanteperdrix wrote:
> On 06/21/2011 03:11 PM, suresh reddy wrote:
>> Dear all,
>>
>>
>> i have downloaded ipipe patched kernel from xenomai git .and applied the
>> patches to the xenomai 2.5.6 sources as mentioned .
>>
>> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=../build
>> omap2plus_defconfig
>> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=../build menuconfig
>>
>> i just removed all the other boards from TI except Pandaboard. I did not
>> touched any other options.
>>
>> then I run the command
>>
>> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=../build uImage
>>
>> then it giving me the error as below
>>
>> /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S: Assembler
>> messages:
>> /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:1407: Error:
>> undefined symbol `.L99973' in operation setting `up_b_offset'
>> /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:1407: Error:
>> undefined symbol `.L99973' in operation setting `up_b_offset'
>> /home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:1407: Error:
>> local label `"9997" (instance number 3 of a fb label)' is not defined
>> make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1
>> make[1]: *** [arch/arm/kernel] Error 2
>> make: *** [sub-make] Error 2
> 
> Disable SMP kernel boot on UP system, you do not need it for OMAP4,
> since OMAP4 is an SMP system.
> 

It turns out the SMP on UP option can be enabled. Please try the .config
I use:
http://sisyphus.hd.free.fr/~gilles/omap4_panda_config

-- 
                                                                Gilles.

