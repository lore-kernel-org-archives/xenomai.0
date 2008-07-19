Message-ID: <4881F602.9020800@domain.hid>
Date: Sat, 19 Jul 2008 16:11:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <3451.132.206.72.194.1216322618.squirrel@domain.hid>
In-Reply-To: <3451.132.206.72.194.1216322618.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Freeze on system()/fork() call (xenomai 2.4.4)
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
To: vleves@domain.hid
Cc: xenomai@xenomai.org

vleves@domain.hid wrote:
> Hello,
> 
> A few months ago I reported that my installation of xenomai 2.4.2 would
> freeze when calling fork() or system() under certain conditions:
> 
> https://mail.gna.org/public/xenomai-help/2008-04/msg00002.html
> 
> Gilles Chanteperdrix gave me a patch that seemed to resolve the issue. I
> now tried to upgrade to Xenomai 2.4.4 and it seems to suffer from the same
> problem. Is this issue expected to be resolved in the near future or
> should I look for a permanent work-around in my programs?
>

This was not a Xenomai issue, but an Adeos one.

Assuming that your arch is x86, Gilles's fix was merged back in April:
http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.24-x86-2.0-05.patch

The latest update for the 2.6.24 baseline you may want to grab is this one:
http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.24-x86-2.0-08.patch

You may also want to have a look at the Xenomai FAQ about picking the proper
I-pipe patch for any given Xenomai release:
http://www.xenomai.org/index.php/FAQs

> Thank you,
> 
> Vincent Levesque
> vleves@domain.hid
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

