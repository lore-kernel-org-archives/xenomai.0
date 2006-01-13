Message-ID: <43C765E0.4030407@domain.hid>
Date: Fri, 13 Jan 2006 09:33:36 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Xenomai broken on Linux 2.4
References: <20060113011449.E32C7353CCD@atlas.denx.de>
In-Reply-To: <20060113011449.E32C7353CCD@atlas.denx.de>
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
> Dear Philippe,
> 
> in message <43C6D2F5.2050607@domain.hid> you wrote:
> 
>>We try to find a way to wrap class_device_create properly depending on the kernel 
>>version Xeno is compiled against. The parent device class argument in this call 
>>(2nd in order) seems to show up in 2.6.15 for kernel.org, but 2.6.14-denx-git has 
>>it too. So we have a problem relying on the version sublevel.
> 
> 
> I see. Well, I feel honored, but the reference in such  cases  should
> always be Linus' tree (i. e. the "official" kernel.org tree). Xenomai
> cannot  and  should  not  have  to be considerate of all the N vendor
> kernel trees that exist out there in the wild...
> 
> And if some user should use our old 2.6.14 tree and run into problems
> we can just tell him to use  current  code  -  so  no  problem  here,
> either.
> 
> Please use kernel.org as reference (and  remember  that  decision  in
> case other vendors should come urging you).

Philippe, for some (yet) unknown reasons the trees are not in sync but 
they should in respect to include/linux/device.h. Well, lets simply 
ignore this problem for Xenomai.

Thanks.

Wolfgang.

> Best regards,
> 
> Wolfgang Denk
> 


