Message-ID: <461DF8E0.5090302@domain.hid>
Date: Thu, 12 Apr 2007 11:16:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1HbvKK-0004uq-HB@gna.org>
In-Reply-To: <E1HbvKK-0004uq-HB@gna.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai suspends my kernel thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Branko <branko.kolasinovic@domain.hid>
Cc: xenomai@xenomai.org

Branko wrote:
> Hello all!
> 
>  
> 
> I would be most grateful for your help.
> 
>  
> 
> I ported my PowerPC GNU/Linux C/C++ application to Xenomai.
> 
> When I ran the application everything looked fine.
> 
> However, with more intense data exchange, one of my interrupt handler
> threads did not react any longer.
> 
> I looked at the /var/log/messages file and I saw that Xenomai suspended
> my thread due to the exception 768.
> 
>  
> 
> According to
> https://mail.gna.org/public/xenomai-help/2006-11/msg00233.html I
> disabled CONFIG_XENO_OPT_DEBUG
> 
> from my kernel configuration, but the behaviour of my application did
> not change.
> 
>  
> 
> Please find my kernel configuration bellow.
> 
>  
> 
> Looking forward to receiving your suggestions.

What version of Xenomai do you use ? Does your application use fork ? If
yes, then you should switch to Xenomai 2.3.1.

-- 
                                                 Gilles Chanteperdrix

