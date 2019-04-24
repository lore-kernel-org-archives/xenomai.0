Date: Wed, 24 Apr 2019 15:51:12 -0400
Subject: Re: Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
Message-ID: <20190424195112.ceet7ddwlgg6hky2@csclub.uwaterloo.ca>
References: <BB5C4F5E3633C64999D0577F81995AE70286E71C@XMAIL.tecom.nnov.ru>
 <55438112-789f-da93-99ed-0320b6486fa3@siemens.com>
 <DM6PR09MB3402364C4B51AF4E5095788D853C0@DM6PR09MB3402.namprd09.prod.outlook.com>
 <8333b206-e819-c3e7-1394-3698baf2a075@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8333b206-e819-c3e7-1394-3698baf2a075@siemens.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems,
 Inc]" <steven.seeger@nasa.gov>, Alexander Sharabanov <sharabanov.a@tecomgroup.ru>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Apr 24, 2019 at 08:28:05AM +0200, Jan Kiszka via Xenomai wrote:
> That will surely be a valuable result, likely not even bound to ppc32.
> 
> As I only learned recently (from a vendor that is still selling a lot of
> ppc32 silicon but no longer developing it) the toolchain situation is also
> getting worse: gcc discontinued ppc with release 8 and will drop it from 9.
> So, it will be "fun" to build for that arch in the not so far future, I'm
> afraid.
> 
> Jan

GCC has NOT dropped powerpc support.

They have dropped this:

Support for the powerpc*-*-*spe*

PowerPC SPE is the signal processing version implemented in the e500
core for example (good riddance as far as I am concerned).  It has an
incompatible FPU design with different instructions that conflict with
altivec and some other extensions.  Very few CPUs seem to have ever been
designed with the SPE extension and hence why it sees very little use
or testing.

Real PowerPC is doing fine in GCC.

-- 
Len Sorensen

