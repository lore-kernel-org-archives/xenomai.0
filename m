From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 1 Apr 2015 10:16:40 -0400
Message-ID: <20150401141640.GP29558@csclub.uwaterloo.ca>
References: <20150401135910.GO29558@csclub.uwaterloo.ca>
 <20150401140429.GB29467@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150401140429.GB29467@hermes.click-hack.org>
Subject: Re: [Xenomai] Hit BUG() in arch/arm/mm/pgd.c
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

On Wed, Apr 01, 2015 at 04:04:29PM +0200, Gilles Chanteperdrix wrote:
> On Wed, Apr 01, 2015 at 09:59:10AM -0400, Lennart Sorensen wrote:
> > We are seeing occational hits on a BUG() statement in pgd.c:
> 
> With what versions of Linux, I-pipe, Xenomai, etc...

Oh right. :)

Xenomai 2.6.4, linux 3.12.33 (with delta between 3.12.30 and
ti-linux-3.12.y from the ti-linux git tree to support the AM572x added),
ipipe 3.14 backported (initially by me, then by Phillipe as part of
making LPAE work).

-- 
Len Sorensen

