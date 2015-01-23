Date: Fri, 23 Jan 2015 08:44:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150123074403.GK29604@hermes.click-hack.org>
References: <3022250.HiL0lpQ0bg@soho>
 <3479927.PcNNIgk0xm@soho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3479927.PcNNIgk0xm@soho>
Subject: Re: [Xenomai] Xenomai-3 booting problems (2)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Fri, Jan 23, 2015 at 08:36:14AM +0100, Leopold Palomo-Avellaneda wrote:
> El Dijous, 22 de gener de 2015, a les 16:09:19, Leopold Palomo-Avellaneda va 
> escriure:
> > Hi again,
> > 
> > after made the modifications proposed by Jan Kiszka, now it doesn't built
> > and the message is:
> > 
> > nvidiafb: unable to setup MTRR
> > 
> 
> Hi,
> 
> removed nvidiafb.ko module (and all the nvidia graphics stuff) and the box 
> booted. It seems that nvidiafb (the non-free nvidia driver) doesn't like 
> xenomai-3 or vice-versa.
> 
> Are you aware of this?

Were you trying to use the nvidia module compiled for the vanilla
kernel, or did you recompile the nvidia module for the Xenomai
kernel? The former will not work.

Other than that, the nvidia module has been reported to work with
Xenomai, if the I-pipe patch you use contains this patch:
https://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.16&id=bc5bea6f134de2e55bb6014566c62fa083ed9c7b

-- 
					    Gilles.

