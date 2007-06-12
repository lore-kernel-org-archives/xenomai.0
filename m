From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <96878dcb0706121330v629fdd0fu629bd8a91c8b3588@domain.hid>
References: <96878dcb0706121330v629fdd0fu629bd8a91c8b3588@domain.hid>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 21:57:01 +0200
Message-Id: <1181678222.6792.28.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] ADA support in xenomai
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
To: Markus Lang <snapper.ml@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-06-12 at 22:30 +0200, Markus Lang wrote:
> Hi,
> 
> I am interested in using xenomai as a RTOS but I have a key question
> unresolved after reading some xenomai documentation:
> 
> -  Is it possible to use ADA to develop software over xenomai?
> 

We only provide C libraries to interface with the RTOS, people here are
C/C++ biased (the most evil among us even practice assembly language).
The good news is that those (user-space) libs are made of globally
visible items from an Ada POV, so you could probably create a set of
function interfaces using the appropriate pragma directives to import
them into your Ada environment.

> Regards,
> Markus.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



