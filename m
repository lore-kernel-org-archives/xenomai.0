Subject: Re: Xenomai RTnet - Kernel module not loading
References: <2eb86315-dc9d-1096-14a7-c3bd2b32a668@b-tu.de>
 <1021522818.445580.1582639862351.JavaMail.zimbra@wolfram.com>
 <cb174dde-7680-ba74-9aca-7da7adc870dc@b-tu.de>
 <984885226.450915.1582641841732.JavaMail.zimbra@wolfram.com>
 <1987057484.452222.1582642123490.JavaMail.zimbra@wolfram.com>
 <6a5fc541-8519-56d0-f4b4-c7e29f4b38f3@b-tu.de>
 <1253430772.456171.1582643215737.JavaMail.zimbra@wolfram.com>
 <d6b19aa8-c978-617c-bb85-335634e47ac1@b-tu.de>
 <1294487288.461675.1582644685411.JavaMail.zimbra@wolfram.com>
 <cbce49c7-0cca-73de-bc4f-bb4efd29b7d7@b-tu.de>
 <CALLqZ8R3rKRUyvqyVcG18ovxVTniU6SiCGRi0_nKQ0z4kp1QSA@mail.gmail.com>
From: Benji <miethben@b-tu.de>
Message-ID: <64403b82-a520-35c7-f406-d3de98cb453d@b-tu.de>
Date: Thu, 27 Feb 2020 19:51:37 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8R3rKRUyvqyVcG18ovxVTniU6SiCGRi0_nKQ0z4kp1QSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 2/27/20 4:51 PM, Greg Gallagher wrote:
>>>> I thought system is running on cobalt kernel. But looks like there i=
s an
>>>> initialisation error. What is meaning of error code -19?
>>>
>>>>> $ dmesg | grep Xenomai
>>>>> [ 8.543295] [Xenomai] scheduling class idle registered.
>>>>> [ 8.543302] [Xenomai] scheduling class rt registered.
>>>>> [ 8.543333] [Xenomai] init failed, code -19
>>>
>>> I haven't seen that one myself. But check out:
>>>
>>> https://xenomai.org/pipermail/xenomai/2015-September/thread.html#3506=
6
>>>
>>> and
>>>
>>> https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Troubleshooting#no-tim=
er
>>>
>>> (Although i see the in-page link is broken check the section about ti=
mers)
>>>
>>>
>>> Per =C3=96berg
>>>
>> Hi,
>>
>> the hint was in the right direction. There is something strange in my
>> build process. In kernel configuration i disable options described in
>> Xenomai Wiki (like CPU_FREQ, KGDB..). After running 'make bzImage
>> modules' and checking .config file, disabled option are enabled again.
>>
>> Are there dependencies to force enable these option without notice?
>>
>> Thanks
>> Benji
>>
> Did you use menuconfig? I use menuconfig to disable those options and
> it makes it very clear if there are other options that need to be
> disabled as well.
>=20
> -Greg
>=20

I use menuconfig. But some options can't be disabled like CPU_FREQ or
page migration. You're right there are warning about enabled options but
as i said they can't be disable. So i edit .config file manually to meet
requirement from Xenomai wiki.

Can somebody provide me a working configuration for x86_64 architecture?


Benji

