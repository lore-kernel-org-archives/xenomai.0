Message-ID: <49BFC742.8010409@domain.hid>
Date: Tue, 17 Mar 2009 16:52:34 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE200513A0636F@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE200513A0636F@us194mx002.tycoelectronics.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Port rtai rt_request_srq to xenomai
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Charlton, John wrote:
> I am porting an rtai linux 2.4 kernel driver to xenomai-2.4.6.1 patched linux 2.26.27.7 kernel.  I have done a fair amount of searching for the rtai functions: rt_request_srq()/rt_free_srq() and have not found an equivalent in xenomai. Would appreciate advice on how this can be done in xenomai or if the equivalent of this is not available in xenomai. It looks like rthal_apc_alloc() may be what I am looking for.
>

It is indeed what you are looking for, if you want a 1:1 replacement. However, 
you may also want to consider porting your driver code over the RTDM framework, 
and use the rtdm_nrtsig support:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__rtdmirq.html

> --John
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

