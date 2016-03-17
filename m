Date: Thu, 17 Mar 2016 14:36:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160317133609.GD575@hermes.click-hack.org>
References: <CABfy4==QwJ36Kw2j==_kmtKnMtBy_obCjwR_2oD0TEo4LF=d7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABfy4==QwJ36Kw2j==_kmtKnMtBy_obCjwR_2oD0TEo4LF=d7w@mail.gmail.com>
Subject: Re: [Xenomai] Problem with rtnet e1000e ethernet card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Yury Kaliukhovich <jury.kaliukhovich@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Mar 17, 2016 at 03:25:16PM +0200, Yury Kaliukhovich wrote:
> Hello everyone,
> 
> I've faced an issue with rtnet concerning intel e1000e network adapter.
> I have an application that uses rtnet to work with ethernet devices. In
> case of temporary disconnection frames couldn't be sent/received by
> application, and trace "Reset adapter " appears in dmesg.
> We are using kernel 3.14.39 and the last xenomai 3.0.1.
> After some googling I've found a commit to linux kernel to fix e1000e
> module -
> 
> https://github.com/torvalds/linux/commit/12d43f7d3cd36494a442dea6f2d2c7ccb76d0d80

Thanks this is an interesting patch. However, triggering a reset
when packets are sent while the network is down causes a problem:
in the middle of the reset the network is down, so if the
application sends packets again, this will trigger a reset again,
and can lead to situation where the application is never able to
send packets, because the interface is always resetting and thus
never up.

So, the issue has been fixed differently in the git repository: we refuse
to queue packets if the cable is not plugged:
https://git.xenomai.org/xenomai-3.git/commit/?h=stable-3.0.x&id=0eeba1c172efabbc1d2194f7893cd40ad3ee1162

Besides, real-time applications expect short latency from RTnet, so
it seems more correct to inform them that their packet could not be
sent because the network is down, than to queue the packet for an
indefinite time.

-- 
					    Gilles.
https://click-hack.org

