Message-Id: <CDF892E1-C135-4301-B531-A16F1525B99C@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <200903271617.42331.pwaechtler@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Fri, 27 Mar 2009 11:31:22 -0400
References: <200903271538.10434.pwaechtler@domain.hid>
	<943F8CE6-B103-4ED5-99CA-29F84AD90593@domain.hid>
	<200903271617.42331.pwaechtler@domain.hid>
Subject: Re: [Xenomai-core] use case: possible to boot Posix subsystem in
	<50ms and then Linux?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: pwaechtler@domain.hid
Cc: xenomai@xenomai.org

> Well the hardware should not matter and the startup code should be  
> finished in
> several milli seconds, of course.
> Most probably are ARM. PPC or SH4 platforms used in automotive  
> devices.
>
> In the automation industry the boot time is not that important -  
> therefore a
> lot of PC compatible boards are used.

The reason I ask about the hardware is so that I can figure out if you  
are trying to boot a standard PC in that amount time or not. I don't  
know your level of understanding in these matters so that's why I ask  
for more information. I was the MIPS maintainer on RTAI for a couple  
of years, and we had a very wimpy MIPS board and it would boot up and  
start our application in about 2 seconds. Now, with the kernel  
executing in place that time was significantly lower but ROM access  
was very slow and this affected realtime performance. That's why I had  
to go with copying the kernel to RAM. If I recall it would boot up in  
under a second, but that's significantly more time than the 50ms you  
are asking about.

On the other hand that really was a weak chip. 66MHz VR4181. Ugh. We  
mainly wanted it for the low power draw.

Gilles pointed out that you could start a kernel based xenomai  
application fairly early but userspace support takes more time to get  
up. If you really want to get a fast boot time then try to link your  
kernel to execute in place if the hardware supports it.

Steven


Steven


