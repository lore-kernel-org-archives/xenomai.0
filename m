From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <1254510029.2703.355.camel@domain.hid>
References: <4AC2448B.1080500@domain.hid>
	<1254396765.2703.234.camel@domain.hid>  <4AC62883.1080908@domain.hid>
	<1254505304.2703.347.camel@domain.hid>
	<1254506494.8199.46.camel@domain.hid>
	<1254510029.2703.355.camel@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Oct 2009 14:26:30 -0400
Message-Id: <1254853590.3718.28.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Fri, 2009-10-02 at 21:00 +0200, Philippe Gerum wrote:
> On Fri, 2009-10-02 at 14:01 -0400, Andreas Glatz wrote:
> > > 
> > > - powerpc32 updates for 2.6.30. Mainly to merge the once experimental
> > > bits that prevent most alignment faults from triggering a secondary mode
> > > switch. Andreas told me this works like a charm on 83xx, and I did not
> > > see any issue on 52xx, 85xx or 86xx either.
> > > 
> > 
> > Can I get a version of that patch for testing? Is it in your git
> > repository?
> 
> I just pushed this commit to my remote tree (ipipe-2.6.30-powerpc
> branch); it should appear in a few hours once mirrored (cron job).
> 

I finally had a chance to test the ipipe-2.6.30-powerpc version
from the git repository. Unfortunately, I noticed that our application
dies after some time and that this behaviour is related to that 
alignment patch (if I take it out everything runs fine for > 2 days).

Currently I'm investigating the reasons for that crash. It has
something to do with floating point registers not being restored
properly. Our alignment exceptions are mainly triggered by accesses 
to unaligned floating point data.

Andreas

