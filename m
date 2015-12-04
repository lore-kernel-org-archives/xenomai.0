Date: Fri, 4 Dec 2015 14:20:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151204132026.GB29398@hermes.click-hack.org>
References: <195449769.6706761.1448050298290.JavaMail.yahoo.ref@mail.yahoo.com>
 <195449769.6706761.1448050298290.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195449769.6706761.1448050298290.JavaMail.yahoo@mail.yahoo.com>
Subject: Re: [Xenomai] Port to MicroBlaze
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Taishan Fan <taishanfan@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Nov 20, 2015 at 08:11:38PM +0000, Taishan Fan wrote:
> Is there support to port to MicroBlaze ? or are some guide
> materials there? Thanks.

I do not think there is a port to MicroBlaze. We had a port to NIOS,
but I do not think it has been updated to Xenomai 3.

To start a port, you should start with the port of the I-pipe patch,
a Linux kernel modification maintained in this git repository:
https://git.xenomai.org/ipipe.git/

We have a guide about porting the I-pipe patch to a new ARM board:
https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

But this would only be a partial help, as there are much more
changes needed for a port to a new architecture. 

-- 
					    Gilles.
https://click-hack.org

