Message-ID: <4CB36658.5000200@domain.hid>
Date: Mon, 11 Oct 2010 21:32:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CB35360.6080003@domain.hid>
	<4CB36314.6090109@domain.hid>
	<4CB36627.5040602@domain.hid>
In-Reply-To: <4CB36627.5040602@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_io_get_region
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roger Carns <rpcarns@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Roger Carns wrote:
> 
> On 10/11/2010 3:18 PM, Gilles Chanteperdrix wrote:
>> Roger Carns wrote:
>>> Does rt_io_get_region function be called from user space and does
>>> it return a user space address and if so how is it return? Also
>>> is there doc out there someplace on usage of this function.
>> rt_io_get_region is a user-space mapping of 
>> request_mem_regio/request_io_region. As such, yes, it may be called
>> from user-space. And no, it does not return address. What it
>> returns is a cookie that may be passed to rt_io_put_region to free
>> the used memory.
>> 
>> In order to map an MMIO region in user-space you should use
>> /dev/mem or use ioperm and inl/outl directly if you want to access
>> an I/O port. What rt_io_get_region does is to allow you to this
>> cleanly with regard to the rest of the system.
>> 
> So, I open the /dev/mem and use the fd returned on the mmap call. But
> how do I associate the region defined in the rt_io_get_region with
> that fd?

The offset passed to mmap is the physical address which you want to map.

Please do not forget to CC the maling list.

-- 
                                                                Gilles.

