Date: Mon, 15 Feb 2016 19:56:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160215185651.GB22593@hermes.click-hack.org>
References: <CAMgLWPm3z5h-aLw5X5LdU+6ULQoqHTN2ebwR0Y4=z1F+qFVsKA@mail.gmail.com>
 <20160215125941.GD9903@hermes.click-hack.org>
 <CAMgLWPk0iR9OgAWOm1EzyHvmGS2O2T98WAtR6YZQv4+HxgugnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMgLWPk0iR9OgAWOm1EzyHvmGS2O2T98WAtR6YZQv4+HxgugnA@mail.gmail.com>
Subject: Re: [Xenomai] Problem with rt_igb driver for I210 card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "GEORGE, Laurent" <laurent.george@esiee.fr>
Cc: xenomai@xenomai.org

On Mon, Feb 15, 2016 at 02:37:23PM +0100, GEORGE, Laurent wrote:
> >"It does not work" is a bit vague. Do you wait for the link to be up
> >before sending the solicit? Does it return an error? Does it
> >send a packet but receive no answer? Some other case?
> 
> Some precisions on the problem:
> 
> 1) I load all the required modules (like rtnet, rt_igb, etc)- No error
> 2) I make the rteth0 interface up - No error
> 3) rtifconfig -a shows rteth0 interface - No error
> 4) I then run ./rtroute solicit ip_address dev rteth0 - No Error

Ok, but do you wait for the link to be up before sending the
ARP? Do you see RUNNING in rtifconfig ? Or do you check the link
with the SIOCGIFFLAGS ioctl?

It would be nice if you could answer all the questions you are asked
and not just a few well chosen ones.

-- 
					    Gilles.
https://click-hack.org

