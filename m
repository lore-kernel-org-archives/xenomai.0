Message-ID: <4D3485AC.3070500@domain.hid>
Date: Mon, 17 Jan 2011 19:08:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <007901cbb667$db66b860$92342920$@innovative-dsp.com>
In-Reply-To: <007901cbb667$db66b860$92342920$@innovative-dsp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai mmap
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Hua <Phua@domain.hid>
Cc: xenomai@xenomai.org, pwfhua@domain.hid

Peter Hua wrote:
> Is there any example code to map PCI registers into user space?  I am having
> problem getting functions rtdm_iomap_to_user and mmap to compile.   My code
> is attached.  
> 
>  
> 
> Xenomai - 2.4.10
> 
> Kernel - 2.6.29.1
> 
> OS - Red Hat 5.5

You will find the documentation of Xenomai 2.4.10 API here:
http://www.xenomai.org/documentation/xenomai-2.4/html/api/index.html

As you can see, it has no rtdm_iomap_to_user funtion.

-- 
                                                                Gilles.

