Date: Sun, 7 Sep 2008 06:21:37 -0700 (PDT)
From: Yasser Kashfi <yasser_kashfi@domain.hid>
In-Reply-To: <48C28291.7090704@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <420196.99125.qm@domain.hid>
Subject: Re: [Xenomai-core] RT_HEAP Problem
Reply-To: yasser_kashfi@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi
Thanks Gilles for your notes. The problem is solved.

--- On Sat, 9/6/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Subject: Re: [Xenomai-core] RT_HEAP Problem
> To: yasser_kashfi@domain.hid
> Cc: xenomai@xenomai.org
> Date: Saturday, September 6, 2008, 6:16 AM
> Yasser Kashfi wrote:
> > Hi
> > I tryed to set CONFIG_VMSPLIT_3G_OPT=y but never
> successful :( could you help me?
> 
> In your kernel build directory run make xconfig
> go in the "Processor types and features"
> for the menu item "High Memory Support" select
> "off"
> for the menu item "Memory split", select
> "3G/1G kernel split (for full
> 1G low memory)"
> 
> save the config, recompile the kernel and install it as
> usual.
> 
> -- 
> 					    Gilles.


      


