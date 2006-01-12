Message-ID: <43C6D2F5.2050607@domain.hid>
Date: Thu, 12 Jan 2006 23:06:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Xenomai broken on Linux 2.4
References: <20060112215453.78FD335262C@atlas.denx.de>
In-Reply-To: <20060112215453.78FD335262C@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Denk wrote:
> In message <43C6B428.2040506@domain.hid> you wrote:
> 
>>Well, our 2.6 tree is based on the offical 2.6 tree. Don't know where 
>>the difference come from. Maybe Wolfgang can help (he is now on CC).
> 
> 
> I'm subscribed, too.
> 
> We added some patches (especially 4xx network driver related) to  our
> tree long before they were accepted and merged into Linus' tree.
> 
> Does this answer the question? [Or what exactly is the problem?]
>

We try to find a way to wrap class_device_create properly depending on the kernel 
version Xeno is compiled against. The parent device class argument in this call 
(2nd in order) seems to show up in 2.6.15 for kernel.org, but 2.6.14-denx-git has 
it too. So we have a problem relying on the version sublevel.

> Best regards,
> 
> Wolfgang Denk
> 


-- 

Philippe.

