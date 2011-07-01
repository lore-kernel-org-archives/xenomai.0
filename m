Message-ID: <4E0D7DE7.50803@domain.hid>
Date: Fri, 01 Jul 2011 09:57:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201106301212.47433.carlosnov@domain.hid>
In-Reply-To: <201106301212.47433.carlosnov@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Writing a new driver,
 shoud use message pipes or shared memory?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Cc: xenomai@xenomai.org

On 06/30/2011 05:12 PM, Carlos Eduardo de Brito Novaes wrote:
> Hello all!
> Hope this question fits to the scope of the list.
> 
> I got a PCI acquisition board and wish to write a xenomai driver for it. I had 
> did this before with an old ISA board and used memory heaps to exchange data 
> from kernel (configuration and mainly acquisition routines) and the real time 
> processing task.
> 
> Now, I would like to know if I can use only message pipes for this kind of 
> application. I would like to use it so the entire proccess became more "unix 
> like", using memory heaps I think that the internals of the driver are exposed 
> and the any misfuncion can arise due to bad data passed from programmers. Is 
> this right?
> 
> Can message pipes provide hard real time timings, about 1K/10K samples per 
> second and about 100 bytes on each sample?

Hi,

you probably should use the RTDM skin to write a driver. So, use the
"read" call to get data, or if there is a big volume, use some mmaped
aread, using rtdm_mmap_to_user.

Regards.

-- 
                                                                Gilles.

