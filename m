From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <0CF46CB0-D92C-4DCE-B93F-4291374D8328@korgrd.com>
 <44y3lywp2s.fsf@lowell-desk.lan>
 <0DC99152-08CA-4152-BE75-CA0CE39D654F@korgrd.com>
Date: Tue, 19 Dec 2017 17:47:45 -0500
In-Reply-To: <0DC99152-08CA-4152-BE75-CA0CE39D654F@korgrd.com> (Steve Pavao's
 message of "Tue, 19 Dec 2017 13:49:28 -0500")
Message-ID: <44tvwmwd0u.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cobalt core and Yocto
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Steve Pavao <stevep@korgrd.com> writes:

> Thanks for that tip.  That=92s what I was thinking I might need to do.
>
> I guess the solution in Yocto terms is to rework my I-PIPE patch
> recipe to not directly apply the I-PIPE patch, but rather to call
> prepare-kernel.sh and allow it to apply the patch, plus do the other
> things it needs to do.  I guess that should happen in a do_configure()
> {} block.

That's very much the sort of workflow towards which I was planning to move.=
=20

