From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <47163AE0.8040106@domain.hid>
References: <4714F580.7030403@domain.hid>
	<2ff1a98a0710161040n772fb76cv86d69312c4b853b2@domain.hid>
	<47163AE0.8040106@domain.hid>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 19:29:36 +0200
Message-Id: <1192642176.5973.68.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [RFC][PATCH] Enforce nkaffinity unconditionally
Reply-To: rpm@xenomai.org
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
Cc: Xenomai-core@domain.hid

On Wed, 2007-10-17 at 18:40 +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > On 10/16/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> Hi,
> >>
> >> aft
> >> Any concerns about the (yet untested) attached patch?
> > 
> > Well... Thanks for working in my stead. I had a look a the posix
> > situation but could not find the place in the code where the
> affinity
> > was set for user-space posix threads.
> > 
> > But when looking at the way nkaffinity worked, I wondered why it was
> > not set globally with a cpus_and on the tasks affinity. So, I
> > basically agree with your patch (if it does what I think it does).
> 
> Tested, and I can confirm it works as it should do. Philippe, please
> apply.

Merged, thanks.

-- 
Philippe.



