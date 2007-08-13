Message-ID: <2ff1a98a0708130214p432d52d8u780ecc8be1d0c2c6@domain.hid>
Date: Mon, 13 Aug 2007 11:14:54 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <41f748550708130155u346115d4r646264a3183de148@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41f748550708122250yd388c4ehe9992464579d5924@domain.hid>
	<2ff1a98a0708130059h29c8d5f1xc4f27133f5b06c6c@domain.hid>
	<41f748550708130119o40345de2r9d5547f0a7d5fdbe@domain.hid>
	<2ff1a98a0708130145h76d8ff4cka4c8cdd89a49c75d@domain.hid>
	<41f748550708130155u346115d4r646264a3183de148@domain.hid>
Subject: Re: [Xenomai-help] Kernel Space support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Iwan Budi Kusnanto <iwanbk@domain.hid>
Cc: xenomai@xenomai.org

On 8/13/07, Iwan Budi Kusnanto <iwanbk@domain.hid> wrote:
> On 8/13/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> > >
> > > GPL is not problem.
> > > We want to porting our data link layer (part of network driver) kernel
> > > module to RTOS.
> >
> > What do you mean ? You do not care about GPL ? Or you do not care
> > about giving your sources away ?
>
> Hmm...we want to make it GPL :)

Good ! Then as told by Jan, you should have a look at the RTDM API,
and since the driver you want to port is a network driver, you may
also have a look at  RTnet.

-- 
                                               Gilles Chanteperdrix

