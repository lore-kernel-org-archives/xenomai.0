Date: Thu, 6 Apr 2006 14:16:33 -0400 (EDT)
Message-Id: <200604061816.k36IGXbw022749@domain.hid>
From: Gary Wallace <wallace@domain.hid>
Subject: [Adeos-main] adeos-ipipe-2.6.14-ppc-1.2-01
Reply-To: wallace@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

  I am trying to use a 2.6.14.6 kernel with ipipe on a motorola
mvme5500 board.  The kernel will boot and run fine with ipipe
disabled, but it hangs in the boot sequence when ipipe is enabled.

  I patched a vanilla 2.6.14 kernel with the mvme5500 patch from
motorola computer group and the adeos-ipipe-2.6.14-ppc-1.2-01 patch.
Now the kernel hangs in the boot sequence about the time the
networking is being configured.

  Has anyone got ipipe working on a mvme5500?

Thanks,
Gary

