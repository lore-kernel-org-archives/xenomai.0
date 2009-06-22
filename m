Message-ID: <4A3F73B6.1060202@domain.hid>
Date: Mon, 22 Jun 2009 14:06:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200906221245.04890.smolorz@domain.hid>
In-Reply-To: <200906221245.04890.smolorz@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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

Sebastian Smolorz wrote:
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

Well, no. The definition of xnarh_divrem_billion is in the timeconv.h
header, which should be included in places where this function is
needed. So, what is missing is probably a #include. But Ok, thanks for
taking care of testing 2.5-rc2.

-- 
                                          Gilles


