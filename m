Date: Tue, 26 May 2015 12:52:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150526105256.GN27570@hermes.click-hack.org>
References: <20150525180316.GA4970@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150525180316.GA4970@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] [PATCH v2] Fix arm GIC irq mask calculations
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Mon, May 25, 2015 at 02:03:16PM -0400, Lennart Sorensen wrote:
> 3.14 has made changes to how irqs are handled and ipipe is using the
> wrong value to calculate the mask.  Change to the correct value by always
> using the access function to get the irq.
> 
> This fixes booting with 3.14.39 on the TI AM572x.
> 
> Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>

This patch is fine by me.

-- 
					    Gilles.

