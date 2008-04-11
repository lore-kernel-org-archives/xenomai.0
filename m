Message-ID: <47FF019B.5070200@domain.hid>
Date: Fri, 11 Apr 2008 08:13:47 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <a7575bba0804100325k245d9741mce3d33a360df799e@domain.hid>	<47FE5B79.9080506@domain.hid>
	<a7575bba0804101814o9bd5a9aobd9ecf4c42d90da9@domain.hid>
In-Reply-To: <a7575bba0804101814o9bd5a9aobd9ecf4c42d90da9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main] RTDM without mmap
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Josh Zhao <joshsystem@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

Josh Zhao wrote:
> Thanks.
>    So you mean I have to invoke  ipipe api directly in xenomai?
>   

No, if you look at the driver code you will see that this is a 
"standard" Linux driver, with the regular mmap handling, and not a 
Xenomai/RTDM driver. The only difference with a between this driver and 
a regular Linux driver is the fact that IPIPE is used for interrupt 
handling.

> 2008/4/11, Hannes Mayer <h.mayer@domain.hid>:
>   
>> Josh Zhao wrote:
>>     
>>> Hi all,
>>>       I want to write mmap driver for spending up to exchange data
>>> between kernel and user,but i havn't seen the mmap field in RTDM
>>>       
>> structure.
>>
>>
>> http://www.captain.at/adeos-ipipe-device-driver-mmap.php :-)
>>     

Regards,
    Johan

