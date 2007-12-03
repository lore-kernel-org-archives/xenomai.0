Message-ID: <2ff1a98a0712030509x32b5a4e4sbdb604884e09baf3@domain.hid>
Date: Mon, 3 Dec 2007 14:09:03 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <28409161.1196682960040.JavaMail.root@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <471F7693.5080602@domain.hid>
	<28409161.1196682960040.JavaMail.root@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: linux@domain.hid
Cc: xenomai@xenomai.org

On Dec 3, 2007 12:56 PM,  <linux@domain.hid> wrote:
> I want to use Xenomai on openembedded (2.6.20 or higher) dist. for PXA270 board (compulab CM-X270). The kernel freezes during boottime after the Xenomai nucleus etc is has started, is this bug the cause of this freezing? Must I make the modifications by hand, i can't find them in the svn!

If you use xenomai trunk, the bug should be fixed. The fix is in
ksrc/arch/arm/switch.S

-- 
                                               Gilles Chanteperdrix

