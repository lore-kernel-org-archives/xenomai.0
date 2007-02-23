Subject: Re: [Xenomai-core] [PATCH] DECLARE_XNLOCK vs. DEFINE_XNLOCK
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45DB5623.7090507@domain.hid>
References: <45DB5623.7090507@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 19:54:52 +0100
Message-Id: <1172256893.26738.100.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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

On Tue, 2007-02-20 at 21:12 +0100, Jan Kiszka wrote:
> This patch renames DECLARE_*XNLOCK to DEFINE_*XNLOCK, defines real DECLARE_XNLOCK +
> DECLARE_EXTERN_XNLOCK and applies it on several users.

Merged, thanks.

-- 
Philippe.



