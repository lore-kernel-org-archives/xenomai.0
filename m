Date: Thu, 26 Mar 2015 19:58:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150326185807.GA15125@hermes.click-hack.org>
References: <20150323220935.GA19836@hermes.click-hack.org>
 <CAJT0owGFHg9cuqWQWYY1y93=Dff9pHUyE+Gct_1=RM2gOwNK_w@mail.gmail.com>
 <20150324160153.GB15125@hermes.click-hack.org>
 <20150324161347.GC15125@hermes.click-hack.org>
 <CAJT0owE5VFmOfH05BZTZ4xZ_8=Co6Anu7VWa3qcW-MLMJK8GTQ@mail.gmail.com>
 <CAJT0owE7vtJDWM289=4cNR_LuUqPWAO60nvg9D0NiTQWeN9Xbg@mail.gmail.com>
 <20150326143225.GN15125@hermes.click-hack.org>
 <oqsicrznxt.fsf@merlin.sez.to>
 <20150326183015.GZ15125@hermes.click-hack.org>
 <oqk2y3zj6n.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oqk2y3zj6n.fsf@merlin.sez.to>
Subject: Re: [Xenomai] Xenomai 3.0-rc3 Interruption on Arietta G25
 (AT91SAM9G25 chip)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Janzen <pcj@xenomai.sez.to>
Cc: xenomai@xenomai.org

On Thu, Mar 26, 2015 at 11:51:12AM -0700, Paul Janzen wrote:
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
> > On Thu, Mar 26, 2015 at 10:08:30AM -0700, Paul Janzen wrote:
> >> Neither your MUA nor the mailing list software insert a
> >> 
> >> Reply-To: xenomai@xenomai.org
> >
> > You should get a resent-to.
> 
> I see Resent-To: in only 0.3% of my xenomai messages.  I assume those
> are the ones that people first replied to the original sender, then
> later on noticed and forwarded again to the mailing list.
> 
> > A proper MUA should display the resent-to header indicating that the
> > mail was bounced. Unfortunately, it seems few people use proper MUAs
> > these days.
> 
> Proper MUA's do not create a "Reply" type message with a To: field
> initialized to the value of Resent-To:.

Of course.

> 
> Proper MUA's create a "Reply" message with a To: field initalized with
> the value of Reply-To:.

The message I was replying to was not a message sent on the xenomai
mailing list. It was a private message. So, the To: field was set to
the sender only. I did not notice, sent the mail. Then did not see
the mail coming to the list, looked at the mail, so it had not been
sent to the list, so bounced the message, again, because it is
easy and has the advantage that the new mail has the same id than
the first mail, so allows eliminating the duplicate.

> 
> I'm simply suggesting that xenomai mailman be configured to include
> this header. Then people would have to consciously edit header fields
> to send to your private account only.

No, the mailman documentation recommends against that, it is a
recipe for sending private mails to the list unintentionally, which
is way worse than the opposite.

-- 
					    Gilles.

