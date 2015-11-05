From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 5 Nov 2015 16:28:39 -0500
Message-ID: <20151105212839.GT21923@csclub.uwaterloo.ca>
References: <20151105151544.GD16314@hermes.click-hack.org>
 <20151105152427.GN21923@csclub.uwaterloo.ca>
 <20151105155549.GE16314@hermes.click-hack.org>
 <20151105161902.GO21923@csclub.uwaterloo.ca>
 <20151105162514.GF16314@hermes.click-hack.org>
 <20151105165750.GP21923@csclub.uwaterloo.ca>
 <20151105171419.GG16314@hermes.click-hack.org>
 <20151105172452.GQ21923@csclub.uwaterloo.ca>
 <20151105175225.GR21923@csclub.uwaterloo.ca>
 <20151105211858.GS21923@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105211858.GS21923@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] ARM bus error due to alignment
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Nov 05, 2015 at 04:18:58PM -0500, Lennart Sorensen wrote:
> OK blowing up here:
> 
>                         /*
>                          * Search for a range of contiguous pages in
>                          * the free page list of the current
>                          * extent. The range must be 'bsize' long.
>                          */
>                         do {
>                                 lastpage = freepage;
> ---->                           freepage = *((caddr_t *) freepage);
>                                 freecont += heap->pagesize;
>                         }
>                         while (freepage == lastpage + heap->pagesize
>                                && freecont < bsize);
> 
> I wonder if I am getting to the end of the list and trying to derefence
> a NULL pointer as a result.  I see nothing in the code to make sure it
> doesn't try to do that, although I hope I am just misreading the code.

Well it does handle NULL checking at the top with while (freepage !=
NULL), so how is this derefencing doing that.   Hmm.

-- 
Len Sorensen

