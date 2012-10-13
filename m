Message-ID: <50793B0E.5020002@xenomai.org>
Date: Sat, 13 Oct 2012 11:57:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFNBftf5EYFoSPK3VA4NWA5-eCQVvpOt_uV5Kf8VJ9rAsA5eww@mail.gmail.com>
	<CAHQk_AR+n7pq==TSTz5JwVRhg=jOKMXKniGrgdVTVTea5=aq1Q@mail.gmail.com>
In-Reply-To: <CAHQk_AR+n7pq==TSTz5JwVRhg=jOKMXKniGrgdVTVTea5=aq1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Yocto/Openembedded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Maksym Parkachov <lazy.gopher@gmail.com>
Cc: xenomai@xenomai.org

On 10/13/2012 11:13 AM, Maksym Parkachov wrote:

> Hi Flavio,
> 
>> Has anybody tried to create a package for Xenomai for Yocto or Openembedded?
> 
> I have a client side package at my layer, you could check it at:
> 
> http://github.com/veter-team/veterlayer/tree/master/recipes/xenomai
> 
> It's pretty strait forward. Kernel is different story, I've just made
> a patch to customized kernel:
> 
> http://github.com/veter-team/veterlayer/tree/master/recipes/linux
> 
> Hope this helps,
> Maksym.
> http://veter-project.blogspot.com


Adding I-pipe and Xenomai as a single patch to the kernel does not seem
the way to go.

I would rather have the linux kernel building rules call
prepare-kernel.sh to apply the I-pipe patch and setup xenomai links to
the xenomai package source directory. It is not really hard, and it
makes things way easier to maintain.

-- 
                                                                Gilles.

