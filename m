MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17552.13951.428423.915304@domain.hid>
Date: Wed, 14 Jun 2006 18:17:03 +0200
Subject: Re: [Xenomai-core] /proc/xenomai broken...
In-Reply-To: <44903432.3070905@domain.hid>
References: <17552.12922.452992.652848@domain.hid>
	<44903432.3070905@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > When using xenomai trunk, it appears that /proc/xenomai is no longer a
 > > directory but a file returning "0".
 > > 
 > 
 > Check your recent changes for giving the nucleus a regular syscall 
 > table. I would not be surprised of some side-effect there. i.e. 
 > something going on with the xnptree_t descriptor?

That is exactly the source of the problem, since iface_proc_root in
nucleus/module.c has not yet been set, the proc entry for the nucleus
interface get created directly under /proc instead of
/proc/xenomai/interfaces.

Do we need a /proc entry for this interface ?

-- 


					    Gilles Chanteperdrix.

