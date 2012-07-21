Message-ID: <500B364F.4030905@xenomai.org>
Date: Sun, 22 Jul 2012 01:07:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658301CBE3DF@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<500B2F9F.8020602@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3E0@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658301CBE3E0@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] switching domains at will
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Jorge Ramirez Ortiz, HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/22/2012 01:01 AM, Jorge Ramirez Ortiz, HCL Europe wrote:
> a user task example: a Xenomai thread calls into an RTDM ioctl_rt
> which it is better handled in non-rt since it needs to use some linux
> services. So at the RTDM ioctl I can issue -ENOSYS. When the call
> returns to userland, the task is in secondary mode - but now I need
> to issue now an ioctl_rt.

Use the same trick: return -ENOSYS in the ioctl_nrt, it works both ways.

> pthread_setschedparam seems to do the trick
> but I'd like to make sure that this is a reliable way of doing it.

No, it is a useless syscall.

> 
> yes I remember that one :). I am just doing a code clean up and
> adding some consistency..

Please:
- no top posting
- wrap your lines around 80 or 72 columns
- remove the disclaimer

-- 
                                                                Gilles.

