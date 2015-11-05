From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 5 Nov 2015 17:08:51 -0500
Message-ID: <20151105220851.GU21923@csclub.uwaterloo.ca>
References: <20151105151544.GD16314@hermes.click-hack.org>
 <20151105152427.GN21923@csclub.uwaterloo.ca>
 <20151105155549.GE16314@hermes.click-hack.org>
 <20151105161902.GO21923@csclub.uwaterloo.ca>
 <20151105162514.GF16314@hermes.click-hack.org>
 <20151105165750.GP21923@csclub.uwaterloo.ca>
 <20151105171419.GG16314@hermes.click-hack.org>
 <20151105172452.GQ21923@csclub.uwaterloo.ca>
 <20151105175225.GR21923@csclub.uwaterloo.ca>
 <20151105214042.GE31487@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105214042.GE31487@hermes.click-hack.org>
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

On Thu, Nov 05, 2015 at 10:40:42PM +0100, Gilles Chanteperdrix wrote:
> On Thu, Nov 05, 2015 at 12:52:25PM -0500, Lennart Sorensen wrote:
> > I wish I could figure out why the backtraces aren't working, since they
> > are such a nice debug feature to have.
> 
> You can try disabling unwinding, this should enable frame pointers
> and maybe make the backtraces more reliable.

I can try that.  I always thought unwinding was part of making backtraces
work.  Not sure why I thought so.

-- 
Len Sorensen

