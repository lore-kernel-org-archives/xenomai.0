Message-ID: <48F7BCBA.4040901@domain.hid>
Date: Fri, 17 Oct 2008 00:14:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154622.273542440@domain.hid>
	<48F7A412.5090409@domain.hid>
In-Reply-To: <48F7A412.5090409@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 12/12] Enable SMP support for user libs
 by	default
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
> 
> I do not like this patch. This sould be solved using the existing
> features system. I do not want SMP to be enabled by default.

On x86, SMP is already the default case, other archs will follow soon.
I'm also fine with keeping those arch at default off which support SMP,
but use it only rarely in practice yet. But at least for x86, staying
with UP as default will quickly become annoying.

That said, I have no problem with additionally enforcing the right
configuration via the feature system. Will add that.

Jan

