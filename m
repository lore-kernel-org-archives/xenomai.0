Message-ID: <4B0423EF.9030307@domain.hid>
Date: Wed, 18 Nov 2009 17:42:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>	<4AF99CAD.9070105@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD107D@troe2k1.cs.myharris.net>	<4AF9AD44.10000@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD1085@domain.hid>	<4AF9B6F2.9040206@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD10A9@domain.hid>	<4AF9D976.4020701@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD1129@domain.hid>	<4AFAC4E1.1090109@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48FD17F8@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F48FD17F8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm_iomap_to_user with phys addr > 4G
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

Herrera-Bendezu, Luis wrote:
> Jan,
> 
>> I think we can change rtdm_iomap_to_user to take src_addr as 
>> phys_addr_t
>> and propagate this internally properly. We also need to add a wrapper
>> for phys_addr_t for kernels that doesn't support this (<2.6.28). To my
>> current understanding, this should be sufficient, right?
>>
> 
> This is a diff against Xenomai version 2.4.8 and Linux version 2.6.28 to
> handle RTDM mapping to user space of devices located at addresses > 4
> GB.

Does it apply against git-head as well? Note that this won't make it
into stable 2.4.

> Rather than modifying existing rtdm_iomap_to_user() API a new one is
> added, rtdm_iomap_to_user64() (to mimic mmap64()). Since this is a user
> API it can not use phys_addr_t so unsigned long long is used for the
> interface.

64 bit is not related to phys_addr_t. It /may/ be 64 bit, but it may
also be less (or more one day...?). So let's switch the existing
interface, just like the kernel does.

And it is not a user API; it is used between the driver and RTDM only.
How the driver deals with this in its user interface is a different
story. I think there is currently no publicly available driver that maps
I/O space into a user application, thus there is probably no stable RTDM
profile that uses unsigned long to specify a physical address.

> 
> I tried to use rtdm_iomap_to_user() on a kernel module initialization
> section of my RTDM driver and passing NULL to user_info argument. This
> causes an invalid memory access and system panic. How can this
> function be called from kernel intialization code?

Not at all. It is supposed to be called on behalf of a user application,
asking the driver to map some area into its address space. Then you have
a valid user_info at hand.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

