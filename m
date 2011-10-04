From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <CAAXf6LWD9VfTLz-o9My1CM1A=MfaZt_EKoXMYrMwRPopfVE5Tg@domain.hid>
References: <CAAXf6LWD9VfTLz-o9My1CM1A=MfaZt_EKoXMYrMwRPopfVE5Tg@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 Oct 2011 12:00:15 +0200
Message-ID: <1317722415.2082.50.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai-forge: enable-smp useful?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Cc: Xenomai-help@domain.hid

On Tue, 2011-10-04 at 11:49 +0200, Thomas De Schampheleire wrote:
> Hi,
> 
> The original Xenomai userland had to be configured explicitly with
> --enable-smp if the kernel was SMP capable. The xenomai-forge
> configure script still accepts this parameter.
> 
> Are we correctly assuming that this flag is no longer needed for xenomai-forge?

This has been inherited from Xenomai 2.x. This flag is accepted whenever
you want to compile for the Cobalt core (i.e. the dual kernel mode), in
which case it is used as a hint for internal tuning. But since you run
over the Mercury core in single image mode, it is useless so far.

> 
> Thanks,
> Thomas
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



