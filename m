From: Der Herr Hofrat <der.herr@domain.hid>
Message-Id: <200403121008.i2CA8PE28492@domain.hid>
Subject: Re: [Adeos-main] 260 uSec latency and no idea why
In-Reply-To: <16465.34899.374768.946617@domain.hid> from
 Gilles Chanteperdrix at "Mar 12, 2004 10:52:19 am"
Date: Fri, 12 Mar 2004 11:08:25 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Gilles Chanteperdrix <gchanteperdrix@domain.hid>
Cc: adeos-main@gna.org

> Paolo Mantegazza wrote:
>  > Der Herr Hofrat wrote:
>  > Yours is the first case I step on such a problem with Celerons.
> 
> What about IDE controllers bus mastering DMA ? Can't this be the cause
> of big bus locks ?
>
260 us sounds a bit much - this would have to show up 
on many systems - large caches and bus mastering DMA are an issue
but I never found more than 80us (flush_all) and DMA has been below
that.

hofrat 

