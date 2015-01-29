Date: Thu, 29 Jan 2015 11:46:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150129104650.GA2698@hermes.click-hack.org>
References: <CAHH_qdB0SL01DFidmSQ96YSOoGxpuNLTWoO87K-q6mEA-fM-Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHH_qdB0SL01DFidmSQ96YSOoGxpuNLTWoO87K-q6mEA-fM-Rg@mail.gmail.com>
Subject: Re: [Xenomai] imx28 linux 3.10.32 + ipipe v7 + GPIO IRQ machine
 freeze
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gautier HAOUY <gautier.haouy@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Jan 29, 2015 at 09:46:13AM +0100, Gautier HAOUY wrote:
> Hello everyone,
> 
> I am kindly requesting your help today as I am facing a complete freeze on
> an Freescale iMX28 based board (armadeus APF28-Dev).
> I have developed a very simple kernel module which registers a GPIO
> interrupt handler, working properly on linux 3.10.32 kernel.
> The same code, compiled on a 3.10.32 + ipipe7 (also tested on ipipe v4)
> patched kernel generates a machine freeze on IRQ reception, without message
> and any other possibility than resetting the board.
> 
> I would appreciate any help/hint/procedure I could use to dive into the
> problem and solve it.
> Hoping to help others afterwards,
> Best regards,
> G0TieR.

What is the problem exactly. Only applying the I-pipe patch breaks
the GPIOs, or you need to compile the kernel with CONFIG_IPIPE?

-- 
					    Gilles.

