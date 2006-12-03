Subject: Re: [Adeos-main] [PATCHES] cleanup minor quirks for 1.6-01
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1165157023.4952.361.camel@domain.hid>
References: <4572DB9F.7040505@domain.hid>  <1165157023.4952.361.camel@domain.hid>
Content-Type: text/plain
Date: Sun, 03 Dec 2006 15:50:05 +0100
Message-Id: <1165157406.4952.366.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Sun, 2006-12-03 at 15:43 +0100, Philippe Gerum wrote:
> On Sun, 2006-12-03 at 15:13 +0100, Jan Kiszka wrote:
> > Hi,
> > 
> > I came across a few things in latest 2.6.19-i386-1.6-01 patch:
> > 
> > The usage of __ipipe_pipelock in __ipipe_common_info_proc is broken (raw lock used as
> > Linux lock here), and I do not see any volatile data it could protect anyway. So let's
> > remove it.
> 
> The interrupt status word, and whether any virtual interrupt is
> allocated or not, are the volatile data protected by this lock on a SMP
> system. Since this is a common spinlock with no interrupt control
> required which is only used over the Linux domain (/proc handler), you
> don't need to go for the _hw() form of it.
> 

M, actually, the problem is elsewhere: we should disable hw IRQs here,
so that other domains could not compete with us on this lock.

-- 
Philippe.



