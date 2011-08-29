Message-ID: <4E5B76E2.1090803@domain.hid>
Date: Mon, 29 Aug 2011 13:24:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHoMn5qyUPgGBk+gKQsLweYb1UixJKVk6si9P4YLiOAstL_2XQ@mail.gmail.com>
In-Reply-To: <CAHoMn5qyUPgGBk+gKQsLweYb1UixJKVk6si9P4YLiOAstL_2XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] how to use rt_io_get_region function on
 AT91SAM9263 in user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: yi zheng <yizheng23@domain.hid>
Cc: xenomai@xenomai.org

On 08/29/2011 09:43 AM, yi zheng wrote:
>    Hi,all
>      I want to write a Xenomai application running in user space that can
> access the
> GPIO pins of my AT91SAM9263 ARM. To get the memory
> region I found the function rt_misc_get_io_region(). Unfortunately
> there is no discription of this function in the API documentation.
> Does this function work like request_mem_region()?

Yes, it allows user-space access to request_mem_region. So, in addition
to this, you should do the usual mmap(/dev/mem) dance. However, it is
probably better to write an RTDM driver using linux gpiolib. This way,
you get mutual exclusion between linux and xenomai.

-- 
                                                                Gilles.

