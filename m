Date: Tue, 21 Apr 2020 12:11:47 +0300
From: Vitaly Chikunov <vt@altlinux.org>
Subject: Re: FAILURE run_gdb:287: checking expression "primary_mode",
 expected "$", found "N"
Message-ID: <20200421091147.vbkogjqywq4qoxtd@altlinux.org>
References: <20200131152713.1811748-1-rpm@xenomai.org>
 <0c811fd4-dc46-0bce-99b3-64c150725d3d@siemens.com>
 <230535ea0245408dbd941bc26c4f6df9@intel.com>
 <bbab7ccf-0f5e-617a-2d94-afc79f2d7efa@siemens.com>
 <CALLqZ8Qk-BEuYjYtRpqkTVT5N9iWJHpU=3n109jCMCy4Yd_8TA@mail.gmail.com>
 <20200201112301.5d3146d9@md1za8fc.ad001.siemens.net>
 <20200420221850.xjzzrpdfoherz6hm@altlinux.org>
 <20200421002728.wugbqtzibmbuqyzk@altlinux.org>
 <20200421024337.hfwqgnf4y5dkuvss@altlinux.org>
 <3a385296-1538-3aee-e240-15604fbe9677@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3a385296-1538-3aee-e240-15604fbe9677@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Jan,

On Tue, Apr 21, 2020 at 07:10:55AM +0200, Jan Kiszka via Xenomai wrote:
> On 21.04.20 04:43, Vitaly Chikunov via Xenomai wrote:
> > On Tue, Apr 21, 2020 at 03:27:29AM +0300, Vitaly Chikunov via Xenomai wrote:
> > > On Tue, Apr 21, 2020 at 01:18:50AM +0300, Vitaly Chikunov via Xenomai wrote:
> > > I recommend removing `static' from `breakpoint_target' definition, so
> > > that symbol is exported without need of debuginfo.
> > 
> > It turned out that removing `static' was not enough to pass binary
> > stripping. I will investigate better solution further.
> 
> Stripping must not happen - how did you build things? On debian, we have
> "dh_strip -s --exclude=smokey" in the rules to ensure that smokey keeps its
> debuginfos.

Oh, yes I can disable stripping for snokey in our build system too. So
there is no need to remove `static'. (But other two points remain.)

Thanks!


