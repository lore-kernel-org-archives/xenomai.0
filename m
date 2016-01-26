Date: Tue, 26 Jan 2016 20:32:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160126193230.GA9298@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A71C978@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A71C978@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Rtnet UDP module.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Jan 26, 2016 at 11:12:07AM +0000, Umair Ali wrote:
> Hello there,
> 
> I have little confusion. In Xenomai 3.0.1, there is rtudp.ko
> module of Rtnet. The confusion is that if UDP packets are needed
> to send using the rt_8139too.ko then rtudp.ko module is needed to
> be loaded or not. If we do not use rtudp.ko, will it switch to
> secondary mode when udp packets are send. What is the main purpose
> of the rtudp.ko module and where it can be used in the userspace.

Modules can never be used in user-space. rtudp.ko is the
implementation of the UDP protocol. Yes, if you do not load this
module, using send will switch to secondary mode and not use the
real-time network interface. Xenomai 3 is not different from what
has always existed with RTnet.

-- 
					    Gilles.
https://click-hack.org

