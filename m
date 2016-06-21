From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <447fdp9oue.fsf@be-well.ilk.org>
 <0b7ab1b8-8d53-069a-49b6-a3f289c0b43c@xenomai.org>
 <441t3rlwfe.fsf@be-well.ilk.org>
 <20160620152246.GA18662@hermes.click-hack.org>
 <44wpljkchx.fsf@be-well.ilk.org>
 <20160620171848.GB18662@hermes.click-hack.org>
 <44h9cmz8y1.fsf@be-well.ilk.org> <44d1naz7ub.fsf@be-well.ilk.org>
 <b436e690-79d6-0de7-647a-1ec5c80ae4d9@xenomai.org>
Date: Tue, 21 Jun 2016 16:09:24 -0400
In-Reply-To: <b436e690-79d6-0de7-647a-1ec5c80ae4d9@xenomai.org> (Philippe
 Gerum's message of "Tue, 21 Jun 2016 21:27:38 +0200")
Message-ID: <441t3qz4ln.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] slackspot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> You app is missing a call to pthread_setmode_np() for enabling the
> warn-upon-switch bit,
> e.g. calling pthread_set_mode_np(0, PTHREAD_WARNSW, NULL) would enable
> tracing for the calling thread.

My real application has that. My example stripped out everything I could
live without, including lots of error-checking for errors that generally
don't come up.

I did actually test setting PTHREAD_WARNSW in the example program, and
there was no data to be read from /proc/xenomai/debug/relax.

Be well.

