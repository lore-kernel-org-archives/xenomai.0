From: Steven Seeger <steven.seeger@flightsystems.net>
Subject: Re: initial porting of IPIPE x86_64 patches onto Linux stable 5.4.52
Date: Mon, 24 Aug 2020 11:05:55 -0400
Message-ID: <5621687.alqRGMn8q6@omoikane>
In-Reply-To: <CALLqZ8R2mJBHe9Rd35q_n7Rf9s7=ht7C=E13vjWkwy5wNGqCHA@mail.gmail.com>
References: <MWHPR11MB1918BC3591D43C7A139375A0EE560@MWHPR11MB1918.namprd11.prod.outlook.com>
 <38d73dec-3163-cfbc-609e-60b9d65d6246@siemens.com>
 <CALLqZ8R2mJBHe9Rd35q_n7Rf9s7=ht7C=E13vjWkwy5wNGqCHA@mail.gmail.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Meng, Fino" <fino.meng@intel.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, "Wang,
 Rick Y" <rick.y.wang@intel.com>, "Pirou, Florent" <florent.pirou@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>, Henning Schild <henning.schild@siemens.com>

> On Mon, Aug 24, 2020 at 2:09 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > Greg, with this baseline available, porting ARM/ARM64 to 5.4 should
> > become possible. Thought I would wait until we have basic confidence on
> > x86 into the generic pieces. Steven, same for powerpc.

I'm definitely interested in doing this for PPC e500 32-bit. I now have my hands on a 64-bit 
e500 based board (PPC 5020) but it's a loaner COTS board from an industry partner. I 
probably won't be able to do Xenomai on that without a funding source, because of my 
other obligations. But I am reasonably sure that moving to 5.4 for e500 32-bit is something 
my partners would support. I get emails occasionally for more modern kernels.

If this follows the old noarch pattern for the baseline stuff, then that should make it ideal 
for bringing the rest of it up to date.

Steven

