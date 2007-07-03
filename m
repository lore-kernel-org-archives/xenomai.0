Message-ID: <468AA923.8030406@domain.hid>
Date: Tue, 03 Jul 2007 12:53:07 -0700
From: Jeff Koftinoff <jeffk@domain.hid>
MIME-Version: 1.0
References: <4688E0BD.40709@domain.hid>	<1183377266.19565.14.camel@domain.hid>
	<4689092B.6020903@domain.hid>
	<1183387687.19565.56.camel@domain.hid>
In-Reply-To: <1183387687.19565.56.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-help@domain.hid

Philippe Gerum wrote:
> In such a case, you have likely hit an illustration of the latter issue
> which the I-pipe/ppc implementation still suffers from: some page table
> entries are missed during real-time operations. As a consequence of
> this, the nucleus catches page faults on behalf of RT threads in primary
> mode, then switches these threads back to secondary in order to process
> the faults, and eventually wire the missing PTEs in. This is something
> calling mlockall() does not prevent the application from (like COW).
>
> The shared lib problem would be another issue, even if it relates to the
> same general topic (i.e. lazy/on-demand mapping of memory resources the
> kernel performs).
>
>   
Hi Philippe.

Very soon I am going to be using Xenomai on PPC with SMP...

Under what situations are 'page table entries missed'? what exactly does 
that mean?

Regards,
Jeff Koftinoff

www.jdkoftinoff.com


