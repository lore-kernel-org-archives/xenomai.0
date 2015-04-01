From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 1 Apr 2015 15:49:28 -0400
Message-ID: <20150401194928.GS29558@csclub.uwaterloo.ca>
References: <E1YdHjz-0005Rv-A3@sd-51317.xenomai.org>
 <20150401125148.GA29467@hermes.click-hack.org>
 <551BEB62.7030901@xenomai.org> <551C0025.5090908@siemens.com>
 <551C1AC9.1060109@xenomai.org> <551C1D2C.2060303@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551C1D2C.2060303@siemens.com>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : Create gitignore for
 autotools files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Wed, Apr 01, 2015 at 06:30:36PM +0200, Jan Kiszka wrote:
> By pulling everything that autoconf generates out of the repo, forcing
> the user of the git version to generate them yourself, you effectively
> made those files build outputs. As we cannot store them out-of-tree
> (like object files), we have to ignore them in-tree.

Certainly having them in .gitignore is a handy way to avoid them
accidentally being commited again, if someone has a habbit of doing git
commit -a.

-- 
Len Sorensn

