MIME-Version: 1.0
In-Reply-To: <50793B0E.5020002@xenomai.org>
References: <CAFNBftf5EYFoSPK3VA4NWA5-eCQVvpOt_uV5Kf8VJ9rAsA5eww@mail.gmail.com>
	<CAHQk_AR+n7pq==TSTz5JwVRhg=jOKMXKniGrgdVTVTea5=aq1Q@mail.gmail.com>
	<50793B0E.5020002@xenomai.org>
Date: Sat, 13 Oct 2012 12:02:37 +0200
Message-ID: <CAHQk_ASEpt2Xxr4CN+x17LGRCESqv_4CKHe=5UnmtchakLwFAQ@mail.gmail.com>
From: Maksym Parkachov <lazy.gopher@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai on Yocto/Openembedded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

> Adding I-pipe and Xenomai as a single patch to the kernel does not seem
> the way to go.
>
> I would rather have the linux kernel building rules call
> prepare-kernel.sh to apply the I-pipe patch and setup xenomai links to
> the xenomai package source directory. It is not really hard, and it
> makes things way easier to maintain.

It was just a quick way to get result, when I have time I'll try to
rework recipe with your suggestions.

Regards,
Maksym.

