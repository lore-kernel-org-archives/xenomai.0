MIME-Version: 1.0
In-Reply-To: <CAFNBftf5EYFoSPK3VA4NWA5-eCQVvpOt_uV5Kf8VJ9rAsA5eww@mail.gmail.com>
References: <CAFNBftf5EYFoSPK3VA4NWA5-eCQVvpOt_uV5Kf8VJ9rAsA5eww@mail.gmail.com>
Date: Sat, 13 Oct 2012 11:13:47 +0200
Message-ID: <CAHQk_AR+n7pq==TSTz5JwVRhg=jOKMXKniGrgdVTVTea5=aq1Q@mail.gmail.com>
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
To: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Cc: xenomai@xenomai.org

Hi Flavio,

> Has anybody tried to create a package for Xenomai for Yocto or Openembedded?

I have a client side package at my layer, you could check it at:

http://github.com/veter-team/veterlayer/tree/master/recipes/xenomai

It's pretty strait forward. Kernel is different story, I've just made
a patch to customized kernel:

http://github.com/veter-team/veterlayer/tree/master/recipes/linux

Hope this helps,
Maksym.
http://veter-project.blogspot.com

