Date: Tue, 28 Apr 2015 16:11:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150428141110.GC1993@hermes.click-hack.org>
References: <CADvZd9a0UuoQx-g0N5YFbxEMajgSohyQ7U-8BbA+Ay9kpOrqGw@mail.gmail.com>
 <553D4E9F.2060907@grandegger.com>
 <CA4FDA06-6595-4656-AE7A-A9092F103B98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA4FDA06-6595-4656-AE7A-A9092F103B98@gmail.com>
Subject: Re: [Xenomai] RT-CAN driver for C_CAN,D_CAN cores ready
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Tue, Apr 28, 2015 at 04:01:24PM +0200, Michael Haberler wrote:
> 
> > Am 26.04.2015 um 22:46 schrieb Wolfgang Grandegger <wg@grandegger.com>:
> > 
> > Hi Michael,
> > 
> > thanks for your contribution. Could you please send it as inline patch
> > to this mailing list to simplify the review and integration.
> > 
> > Thanks,
> > 
> > Wolfgang.
> 
> Here it is:
> 
> https://github.com/mhaberler/xenomai-2.6/commits/bbcan :
> 
> 027e3551a4d6aeca201ce92c66a3808b332ff9da Merge remote-tracking branch 'xenocan/for-xenomai-2' into bbcan
> 8740cfe7fd960727ad3e993da5366c88e2280264 xeno_d_can: RTDM driver for Bosch CCAN and DCAN peripherals
> fbe3b224501e091d26275b45e2cf0881d94997dd rename original files to match Steve's naming
> 84badf976ed149a352cbb34edc329685aaacb531 as from 3.8
> fe59354a1ed2ee2cff65d17f2cb249292c647e57 drivers/analogy: remove unnecessary spinlock
> 
> 
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: xeno-c_can.patch
> Type: application/octet-stream
> Size: 224496 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150428/72323552/attachment.obj>
> -------------- next part --------------

I guess Wolfgang wanted the code inline, and not sent as an
attachment, so as to put the comments in situation, by replying to
your mail.

-- 
					    Gilles.

