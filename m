From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 27 Nov 2014 16:56:41 -0500
Message-ID: <20141127215641.GK24110@csclub.uwaterloo.ca>
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com>
 <20141127191438.GI24110@csclub.uwaterloo.ca>
 <20141127203400.GP7842@hermes> <54778CF6.6000909@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54778CF6.6000909@siemens.com>
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Nov 27, 2014 at 09:43:34PM +0100, Jan Kiszka wrote:
> FHS on /mnt purpose:
> 
> "This directory is provided so that the system administrator may
> temporarily mount a filesystem as needed. The content of this directory
> is a local issue and should not affect the manner in which any program
> is run."
> 
> I think this makes it crystal clear that Xenomai is not supposed to
> touch it.

Absolutely.  It is how I have always used it and will continue to do so.

-- 
Len Sorensen

