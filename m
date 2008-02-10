MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18351.4426.901314.983883@domain.hid>
Date: Sun, 10 Feb 2008 15:59:22 +0100
In-Reply-To: <47AF0EC8.8010800@domain.hid>
References: <18350.7135.108901.491437@domain.hid>
	<18350.7315.555644.171720@domain.hid>
	<47AF057A.3070305@domain.hid>
	<18351.3223.368586.268621@domain.hid>
	<47AF0EC8.8010800@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [patch 2/4] RTDM support for select-like service.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > Gilles Chanteperdrix wrote:
 > >  > > stats:
 > >  > >  include/rtdm/rtdm.h        |    4 ++
 > >  > >  include/rtdm/rtdm_driver.h |   30 +++++++++++++++-
 > >  > >  ksrc/skins/rtdm/core.c     |   84 +++++++++++++++++++++++++++++++--------------
 > >  > >  ksrc/skins/rtdm/device.c   |   10 +++++
 > >  > >  ksrc/skins/rtdm/drvlib.c   |   76 ++++++++++++++++++++++++++++++++++++----
 > >  > >  5 files changed, 170 insertions(+), 34 deletions(-)
 > >  > > 
 > >  > 
 > >  > /me thinks that going for inline patches on this list is overdue...
 > > 
 > > I guess it depends on the mail client, but with my mail client, I get
 > > plain text attachments inlined in the mail body. I somehow assumed that
 > > it was the case for everyone else.
 > 
 > Mine (TB) shows the patches inlined, but refuses to let me comment on
 > them. Maybe there is a knob deep inside its configs, but I heards such
 > complaints from other (likely non-TB) users as well.

There are even things in thunderbird that can only be configured through
its configuration files, not with its menus.

 > The reason for staying with attachments was that /someone/ (not you) had
 > problems with grabbing them from his client without causing whitespace
 > havoc... :)

Yes, I think I would have the same problem, my mail client (I feel
ashamed to tell: XEmacs VM) splits the line at 72 characters. So, if I
paste a patch, I must refrain from reformatting the mail, otherwise the
patch could be broken.

-- 


					    Gilles Chanteperdrix.

