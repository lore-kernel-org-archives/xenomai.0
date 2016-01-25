Date: Mon, 25 Jan 2016 20:14:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160125191430.GA28523@hermes.click-hack.org>
References: <56A65100.8000207@basystemes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56A65100.8000207@basystemes.fr>
Subject: Re: [Xenomai] rt_imx_uart compilation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>
Cc: xenomai@xenomai.org

On Mon, Jan 25, 2016 at 05:44:48PM +0100, Jean-Baptiste Tredez wrote:
> Hello,
> 
> I tried to compile linux kernel 3.18.12 with xenomai 2.6.4 and rtserial 
> enabled on arm imx6. The compilation failed with :
>    CC [M]  drivers/xenomai/serial/rt_imx_uart.o
> drivers/xenomai/serial/rt_imx_uart.c:39:27: fatal error: 
> mach/hardware.h: No such file or directory
>(...)
> Do you have an idea ?

First Xenomai 2.6.4 can not be used with Linux 3.18, you need
Xenomai 2.6 git tree for Linux 3.18. But it is very possible that
rt_imx_uart.c is broken. The fix is to have a look at the
corresponding mainline driver, and adapt it to RTDM.

Regards.

-- 
					    Gilles.
https://click-hack.org

