Date: Tue, 25 Aug 2020 09:25:00 -0400
Subject: Re: initial porting of IPIPE x86_64 patches onto Linux stable 5.4.52
Message-ID: <20200825132500.4c5z6a3yesfe2wbe@csclub.uwaterloo.ca>
References: <MWHPR11MB1918BC3591D43C7A139375A0EE560@MWHPR11MB1918.namprd11.prod.outlook.com>
 <38d73dec-3163-cfbc-609e-60b9d65d6246@siemens.com>
 <CALLqZ8R2mJBHe9Rd35q_n7Rf9s7=ht7C=E13vjWkwy5wNGqCHA@mail.gmail.com>
 <5621687.alqRGMn8q6@omoikane>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5621687.alqRGMn8q6@omoikane>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steven Seeger <steven.seeger@flightsystems.net>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>, "Pirou, Florent" <florent.pirou@intel.com>, "Wang, Rick Y" <rick.y.wang@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On Mon, Aug 24, 2020 at 11:05:55AM -0400, Steven Seeger via Xenomai wrote:
> I'm definitely interested in doing this for PPC e500 32-bit. I now have my hands on a 64-bit 
> e500 based board (PPC 5020) but it's a loaner COTS board from an industry partner. I 
> probably won't be able to do Xenomai on that without a funding source, because of my 
> other obligations. But I am reasonably sure that moving to 5.4 for e500 32-bit is something 
> my partners would support. I get emails occasionally for more modern kernels.

A 5020 is an e5500, which is nothing like an e500.  The e500 is PowerpC
SPE, while the e5500 (and the e300, e500mc and e6500) are "real" PowerPC
instead with a somewhat different instruction set.

GCC 9 even dropped support for the PPC SPE, while PPC is fully supported.

The e500's existence offends me since it fragments the powerpc
architecture.  Yuck. :)

> If this follows the old noarch pattern for the baseline stuff, then that should make it ideal 
> for bringing the rest of it up to date.

-- 
Len Sorensen

