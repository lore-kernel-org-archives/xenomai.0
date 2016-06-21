From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <447fdp9oue.fsf@be-well.ilk.org>
 <0b7ab1b8-8d53-069a-49b6-a3f289c0b43c@xenomai.org>
 <441t3rlwfe.fsf@be-well.ilk.org>
 <20160620152246.GA18662@hermes.click-hack.org>
 <44wpljkchx.fsf@be-well.ilk.org>
 <20160620171848.GB18662@hermes.click-hack.org>
Date: Tue, 21 Jun 2016 14:35:34 -0400
In-Reply-To: <20160620171848.GB18662@hermes.click-hack.org> (Gilles
 Chanteperdrix's message of "Mon, 20 Jun 2016 19:18:48 +0200")
Message-ID: <44h9cmz8y1.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] slackspot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:

> On Mon, Jun 20, 2016 at 01:15:38PM -0400, Lowell Gilbert wrote:
>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
>> 
>> > There is one possibility: if your thread runs with the
>> > SCHED_OTHER/SCHED_WEAK scheduling policy, I would not expect the
>> > relaxes to trigger anything, as you have been asking for them by
>> > choosing to use these policies.
>> 
>> Yes, I should have mentioned that topic. I have run this under both
>> SCHED_FIFO and SCHED_RR.
>
> Ok. Could you post an example allowing us to reproduce the issue ?

I can. It took me a little longer than I figured because I had
accidentally deleted the MODULE_LICENSE. Is it possible to get the
kernel makefiles to tell you *why* it isn't linking in libraries you
asked for?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: example.tar
Type: archive/tar
Size: 10240 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160621/eb21f260/attachment.bin>
-------------- next part --------------
I'm attaching a tar file, but in case this list strips attachments, it's
also at
 http://be-well.ilk.org/~lowell/example.tar
It's about a hundred lines each for the application and kernel module.

Thank you.
