Subject: Re: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17783933.1173875794637.JavaMail.ngmail@domain.hid>
References: <17783933.1173875794637.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 14 Mar 2007 14:26:32 +0100
Message-Id: <1173878793.32259.46.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-03-14 at 13:36 +0100, M. Koehrer wrote:
> Hi Philippe, 
> 
> I applied again the patch to the 2.6.19.2 (adeos-ipipe-2.6.19-i386-1.6-03.patch)
> and also enabled the nucleus debug option.
> But there is no change. The system still freezes.
> 

Ok, thanks. So we did no enter the twilight zone, yet.

> Regards
> 
> Mathias
> > > I used this patch on the UP kernel 2.6.19.2. Same adeos version as
> > before.
> > > The result  was the same => PC freeze
> > > 
> > 
> > Make sure to switch on the nucleus debug option, so that this code
> > triggers if appropriate.
> > 
> > -- 
> > Philippe.
> > 
> > 
> > 
> 
> 
-- 
Philippe.



