From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <E6D54D1B-1536-4F5F-9E7B-C8F856F5E3EC@korgrd.com>
Date: Thu, 30 Nov 2017 09:18:00 -0500
In-Reply-To: <E6D54D1B-1536-4F5F-9E7B-C8F856F5E3EC@korgrd.com> (Steve Pavao's
 message of "Wed, 29 Nov 2017 16:53:49 -0500")
Message-ID: <44r2sfzw87.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] matching patch version to kernel version
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Pavao <stevep@korgrd.com>
Cc: xenomai@xenomai.org

Hi, Steve.

Steve Pavao <stevep@korgrd.com> writes:

> I am building Yocto poky linux for an Intel board at head in Master
> branch in Yocto poky, which currently results in a kernel version
> 4.9.61.

I stick to release branches for Poky for my own releases.
Probably not a big deal, as my experience using HEAD on research
projects hasn't been notably painful.

> I see that the latest patch file in the xenomai download area is ipipe-core-4.9.51-x86-4.patch.
>
> Will this patch work OK with the 4.9.61 kernel version, or should I use a different approach to ensure a better match?

You will need to edit the patch (I know from experience that
there are definitely conflicting changes in between those
points), but that's still -- probably -- your best bet. Since
you don't care about ARM-specific files, I don't think you'll
have too hard a time.

Be well. 

