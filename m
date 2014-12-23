Date: Tue, 23 Dec 2014 17:46:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141223164659.GB1537@daedalus>
References: <767554081.97778.1418902240452.JavaMail.zimbra@wandercraft.eu>
 <20141218140529.GM2012@hermes.click-hack.org>
 <1193017267.99526.1418920886509.JavaMail.zimbra@wandercraft.eu>
 <20141218174347.GU2012@hermes.click-hack.org>
 <1886500835.102755.1418982478388.JavaMail.zimbra@wandercraft.eu>
 <20141219103133.GY2012@hermes.click-hack.org>
 <1185690365.115833.1419351787951.JavaMail.zimbra@wandercraft.eu>
 <20141223163535.GA1537@daedalus>
 <677186930.116031.1419353021115.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <677186930.116031.1419353021115.JavaMail.zimbra@wandercraft.eu>
Subject: Re: [Xenomai] Differents switch mode from differents Xenomai skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On Tue, Dec 23, 2014 at 05:43:41PM +0100, Huy Cong Vu wrote:
> 
> 
> ----- Mail original -----
> > De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> > Cc: xenomai@xenomai.org
> > Envoyé: Mardi 23 Décembre 2014 17:35:35
> > Objet: Re: [Xenomai] Differents switch mode from differents Xenomai skin
> 
> > On Tue, Dec 23, 2014 at 05:23:07PM +0100, Huy Cong Vu wrote:
> >> void mini( void *ptr )
> >> {
> >> 
> >> 
> >> 	uint8_t b;
> >> 	int ret1;
> >> 	int idx;
> >> 
> >> 	pthread_set_mode_np(0, PTHREAD_WARNSW);
> >>    printf("Starting posix test\n");
> >> 
> >> 	ec_port = malloc(sizeof(ecx_portt*));
> >> 
> >> 	if (setup_nic(ec_port,"rteth0") > 0) {
> >> 		   idx = getindex (ec_port);
> >>    		/* setup datagram */
> >> 			b = 0x0000;
> >>    		setupdatagram (ec_port, &(ec_port->txbuf[idx]),0x0009, idx, 0x0000, 0x0103,
> >>    		sizeof(b), &b );
> >>    		/* send data and wait for answer */
> >>    		wkc = srconfirm (ec_port, idx, EC_TIMEOUTRET3);
> >> 	}
> >> 	
> >> }
> > 
> > Typically, as I already explained, what you do here is wrong: you
> > should not arm the PTHREAD_WARNSW bit before call such as malloc or
> > the calls in setup_nic, which switch to secondary mode.
> 
> Ok, should I call it laterly? It is just for detect mode switch
> reason in fact

How to use PTHREAD_WARNSW is thoroughly documented, see:
https://xenomai.org/2014/06/finding-spurious-relaxes/

-- 
					    Gilles.

