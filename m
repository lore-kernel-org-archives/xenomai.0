MIME-Version: 1.0
Date: Tue, 17 Feb 2009 14:13:30 +0000
From: =?UTF-8?Q?Gwenha=C3=ABl?= <gwen@domain.hid>
In-Reply-To: <499A8E53.303@domain.hid>
References: <20090217094750.46fb937d@domain.hid> <499A8E53.303@domain.hid>
Message-ID: <0d559346cf77157cb52c39a05fc23429@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] I.MXL won't boot after patching with
 adeos-ipipe-2.6.27-arm-1.12-00.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org


On Tue, 17 Feb 2009 10:15:47 +0000, Gilles Chanteperdrix=0D
<gilles.chanteperdrix@xenomai.org> wrote:=0D
> gwenhael.goavec wrote:=0D
>> Hello,=0D
>> =0D
>> I wish to test adeos and Xenomai on Arm9 I.MXL(MC9328) based=0D
>> platform. I have already tested with linux-2.6.26.5 and=0D
>> linux-2.6.24.3. Ipipe worked fine and the system has booted=0D
>> correctly.=0D
>> But with linux-2.6.27.13 and others 2.6.27.XX System=0D
>> won't boot. The last message I have is : =0D
>> =0D
>> BIOS> boot                                                            =
  =0D
=0D
>>=0D
>> ## Booting kernel from Legacy Image at 100a0000 ...=0D
>>    Image Name:   Linux-2.6.27.13                   =0D
>>    Created:      2009-02-16  21:03:08 UTC=0D
>>    Image Type:   ARM Linux Kernel Image (uncompressed)=0D
>>    Data Size:    1329204 Bytes =3D  1.3 MB              =0D
>>    Load Address: 08008000               =0D
>>    Entry Point:  08008000=0D
>>    Verifying Checksum ... OK=0D
>>    Loading Kernel Image ... OK=0D
>> OK                            =0D
>>   =0D
>> Starting kernel ...=0D
>>                    =0D
>> Uncompressing=0D
>>=0D
Linux....................................................................=
...................=0D
>> done, booting the kernel.=0D
>> =0D
>> kernel_start() is never called.=0D
>> =0D
>> However, when CONFIG_IPIPE is not active, the system works=0D
>> well!=0D
>> =0D
>> Do someone have the same problem ?=0D
>> What is the solution for having  linux-2.6.27 working=0D
>> with this processor ?=0D
>> Thank you very much.=0D
> =0D
> What exactly is the support selected in the Linux kernel for this=0D
> processor? Could you try the printascii in printk trick to see exactly=0D
> where the boot fails?=0D
=0D
I have selected IMX for the processor type.=0D
=0D
I have applied the printk trick but I have no new informations on the=0D
terminal. The problem seems to being between decompress_kernel() and=0D
start_kernel().=0D
=0D
Gwenha=C3=ABl=0D
=0D


