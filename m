Message-ID: <2ff1a98a0712201054q1266640aoa9fd56a914e8c888@domain.hid>
Date: Thu, 20 Dec 2007 19:54:48 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <456258.24487.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <456258.24487.qm@domain.hid>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: adeos-main@gna.org

On Dec 20, 2007 7:44 PM, Michael Trimarchi <trimarchimichael@domain.hid> wrote:
> Hi,
>
> > Ok. Could you try something ? It will work with I-pipe only but will
> > break Xenomai, so do not try to run Xenomai over this modification.
> >
>
> I tried the adeos-2.6.20-arm-1.8-02 patch and linux 2.6.20 and  I obtained the
> same results. When the system is not loaded I can't receive from the serial
> line using the adeos patch and null modem cable.
>
> AT91sam9260 8MB ram (using filesystem on ramdisk)
> I removed spi flash support, mmc support.
> I have only serial driver and using lrz for receiving file
>
> Can I do some tests for you using my board?

Yes, just to be sure, could you try using the serial port on Linux
without I-pipe put under load ?


-- 
                                               Gilles Chanteperdrix

