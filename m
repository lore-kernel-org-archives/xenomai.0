Date: Mon, 1 Oct 2018 11:12:04 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20181001111204.7a8f5d0c@md1pvb1c.ad001.siemens.net>
In-Reply-To: <1736385944.1779097.1538339902687@mail.yahoo.com>
References: <1736385944.1779097.1538339902687.ref@mail.yahoo.com>
 <1736385944.1779097.1538339902687@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe for 4.14 x86?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alec Ari <neotheuser@ymail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Sun, 30 Sep 2018 20:38:22 +0000
schrieb Alec Ari <neotheuser@ymail.com>:

> This message is meant to be part of the preexisting thread, "ipipe
> for 4.14 x86?"
> 
> I see that 4.14 development is in a branch labeled "split." I read
> through this already:
> https://www.xenomai.org/pipermail/xenomai/2018-September/039458.html
> 
> So the base functionality of IPIPE is still the same, but with the
> split series, this makes commits and code changes easier to dissect?
> 
> When 4.14 support reaches this page:
> https://xenomai.org/downloads/ipipe/v4.x/x86/
> 
> How different will the final patch be to the rest of the patches? Is
> the structure for the most part the same and follow the same pattern
> as the other patches, or will a patch derived from "split" have other
> changes in the final patch? Are all the changes in the split series
> purely cosmetic compared to the other IPIPE patches? Are there even
> any changes to the kernel compared to the other IPIPE patches, or is
> this purely breaking up commits? I'm a bit confused as to how this
> affects the final ipipe-core patches as that is what I use for a
> baseline, not the IPIPE git repos.

This is a change in how the "patch" is structured internally for
developers only. If you look into the git history we always had more
than one patch being part of the "patch", starting from 4.14 the
granularity will be increased.

You will still get one patch to apply to your random vendor kernel that
roughly matches ;).

Henning

> Thank you!
> 
> Alec
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


