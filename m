From: Steven Seeger <steven.seeger@flightsystems.net>
Subject: Re: initial porting of IPIPE x86_64 patches onto Linux stable 5.4.52
Date: Tue, 25 Aug 2020 10:40:13 -0400
Message-ID: <1797573.eGJsNajkDb@omoikane>
In-Reply-To: <20200825132500.4c5z6a3yesfe2wbe@csclub.uwaterloo.ca>
References: <MWHPR11MB1918BC3591D43C7A139375A0EE560@MWHPR11MB1918.namprd11.prod.outlook.com>
 <5621687.alqRGMn8q6@omoikane>
 <20200825132500.4c5z6a3yesfe2wbe@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>, "Pirou, Florent" <florent.pirou@intel.com>, "Wang,
 Rick Y" <rick.y.wang@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On Tuesday, August 25, 2020 9:25:00 AM EDT Lennart Sorensen wrote:
> A 5020 is an e5500, which is nothing like an e500.  The e500 is PowerpC
> SPE, while the e5500 (and the e300, e500mc and e6500) are "real" PowerPC
> instead with a somewhat different instruction set.

Sorry e500 was a typo in that case.

> GCC 9 even dropped support for the PPC SPE, while PPC is fully supported.
> 

Yeah there are e500 boards being made for military, aerospace, and LEO (low earth orbit) 
uses. There is concern that gcc 9 dropped SPE support, but it's up to vendors to support 
maintenance of it.

> 
> The e500's existence offends me since it fragments the powerpc
> architecture.  Yuck. :)

Well I won't say anything good or bad about it, but it's the one I know the most since it's 
what I work with all the time. ;)

The worst thing I ever had to deal with was making changes to a 603 instruction set 
simulator to make it be a 601. The subtle differences between POWER and PowerPC ISAs 
were quite a pain to find at the time. This was years ago.

But yeah all my work (and tested support with xenomai) have been on a e500v2. (8548)

Steven

