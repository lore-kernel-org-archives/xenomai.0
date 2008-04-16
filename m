Message-ID: <48063B79.8060609@domain.hid>
Date: Wed, 16 Apr 2008 19:46:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <480638DF.1090107@domain.hid>
In-Reply-To: <480638DF.1090107@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] xnintr* calls from user space tasks
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Tomas Kalibera wrote:
> Hi,
> 
> the API documentation says that xnintr* calls (like xnintr_init, 
> _enable, _disable, and other) can be called from user space tasks. Is it 
> a bug in the documentation ? Or is it somehow possible ?
>

Paste&Copy issue. This is strictly a kernel interface, although rt_intr_enable()
and friends end up calling them, but from kernel space.

> Thanks,
> Tomas
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

