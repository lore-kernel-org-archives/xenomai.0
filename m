Message-ID: <445F69B6.9000800@domain.hid>
Date: Mon, 08 May 2006 17:54:30 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] prepare-kernel shouldnt alter files thru
	links
References: <445EBCFC.2010604@domain.hid>
In-Reply-To: <445EBCFC.2010604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
> 
> attached patch corrects a mistake in rev 985, which chmod'd a read-only 
> file,
> even if it was a symlink from a kernel-tree cloned with lndir.
> This resulted in a bad original tree for use in building vanilla kernels.
> 
> with patch, script renames the symlink, copies it to the expected name,
> and *then* chmods it, and appends to it.   Now vanilla kernel builds also
> using same tree re-make w/o actually recompiling anything.
> 

Sounds reasonable. Applied, thanks.

-- 

Philippe.

