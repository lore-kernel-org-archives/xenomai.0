Message-ID: <499C5BB4.2070003@domain.hid>
Date: Wed, 18 Feb 2009 20:04:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B2EEE69E41E524EB7FCDC62A15D68D80308F137@domain.hid>	<499572C2.3060609@domain.hid>	<49957D23.4040806@domain.hid>	<4B2EEE69E41E524EB7FCDC62A15D68D8030CCF0F@ARVMAIL1.mra.roland-man.biz>	<499C1749.7040804@domain.hid>	<4B2EEE69E41E524EB7FCDC62A15D68D8030CCF23@domain.hid>	<499C1BD6.3010909@domain.hid>
	<499C5A63.8060309@domain.hid>
In-Reply-To: <499C5A63.8060309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> Wolfgang Grandegger wrote:
>> thomas.debes@domain.hid wrote:
>>> Unfortunately I don't have a newer kernel, I will talk to Wolfgang Grandegger, maybe he can do a short test with my formerly attached sample application.
>> I will try it out on my TQM5200 board later today or tomorrow.
> 
> With I-Pipe v2.4-03, Xenomai v2.5-devel (SVN revision 4519) and Linux
> 2.6.26 on my TQM85200 I get:
> 
>   -bash-3.2# ./fpu-exception-test
>   Floating point exception
> 
>   -bash-3.2# dmesg|tail
>   ...
>   Xenomai: Switching trivial to secondary mode after
>   exception #1792 from user-space at 0x10001840 (pid 1127)
> 
> Is that the expected behavior?
>

Yes.

> Wolfgang.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

