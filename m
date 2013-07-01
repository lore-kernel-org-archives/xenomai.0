From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Mon, 1 Jul 2013 15:38:33 +0200
References: <201306260906.22955.leo@alaxarxa.net>
	<51CC031A.9030905@xenomai.org>
	<CAMYDobV2YQez7qtcTxxQ1wsL23oPu0sT+WwHsQ6hW18pcgnJkA@mail.gmail.com>
In-Reply-To: <CAMYDobV2YQez7qtcTxxQ1wsL23oPu0sT+WwHsQ6hW18pcgnJkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201307011538.34221.leo@alaxarxa.net>
Subject: Re: [Xenomai] Xenomai warn_upon_switch .. kill  the user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: peter@thesourceworks.com
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

A Divendres, 28 de juny de 2013, Peter Soetens va escriure:
> On Thu, Jun 27, 2013 at 11:17 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> > On 06/27/2013 11:09 AM, Leopold Palomo-Avellaneda wrote:
> >
> >>
> >> AAnd I don't know how to silent (or if is possible) this messages.
> >
> >
> > Try disabling CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX if currently set in your
> > kernel config. If that is still not enough, then you will have to switch 
off
> > PTHREAD_WARNSW manually, using pthread_set_mode_np(), for each thread 
which
> > triggers this signal.
> 
> Quoting Gilles:
> "The point is that these messages are telling you that there is a bug,
> either in xenomai code (a bug was fixed since xenomai 2.6.2.1 which
> could explain such a behaviour), or in orocos code. When the bug is
> fixed the signal will disappear."
> 
> We're having one thread ( main() ) which is modeswitching all the time
> since it's doing user IO using the console, filesystem etc.
> 
> I didn't consider this as a bug, and we only enable PTHREAD_WARNSW for
> specific threads, where it does matter.
> 
> I also have the CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX option on in my test
> system, and I'm not seeing any of these messages (while the MSW
> increments).
> 
> So it beats me what is causing these messages in his setup.
> 
> Leo, which version (git hash tag) are you using ?

Hi,

my worst thoughts have been confirmed this morning. I did a mistake and I have 
lost your time during these days. I was using 2.6.2 instead of 2.6.2.1. I'm so 
sorry. I don't know what to say...

I'm extremely busy this week because a presentation but next week I will 
review all of this. With:

-Debian Wheezy
- Xenomai 2.6.2.1
- Kernel 3.5.7
Orocos 2.6 works and no warning messages are showed.... I have to test the 
ethercat config.

I'm so sorry ....

Leo







-- 
--
Linux User 152692
Catalonia

