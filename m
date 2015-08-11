Date: Tue, 11 Aug 2015 21:51:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150811195132.GD29076@hermes.click-hack.org>
References: <2a853db9.e8c8.14f1bf15b2f.Coremail.ericvic@163.com>
 <20150811194457.GC29076@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150811194457.GC29076@hermes.click-hack.org>
Subject: Re: [Xenomai] x86 xenomai-2.6.4 linux-3.10.32 with i915 enble and
 CONFIG_PCI_MSI enble
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: eric <ericvic@163.com>
Cc: xenomai@xenomai.org

On Tue, Aug 11, 2015 at 09:44:57PM +0200, Gilles Chanteperdrix wrote:
> On Tue, Aug 11, 2015 at 04:47:26PM +0800, eric wrote:
> > Hi Gilles：I have a proble with Intel(R) Atom(TM) CPU E3827 @
> >             1.74GHz . We have fpga on pcie and fpga give 250us
> >             interrupt signal to our task . The interrupt type is
> >             MSI .The proble is when we start gpu test glxgears the
> >             task latency just 15us when we start without glxgears
> >             the latency is about 120us . We tested a week‘s time
> >             always the same situation. We don’t know why？
> >             Thanks！！！
> 
> Hi, I do not answer for free to private support requests. If you
> want support for free, then please use the mailing list. If you are
> looking for consulting, then let us first agree on what you are
> looking for exactly.

Sorry, you actually used the list. Seems like I just made a fool of
myself.

The answer is to use the I-pipe trace.

-- 
					    Gilles.
https://click-hack.org

