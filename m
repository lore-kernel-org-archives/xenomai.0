Message-ID: <4A3F8D37.2040908@domain.hid>
Date: Mon, 22 Jun 2009 15:55:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <634c78ce0906120240t694ded8cpfa7fcd9dfb2c3b8@domain.hid>	<200906121148.37732.smolorz@domain.hid>	<4A3235BF.5090201@domain.hid>
	<4A324D3D.9060505@domain.hid>	<4A325189.5060905@domain.hid>
	<4A3253DB.5040109@domain.hid> <4A32674C.7060007@domain.hid>
	<D39BC4B7B612C6428144D37C54379A2F01A24CC99631@domain.hid>
In-Reply-To: <D39BC4B7B612C6428144D37C54379A2F01A24CC99631@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running Xenomai in a virtual machine
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

ROSSIER Daniel wrote:
> Just going through this interesting thread, I though it might be of interest - probably not fully related to the topic, but... - to know
> that we are currently working on some integration efforts of Xenomai on top of the XEN hypervisor in the context of the
> embeddedXEN project. For the time being, it is purely devoted to ARM-based processors.
> 
> In case of interest, please visit: https://sourceforge.net/projects/embeddedxen. Xenomai will appear as a natural subtree of embeddedXEN, like xen or minios,
> but currently it is not present yet. The hypervisor and miniOS boots up in Mainstone/QEMU and soon on a Colibri/PXA270 board. EmbeddedXEN is mainly devoted to integrate multiple kernels into a single binary image for embedded systems with the support of hard realtime (domainU-RT, a new kind of Xen domain).

Interesting, will have a look (again). Last time I checked was two years
ago when MontaVista (IIRC) announced it. Does/will this version Xen not
suffer from the RT problems Xen upstream has, e.g. lacking preemptibility?

And what will be the impact on Xenomai? A new sub-arch per real arch?
Will Xenomai run stand-alone or together with a Linux kernel as on real
silicon? In the former case, what will be the programming model,
specifically regarding RT<->non-RT communication?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

