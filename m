From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <64f64b850910310221v2148ed6dqc4a05ccd8ec7030f@domain.hid>
References: <64f64b850910310221v2148ed6dqc4a05ccd8ec7030f@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Nov 2009 18:08:38 +0100
Message-ID: <1257181718.2065.620.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] queue on the uclinux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Romannikov <rom2006@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2009-10-31 at 15:21 +0600, Dmitry Romannikov wrote:
> Hello!
> 
> I've have problem with queues on the uclinux. queue was created
> without errors (returned zero) (queue was created in the kernel
> space), but I cannot bind it in user space (always returned -12 -
> cannot allocate memory). the same story with heap. 
> I use uClinux 2009R1, bf537 and xenomai 2.4.7.

Commit 59ba07f8 from git://xenomai.org/xenomai-2.4.git
fixes the issue.

> 
> best regards,
> Dmitry Romannikov.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



