Date: Tue, 5 Dec 2006 14:08:43 +0100
From: Benjamin Zores <benjamin.zores@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
Message-Id: <20061205140843.434ee7d1.benjamin.zores@domain.hid>
In-Reply-To: <45756F92.6060001@domain.hid>
References: <20061124105346.e442448d.benjamin.zores@domain.hid>
	<4566C5AF.7030107@domain.hid>
	<20061124113009.08c0a490.benjamin.zores@domain.hid>
	<4569E699.6050003@domain.hid>
	<20061127092143.e633cd91.benjamin.zores@domain.hid>
	<456ACA35.8030206@domain.hid>
	<20061127125419.3852edd9.benjamin.zores@domain.hid>
	<456AD5EB.5040901@domain.hid>
	<20061130133745.272ab4b1.benjamin.zores@domain.hid>
	<45754723.6050503@domain.hid>
	<20061205133516.b3b9ae85.benjamin.zores@domain.hid>
	<45756F92.6060001@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

On Tue, 05 Dec 2006 14:09:38 +0100
Wolfgang Grandegger <wg@domain.hid> wrote:

> Unfortunately, "generic" applies only to the Linux part. I realized, 
> that the new IPIPE support for the genirqs requires even more 
> arch-specific modifications than the old interface :-( on PowerPC.

That's pretty bad news :-(

> Have you ever worked with that board under 2.6? It is not even well 
> supported by the old ppc tree and you need patches, which are available 
> somewhere but still require extra tweaking. I have such a board on my 
> table and if I'm lucky, I will get U-Boot with OF support up and booting 
> Linux PowerPC 2.6.19 ... but I need plenty of luck.

Nope, but i've seen recent commits for better support on kernel git
for upcoming 2.6.20.

Btw, Freescale have GIT trees for UBoot with support for many of their CPUs
(and support for OF as well). See http://opensource.freescale.com/

Ben

