Date: Wed, 6 May 2015 16:24:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150506142454.GX1993@hermes.click-hack.org>
References: <92BAB684D31DCD4A8F623A7EE7FD8C06013ED08A@041-DB3MPN1-092.041d.mgd.msft.net>
 <20150506140524.GW1993@hermes.click-hack.org>
 <92BAB684D31DCD4A8F623A7EE7FD8C06013ED0D5@041-DB3MPN1-092.041d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92BAB684D31DCD4A8F623A7EE7FD8C06013ED0D5@041-DB3MPN1-092.041d.mgd.msft.net>
Subject: Re: [Xenomai] Xenomai on Zynq (linux-denx xilinx-zynq-v3.14.17)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: SMITH Peter T <peter.t.smith@alstom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, May 06, 2015 at 02:22:33PM +0000, SMITH Peter T wrote:
> Gilles,
> 
> So do I need to disable some more kernel configuration options?

Yes, the problematic option is CONFIG_TRACE_IRQFLAGS. I am not sure
you can disable it directly, it is probably rather enabled by other
options.

-- 
					    Gilles.

