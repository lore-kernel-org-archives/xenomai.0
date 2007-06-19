Message-ID: <46782DF1.9090101@domain.hid>
Date: Tue, 19 Jun 2007 21:26:41 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4677B095.3070903@domain.hid>
In-Reply-To: <4677B095.3070903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Switch to pci_register_driver
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

Jan Kiszka wrote:
> Hi Wolfgang,
> 
> can we just switch over to pci_register_driver in order to avoid
> deprecated (and soon removed) pci_module_init? Or do we also need some
> wrapper for older 2.4 kernels (latest 2.4 is already aligned with 2.6)?

Likely. I will do some tests tomorrow.

Wolfgang.


