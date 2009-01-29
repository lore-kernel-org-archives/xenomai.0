Message-ID: <49817444.6030901@domain.hid>
Date: Thu, 29 Jan 2009 10:17:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200901282113.48357.carlosnov@domain.hid>	<49816058.6080704@domain.hid>
	<200901290714.15951.carlosnov@domain.hid>
In-Reply-To: <200901290714.15951.carlosnov@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] proc interface isn't created
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
To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Cc: xenomai@xenomai.org

Carlos Novaes wrote:
> Em Thursday 29 January 2009 05:52:56 Gilles Chanteperdrix escreveu:
> Virtual file system proc is mounted, investigating I found out that /proc/ipipe 
> registered Linux interface, but not Xenomai:
> ====

Xenomai did not boot then. What does you bootlog say?

> $: ls /proc/
> Linux 
> version
> ====
> attached is my .config
> 
> 
>> Is /proc mounted ?
>> Otherwise, please send us your .config.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

