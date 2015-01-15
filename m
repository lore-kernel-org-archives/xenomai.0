Message-ID: <54B7B5B7.1010802@xenomai.org>
Date: Thu, 15 Jan 2015 07:42:31 -0500
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAPyMYMH_ekDajGoQ3G-bDuJQ9DCXVKyx+am=R5+_1AdJL-By7g@mail.gmail.com>
In-Reply-To: <CAPyMYMH_ekDajGoQ3G-bDuJQ9DCXVKyx+am=R5+_1AdJL-By7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai]
 =?utf-8?q?Analogy_-_Digital_input_change_detection_on_f?=
 =?utf-8?q?alling_or_rising_edge_=28NI_PCI6229=29=E2=80=8F?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Rosali Pyun <dayepyun@gmail.com>, xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/15/2015 04:54 AM, Rosali Pyun wrote:
> On 14/01/15 16:58, Jorge Ramirez Ortiz wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 01/14/2015 10:44 AM, Rosali Pyun wrote:
>>> Hello to all,
>>> I am using NI m-series DAQ card (PCI 6229), and I would like to use digital input channel to detect a change on falling or rising edge.I need to detect the edge and trigger it to log the exact time.I tried to configure the digital channel using instruction as the following, but I received -22 error code.
>>> insn.type = A4L_INSN_CONFIG;insn.idx_subd = SUBD_DIO;insn.chan_desc = 0;insn.data_size = sizeof(data[0])*3;data[0] = A4L_INSN_CONFIG_CHANGE_NOTIFY;data[1]=0x01;data[2]=0x01;insn.data = data;
>>
>>
>> could you send a code snippet and details about the xenomai version that you are
>> running?
>>
>>
>>> The DAQ card datasheet states that such functionality is supported, but I read couple of posts on Comedi forum that it is not supported for ni_pcimio in Comedi.Is it really impossible to use the digital input channel as an interrupt on Analogy driver?
>>> If anyone has tried it, could you give me some tips on configuring it?I appreciate any help that I receive.
>>> Best,Rosali
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> http://www.xenomai.org/mailman/listinfo/xenomai
>>>
>>
>> - --
>> jro
> 
> I am using xenomai 2.6.3 with linux kernel 3.8.13 on an ubuntu 12.04.
> Please see the attachment for instruction structure I used.
> 
> I can use digital channel as static input and output channel.
> I just have a problem to use it as interrupt.

apologies, I should have checked the code first.

yes this is not currently supported by the driver:
http://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/analogy/national_instruments/mio_common.c#n3234

Comedi as you read on the forums, doesnt have support for this functionality
either.
See link below:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/comedi/drivers/ni_mio_common.c?id=85678d5d27cb0ea1005316f51b1b062bf4609b66#n3530



> 
> Best,
> Rosali
> 

- -- 
jro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUt7WzAAoJECDcy2IJkagRongH/2RgOAsHnV8yEmkGVPn4RkN3
Ul1wAtUO2FBWqKbMcRjbzixDeaheQUyx87xx/N2Eghtcd6l3zbpxMf1Z5DY7ELZ3
756hHQREMKlSm18CdHPijKDcgSKC2BZUvki2p6ALyr2tdLs4kmOex2DMd6BXuKkP
EyiUtIhUfDd40PF/6B5uJlevGCEJ5UVs/Ix1zfKe03j0DEsZhBg127XpBxsOn2xf
zaE5uv/60fjaZmQgLZYrnMiIYbbtRdBPSYS+BvlUmYycW9imkttNmpce9+nOWTo/
FEUAWvqXGGBwXkCTLeX3F2AB4i6EZ+8Paw8xN7TAgU5mvQ7R1pP/tnd1cJnVZPo=
=hZPO
-----END PGP SIGNATURE-----

