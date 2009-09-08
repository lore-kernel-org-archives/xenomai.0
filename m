Message-ID: <4AA6BC5D.8020704@domain.hid>
Date: Tue, 08 Sep 2009 22:19:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0909081259o47b0fcb7k46f679e7dfe83456@domain.hid>
In-Reply-To: <7a15153d0909081259o47b0fcb7k46f679e7dfe83456@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High Latency on PXA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

Felipe Castro wrote:
> Spam detection software, running on the system "xenomai.org", has
> identified this incoming email as possible spam.  The original message
> has been attached to this so you can view it (if it isn't spam) or label
> similar future email.  If you have any questions, see
> the administrator of that system for details.

> 
> Content preview:  I'm running Xenomai 2.4.8 with kernel 2.6.27 on a Voipac development
>    kit with PXA270 processor. Once applied a patch (Thanks Giles) everythink
>    looks to run ok , but running the latency test program i got: [...] 
> 
> Content analysis details:   (4.8 points, 4.5 required)
> 
>  pts rule name              description
> ---- ---------------------- --------------------------------------------------
>  1.1 URIBL_RHS_DOB          Contains an URI of a new domain (Day Old Bread)
>                             [URIs: gna.org]
>  2.0 HTML_MESSAGE           BODY: HTML included in message
>  1.8 MIME_BASE64_TEXT       RAW: Message text disguised using base64 encoding
> 
> The original message was not completely plain text, and may be unsafe to
> open with some email clients; in particular, it may contain a virus,
> or confirm that your address can receive spam.  If you wish to view
> it, it may be safer to save it to a file and open it with an editor.
> 

Please avoid sending messages which look like spam, you will get faster
responses since I do read my spam box only once a day.

> I'm running Xenomai 2.4.8 with kernel 2.6.27 on a Voipac development kit
> with PXA270 processor.

Please switch to Xenomai 2.4.9.1.

> 
> Once applied a patch (Thanks Giles) everythink looks to run ok , but running
> the latency test program i got:

All patches have been included in 2.4.9.1. What is your status with
regard to floating points? Are you compiling with -msoft-float? It is
mandatory on PXA.


-- 
					    Gilles.

