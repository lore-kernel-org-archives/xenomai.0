Date: Tue, 22 Sep 2020 23:45:33 +0300
From: Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [RFC PATCH] Multi-library support with core suffix in soname
Message-ID: <20200922204533.2jm5l34tglvwhjvc@altlinux.org>
References: <20200920192808.13637-1-vt@altlinux.org>
 <20200921135136.ckf3cvlhzgezxxuv@altlinux.org>
 <0cd5de4f-714b-96bf-f33f-6cb0b9fa42fa@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <0cd5de4f-714b-96bf-f33f-6cb0b9fa42fa@siemens.com>
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

On Tue, Sep 22, 2020 at 05:23:32PM +0200, Jan Kiszka wrote:
> On 21.09.20 15:51, Vitaly Chikunov wrote:
> > On Sun, Sep 20, 2020 at 10:28:08PM +0300, Vitaly Chikunov wrote:
> > > This will allow (for users) installing both versions of libs into the
> > > same system and (for distributions) having them without conflicts in
> > > the same repository.
> > 
> > I forgot we need to install xeno_config.h somewhere somehow. Otherwise,
> > it would be overwritten by other core.
> > 
> 
> Will that need support from Xenomai, or will you have to handle that at
> packaging level anyway?

First I thought only solution would be to have separate include dirs for
Cobalt and Mercury. But, then I noticed that XENO_BASE_CFLAGS in
xeno-config-s have:

  XENO_BASE_CFLAGS="-I$XENO_INCLUDE_DIR/cobalt -I$XENO_INCLUDE_DIR @XENO_USER_APP_CFLAGS@ -D__COBALT__"
  XENO_BASE_CFLAGS="-I$XENO_INCLUDE_DIR/mercury -I$XENO_INCLUDE_DIR @XENO_USER_APP_CFLAGS@ -D__MERCURY__"

Thus, we could keep common include dir, but move corresponding
xeno_config.h into cobalt/ and mercury/ subdirs. I can have this in
spec so Xenomai not need to be changed.


> 
> Jan
> 
> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

