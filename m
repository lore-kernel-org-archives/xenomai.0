Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B427558.9020505@domain.hid>
Date: Tue, 05 Jan 2010 00:10:16 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <729c4a400912260654vf4f99d1ta6105bdace1b4098@domain.hid>		<4B3917BF.5070600@domain.hid>	<729c4a400912281740g17ccf7bcn5d2fd7f63e08c2bd@domain.hid>	<4B39BE8D.8060503@domain.hid>	<4B3B6957.4090901@domain.hid>	<4B3F3C00.4000507@domain.hid>
	<4B42113B.7060304@domain.hid>
In-Reply-To: <4B42113B.7060304@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Sensoray 526 analogy driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
Cc: Xenomai-core@domain.hid

Alessio Margan @ IIT wrote:
> Hi,
> 
>> The irq parameter is not used. It's not used in comedi either.
>> For the io_port, the command analogy_config analogy0 analogy_s526 0xdc0 
>> works for me...
>>
>>   
> not for me ... driver arg 0xdc0 when red by sscanf(opts, "%u",
> &res[(*nb) - 1]) in analogy_config.c in function compute_opts is set to
> 0 due to %u
> if I use the decimal value of ioport it works ... analogy_config
> analogy0 analogy_s526 3520

It seems the version you are using is not up to date, this bug was fixed
two months ago:

commit 01bcfd898555425e96350b306155cba429a65539
Author: Alexis Berlemont <alexis.berlemont@domain.hid>
Date: Sun Nov 8 02:10:20 2009 +0100

analogy: fix a bug in the attach procedure

The options to be sent to the driver at attach time were badly handled
if the values were hexadecimal-based.

>> Did you try to acquire data?
>>   
> I try with insn_read command find in src/utils/analogy but seems that
> subdevice should have commands enabled subd->flags |= A4L_SUBD_CMD;
> 
> Alessio
> 
Regards,

Alexis.


