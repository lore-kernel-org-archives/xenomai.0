MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17477.7184.378815.330824@domain.hid>
Date: Tue, 18 Apr 2006 19:04:16 +0200
Subject: Re: [Xenomai-core] [PATCH] Check for NPTL and factor user-space skins
	initialization.
In-Reply-To: <444509F1.5090107@domain.hid>
References: <17476.64062.107556.216362@domain.hid>
	<44450359.2090203@domain.hid> <444509F1.5090107@domain.hid>
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
 > > Is this worth doing also ?
 > 
 > Some deeply embedded stuff (something like buried in the silicon 
 > actually...) might configure out CONFIG_PROC_FS, so we can't rely on 
 > this pseudo-fs to be always present.

Maybe we could use the information if available?

-- 


					    Gilles Chanteperdrix.

