Message-ID: <1396478246.24976.1.camel@localhost.localdomain>
From: Peter Howard <pjh@northern-ridge.com.au>
Date: Thu, 03 Apr 2014 09:37:26 +1100
In-Reply-To: <533BBB11.5090808@xenomai.org>
References: <1396407588.27578.5.camel@localhost.localdomain>
 <533BBB11.5090808@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] OMAP L138
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2014-04-02 at 09:24 +0200, Gilles Chanteperdrix wrote:
> On 04/02/2014 04:59 AM, Peter Howard wrote:
> > Hi,
> > 
> > I'm interested in running xenomai on a TI-OMAP L138 board.  I found the
> > following thread in the archives:
> > 
> > http://www.xenomai.org/pipermail/xenomai/2010-January/018898.html
> > 
> > where someone was working on porting ipipe and xenomai to that board.
> > However, the thread ended with problems still unresolved, and the patch
> > in the thread (just the changes for ipipe) isn't in the ipipe
> > repository.
> > 
> > Does anyone know if this work was completed or just faded into the
> > ether?
> 
> We never merged a patch for this processor. And a lot of things changed
> since that time. If you are interested in porting the I-pipe patch to
> this processor, see:
> 
> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
> 

Thanks for that.  A further question - the latest "official" kernel for
that board is 3.3.  Looking through the ipip git repo I can trace back
against mainline to 3.8, but no further.  Did work in the git repo
(re-)start then?  Or am I missing things?

Thanks,


-- 
Peter Howard <pjh@northern-ridge.com.au>


