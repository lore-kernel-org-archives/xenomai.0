Subject: Re: [Xenomai-core] [PATCH] fix swsusp for gatekeeper thread
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44AB6855.4030905@domain.hid>
References: <44AB6855.4030905@domain.hid>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 10:05:23 +0200
Message-Id: <1152086723.4983.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, 2006-07-05 at 09:20 +0200, Jan Kiszka wrote:
> Hi,
> 
> this is a convenience patch for people like me running Xenomai on their workstation or notebook. It fixes a crash that occurs on suspend to disk/ram via swsusp because the gatekeeper is woken up by the suspension code but has nothing to migrate then.
> 
> With this patch applied, you can now suspend your machine as long as no skin is loaded, i.e. the nucleus is passive. When skins are loaded, the system hangs on resume, maybe due to wrong hardware re-initialisation.
> 

Merged, thanks.

-- 
Philippe.



