From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <201104041641.58183.smolorz@domain.hid>
References: <201104041641.58183.smolorz@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Apr 2011 16:47:54 +0200
Message-ID: <1301928474.2052.57.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Bug in Linux kernel 2.6.37 blocks xenomai threads
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2011-04-04 at 16:41 +0200, Sebastian Smolorz wrote:
> Hi,
> 
> there is a bug in kernel 2.6.37 (fixed in 2.6.37.1, see commit 
> 1cdc65e1400d863f28af868ee1e645485b04f5ed) which blocks RT threads during 
> creation. They stick to a certain CPU core for a certain amount of time 
> (sometimes minutes ...) before they are migrated to the proper core and run 
> as expected.
> 
> Philippe, Gilles, maybe you could generate a new i-pipe patch based on the 
> newest 2.6.37-series kernel. I patched a 2.6.37.6 kernel with adeos-
> ipipe-2.6.37-x86-2.9-00.patch and the problem was gone.
> 

Ok, I'll handle this. I have some patches from Jan which have been
pending for too long in my tree to add to this one.

-- 
Philippe.



