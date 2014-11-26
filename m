Date: Wed, 26 Nov 2014 13:49:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141126124928.GB5826@sisyphus.hd.free.fr>
References: <CAKJ14NeCDLLd_0_ksJWVw6+qPgBAjU8rWjPcyH9QGCDxXYoeQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKJ14NeCDLLd_0_ksJWVw6+qPgBAjU8rWjPcyH9QGCDxXYoeQg@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai 2.6.4 on i.MX6 Quad
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Nov 26, 2014 at 12:38:37PM +0000, Andreas Glatz wrote:
> However, starting switchtest and latency separately on the console
> doesn't produce this error. Do you have any clues what is wrong there?

Just read the messages, it is written, write on black:
> ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory

This issue is documented in the troubleshooting guide.

-- 
					    Gilles.

