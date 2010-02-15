From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B79A113.2020300@domain.hid>
References: <4B79A113.2020300@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Feb 2010 20:48:05 +0100
Message-ID: <1266263285.2375.141.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] bug: patch support for intel atom n270
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Chris Cole <clecol@domain.hid>
Cc: adeos-main@gna.org

On Mon, 2010-02-15 at 14:31 -0500, Chris Cole wrote:
> Hello all,
> This is my first time on this list. I've been using RTAI (and the Adeos 
> HAL patch) for quite
> some time now on a AMD Geode platform. I just recently got a new Intel 
> Atom N270 CPU
> which I've installed Ubuntu Karmic on, however I can't get an Adeos/RTAI 
> patched kernel
> (with a known working .config) to boot on the system...it simply hangs 
> upon booting the kernel.
> Is it possible to get Intel Atom support and/or is this a known bug?
> 

You should post to the RTAI mailing list to get help on fixing the RTAI
code.

You may want to try running a standard Adeos patch on your system
without RTAI, and see if your machine boots; you can get them from:
http://download.gna.org/adeos/patches/v2.6/x86/

If it does work, then maybe this will give the RTAI folks a hint to help
you better.

> Thanks,
>   Chris
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



