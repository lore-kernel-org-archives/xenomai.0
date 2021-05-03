Date: Mon, 3 May 2021 19:16:15 +0200
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [RFC] status of [meta-]xenomai for Yocto
Message-ID: <20210503191615.7fc657ee@md1za8fc.ad001.siemens.net>
In-Reply-To: <878s4vu52u.fsf@xenomai.org>
References: <878s4vu52u.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum via Xenomai <xenomai@xenomai.org>

We have xenomai-images kind of maintained under the umbrella of the
project. But that is Isar and Yocto sure has its place as well. I have
also seen buildroot layers which include xenomai.

Such integration systems tend to cause a lot of work. A project like
xenomai probably wants to be "very close" to one of them to allow
continous testing. We have that internally based on Isar and i think
Intel might be going the same way.

Not against the idea, but also not convinced.

regards,
Henning

Am Mon, 3 May 2021 18:58:49 +0200
schrieb Philippe Gerum via Xenomai <xenomai@xenomai.org>:

> I'd like to discuss the current status of what exists, what might be
> planned regarding a meta layer which would/does provide support for
> Xenomai-enabled kernels. This could be a topic raised during the next
> community meeting.
> 
> I can see a couple of options floating around on the net, all
> dedicated to specific hardware it seems, some/all extending their
> support up to the rootfs image.
> 
> Would it be possible to conceive such support as a meta-bsp layer
> instead, implementing a new kernel type, one that could be included in
> bbconf settings without imposing anything about the image to be
> produced?  Something which could be extended to cover Xenomai 4/EVL at
> some point as well.
> 
> It would be nice to discuss ideas around the general topic of having a
> reference meta layer for Xenomai in the most flexible way. Whether it
> already exists, or not.
> 


