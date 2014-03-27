From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <CAEbDrgn=VM340xozWgS=8aap5Wkw2YCynGDSwtj9m1415J+XYw@mail.gmail.com>
Date: Thu, 27 Mar 2014 11:33:44 -0400
In-Reply-To: <CAEbDrgn=VM340xozWgS=8aap5Wkw2YCynGDSwtj9m1415J+XYw@mail.gmail.com>
 (Gregory Dymarek's message of "Thu, 27 Mar 2014 14:56:28 +0000")
Message-ID: <44ha6j7j1j.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] Raspberry Pi - 3.10.34
Reply-To: "xenomai@xenomai.org" <xenomai@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gregory Dymarek <gregd72002@gmail.com> writes:

> To get kernel 3.10.34 to work the ipipe patch needs updating.
> (ipipe-3.8.x does not apply cleanly).
>
> What is the process to release a new ipipe patch for 3.10.34?
>
> Or what is the alternative?

The source control trees are easily available, so there are a lot of
options.

I did a "git merge" to bring the ipipe-3.10 branch into my 3.10 kernel
branch. If I didn't have a lot of my own (evolving) hardware to deal
with, I might not have needed to merge at all, so the ipipe-3.10 branch
itself might be good enough for some people. 

Producing the patch may be as simple as a simple "git diff" operation.

