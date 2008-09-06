Message-ID: <48C28291.7090704@domain.hid>
Date: Sat, 06 Sep 2008 15:16:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <740679.99729.qm@domain.hid>
In-Reply-To: <740679.99729.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RT_HEAP Problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yasser_kashfi@domain.hid
Cc: xenomai@xenomai.org

Yasser Kashfi wrote:
> Hi
> I tryed to set CONFIG_VMSPLIT_3G_OPT=y but never successful :( could you help me?

In your kernel build directory run make xconfig
go in the "Processor types and features"
for the menu item "High Memory Support" select "off"
for the menu item "Memory split", select "3G/1G kernel split (for full
1G low memory)"

save the config, recompile the kernel and install it as usual.

-- 
					    Gilles.

