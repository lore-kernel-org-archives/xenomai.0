Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4BA2C094.6060109@domain.hid>
Date: Fri, 19 Mar 2010 01:08:52 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4B991999.1070406@domain.hid> <4BA0E8D9.4060901@domain.hid>
In-Reply-To: <4BA0E8D9.4060901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Analogy a4l_ioctl_bufinfo() bug?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Daniele Nicolodi wrote:
> Daniele Nicolodi wrote:
>> Hello. As reported in the xenomai-help mailing list I'm investigating
>> why a4l_mmap() is not supported for the ni pcimio driver. Hacking on the
>> driver I discovered that, apparently, the only problem in supporting
>> mmap of the device buffer is in the a4l_ioctl_bufinfo() function.
> 
> The atached patch solves the problem. My solution is to avoid to mess
> with the subdevice buffer if a transmission is not occouring. This makes
> ni pcimio driver work as expected. The second patch enables mmapping for
> the ni pcimio driver.
Merged. Thank you.
> 
> Cheers,
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

Alexis.

