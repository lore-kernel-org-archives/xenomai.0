From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 19 Feb 2015 12:25:15 -0500
Message-ID: <20150219172515.GP30245@csclub.uwaterloo.ca>
References: <20150218182632.GG30317@hermes.click-hack.org>
 <54E4DDEA.3060909@siemens.com>
 <20150218184943.GH30317@hermes.click-hack.org>
 <54E4E166.5030701@siemens.com>
 <20150218190549.GI30317@hermes.click-hack.org>
 <54E4E546.8080801@siemens.com>
 <20150218192712.GJ30317@hermes.click-hack.org>
 <54E4FAF4.7050004@siemens.com>
 <20150219151327.GN30245@csclub.uwaterloo.ca>
 <54E619D5.4020208@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54E619D5.4020208@xenomai.org>
Subject: Re: [Xenomai] arm: Late delivery of pending Linux signals?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Thu, Feb 19, 2015 at 06:13:57PM +0100, Philippe Gerum wrote:
> I's not about LPAE being broken, it is about building with LPAE enabled
> on a backport of my LPAE fixes to the stock pipelines, due to some
> conflict with the FCSE changes. I dropped FCSE from the working tree for
> LPAE fixes, since the former is not relevant on armv7 with VIPT caches
> anyway.

Oh right.  I had forgotten about the FCSE code being dropped out of
that version.  Never have had any system that could use FCSE so I didn't
look at it much.

-- 
Len Sorensen

