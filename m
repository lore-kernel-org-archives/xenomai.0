Resent-Message-ID: <20141205153945.GD10014@hermes.click-hack.org>
Resent-To: xenomai@xenomai.org
Date: Fri, 5 Dec 2014 16:30:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141205153007.GC10014@hermes.click-hack.org>
References: <CAPM60ws2F-7PFASr0MkZOn5ZqxnG=GnKUx9vwWteTZEUhxP+VQ@mail.gmail.com>
 <84a3d09fccb39bf9e9aec78ea5173d4a.squirrel@xenomai.org>
 <CAPM60wsL3yRb38SdtCeE-ksGE_hPk+=G3XAauAUOUxGVd3o0SQ@mail.gmail.com>
 <CAPM60wtnAtexr73UoY37Y4LGM49e-+hG2YysWSTDLA3o4dbnmQ@mail.gmail.com>
 <20141205001907.GG15711@hermes>
 <CAPM60wsxgmOn0afVpmnKhU5qqLYw7TDARg67RTYmmJCTcjT-kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM60wsxgmOn0afVpmnKhU5qqLYw7TDARg67RTYmmJCTcjT-kw@mail.gmail.com>
Subject: Re: [Xenomai] xeno_16550A driver install problems.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric?= <freecedric@free.fr>

On Fri, Dec 05, 2014 at 04:25:22PM +0100, Cédric wrote:
> Question : On startup, in omap-serial.c, the function "serial_omap_probe"
> initializes the gpio mux, I don't find initialization of gpio mux in
> 16550A.h.  Is this normal?

Yes, pinmuxing and selecting gpios is purely specific to the
platform, and would have nothing to do in a generic driver like 16550A.

> Two observation:
> 1 : module bug at line 1162, when read LSR

For the third time: the patch is not sufficient, you need to enable
the clocks.

> 2: your patch at read/write with regwith but:
>  - in read, you don't return value , and return type is u8
>  - in write, you write a  u8 type value, in omap-serial, the write value
> type is int.

I do not remmeber the details, but I am almost sure I used the right
function (readb, readw, readl, writedb, writew, writel) to perform
the read or the write with the right width to the hardware register.
This is what matters. Other than that, only 8 bits are useful in the
registers, so you can safely use u8 as arguments of the functions.

Please do not top post. Please stay on the list.

Regards.

-- 
					    Gilles.

