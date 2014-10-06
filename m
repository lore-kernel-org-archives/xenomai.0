Date: Mon, 6 Oct 2014 21:41:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141006194156.GC18129@sisyphus.hd.free.fr>
References: <54328CBA.7040005@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54328CBA.7040005@sigmatek.at>
Subject: Re: [Xenomai] rtserial bug 16550 + imx
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>
Cc: xenomai@xenomai.org

On Mon, Oct 06, 2014 at 02:36:10PM +0200, Johann Obermayr wrote:
> Hello,
>
> is this correct, that the ioctl RTSER_RTIOC_GET_STATUS does not return
> the correct rtser_status.
> Because rxbuf_status and txbuf_status was not filled into rtser_status structure.
>
> i've add
>      status_buf.rxbuf_status = ctx->in_npend;
>      status_buf.txbuf_status = ctx->out_npend;
> and also in the else block.
>
> is this correct ?

>From what I can see this ioctl only returns the line_status and
modem_status data for the three implemented drivers. Besides, you
would probably want to read ctx->in_npend and ctx->out_npend under
the spinlock, as everywhere they are used, it is with this spinlock.

--
					    Gilles.

