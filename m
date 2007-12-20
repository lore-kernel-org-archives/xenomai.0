Message-ID: <476A5417.7090504@domain.hid>
Date: Thu, 20 Dec 2007 12:37:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <476A529B.1040006@domain.hid>
In-Reply-To: <476A529B.1040006@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [RFC][PATCH] x86-64: catch too large NR_CPUS
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Hi,
> 
> building Xenomai for an 8-way box and deriving its setup from an
> existing .config, I fortunately noticed some warning in ipipe.c. It
> pointed out an overflow in IPIPE_IRQMASK_VIRT when NR_CPUS gets too
> large. This causes NR_IRQS to explode, which then lets the virtual IRQ
> mask overflow.

More concrete: Too large meant CONFIG_NR_CPUS=128. You can still get
away with 64 - or just select what is physically there...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

