Message-ID: <4A9E8437.80900@domain.hid>
Date: Wed, 02 Sep 2009 16:41:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0909021159100.22914@domain.hid>	<4A9E3AAB.2070404@domain.hid>	<Pine.LNX.4.64.0909021233110.22914@domain.hid>	<4A9E4D84.20602@domain.hid>	<Pine.LNX.4.64.0909021359060.22914@domain.hid>	<4A9E5424.9070500@domain.hid>	<Pine.LNX.4.64.0909021418300.22914@domain.hid>	<4A9E5917.8060200@domain.hid>	<Pine.LNX.4.64.0909021441160.22914@domain.hid>	<1251895278.3205.190.camel@domain.hid>
	<Pine.LNX.4.64.0909021611170.22914@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0909021611170.22914@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Deprecated kernel system calls in xenomai-head
 and new application development paradigm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Rus V. Brushkoff wrote:
> On Wed, 2 Sep 2009, Philippe Gerum wrote:
> 
> :>  Next - I do not 
> :> understand why the previous model lets the _developer_ itself decide 
> :> which of the application tasks will be running in kernel and which will 
> :> be running in user space. The current model left the people without any 
> :> choice. So the current model itself decided instead of developer what is 
> :> better - I think this is wrong.
> :
> :With that kind of reasoning, you would keep on coding your RT
> :application fully in kernel space, but we made some progress since 1997,
> :fortunately.
> 
>  Sorry, but device drivers for hardware that need RT processing can't be 
> written in user space. Dealing with interrupts, PCI, DMA, I/O ports can 
> be done only in kernel space. So it is not possible to decide at the 
> Xenomai architect level wich driver task are optimal to run in which mode 
> - it will depends from the particular development problem area.
>  So I think that forcing people to write the RT tasks only in user space 
> will make unneded latencies, which will be inserted by data passing 
> between user and kernel domains.
>  Next: the traditional and clean Unix programming concept suppose that 
> user space applications are simple and operate on the files/pipes that 
> are attached to kernel drivers. It will be better to leave this concept 
> live as it proved its architect efficiency.

You misunderstand us. We tell you that you should develop drivers in
kernel-space, using the RTDM skin. The RTDM skin is made to resemble the
Linux driver model, so that it will make your drivers easily portable to
vanilla linux.


-- 
                                          Gilles


