Message-ID: <4FFFCDD4.2000909@xenomai.org>
Date: Fri, 13 Jul 2012 09:27:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658301CBE3B9@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE189C.7060504@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE8B7C.60506@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3C2@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658301CBE3C2@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai -
 switching to ROOT
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

On 07/12/2012 11:29 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
>>>> [  242.962195] BUG: Unhandled exception over domain Xenomai at 0x892160 - switching to ROOT                                                       

Weird message, I can not seem to find it in xenomai sources. Anyway the
message indicates that you should look at what is at 0x892160

>  The interrupt notifier is a wait queue in the non-realtime path of
> the RTDM driver. Events are raised from the RTDM interrupt handler to
> notify the sleeping threads.

You mean you are calling something like "wake_up" from a real-time
interrupt ? If this is what you are doing it can not work for obvious
reasons.

If you want to do that, you should use an rtdm_nrtsig object. Use
rtdm_nrtsig_pend in the interrupt handler, and call wake_up in the
nrtsig_handler.

-- 
                                                                Gilles.

