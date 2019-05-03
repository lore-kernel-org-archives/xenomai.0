From: Lowell Gilbert <kludge@be-well.ilk.org>
Subject: Re: having problems with daemonizing
References: <44ftq4zcr9.fsf@be-well.ilk.org> <5CC38412.8030107@freyder.net>
 <e0ff187c-8247-e7ed-0ee4-b9a195a393b6@xenomai.org>
 <5b7e96a4-043d-484b-f05b-a96e1697bcf6@xenomai.org>
Date: Fri, 03 May 2019 10:26:07 -0400
In-Reply-To: <5b7e96a4-043d-484b-f05b-a96e1697bcf6@xenomai.org> (Philippe
 Gerum via Xenomai's message of "Fri, 3 May 2019 13:12:26 +0200")
Message-ID: <4436lvbon4.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum via Xenomai <xenomai@xenomai.org>

Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:

> Could you try the patch below? Ideally, we should have this in 3.0.9 if this improves the situation.

It works for me with auto-init enabled, and solves my file-open problem as well.

