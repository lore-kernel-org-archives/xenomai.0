From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200906221245.04890.smolorz@domain.hid>
References: <200906221245.04890.smolorz@domain.hid>
Content-Type: text/plain
Date: Mon, 22 Jun 2009 14:35:07 +0200
Message-Id: <1245674107.4121.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] [xenomai-head] xeno_posix.ko cannot be
 built
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-06-22 at 12:45 +0200, Sebastian Smolorz wrote:
> Hi Philippe,
> 
> with latest head it is not possible to build the POSIX skin as module. It 
> gives:
> 
> ERROR: "xnarch_divrem_billion" [kernel/xenomai/skins/posix/xeno_posix.ko] 
> undefined!
> 
> Obviously an
> 
> EXPORT_SYMBOL(xnarch_divrem_billion);
> 
> is missing.
> 

Indeed. Thanks,
http://git.xenomai.org/?p=xenomai-head.git;a=commit;h=7847120b2d84900941d2a40251e28636d9cbc682

-- 
Philippe.



