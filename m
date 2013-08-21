Message-ID: <52147CD7.70400@siemens.com>
Date: Wed, 21 Aug 2013 10:39:51 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RFC] x86 port to kernel 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

in the process of updating our kernel support to current (and long-term)
stable 3.10, I've pushed the I-pipe master tree to that version. The
tree is available at

git://git.xenomai.org/ipipe-jki.git next-x86

Though the focus is on x86, this became a full merge, ie. I also tried
to resolve ARM and PowerPC conflicts (other archs had none). But I'm
sure I broke some things (or things were already broken after the 3.9
merge - there were suspicious unresolved conflicts). So these arch need
a careful check! Specifically watch out for merges that resolved
conflicts in their trees.

The reason for doing this full merge is that there were simply too many
merges into Linus' tree that touched x86 and other archs in the same
run. It made no sense to split them up, only pulling what affects x86.
And I guess this will also remain true in the future.

Instead of merging 3.10 in one run (like Philippe did with 3.9), I
applied the following script-driven algorithm (can share it if there is
interest): merge stepwise what went into Linus' tree, stop when there is
a conflict that requires manual actions. Go one commit back in Linus'
tree and merge this one first (to reduce the number of merges into the
I-pipe tree). Then merge the conflicting commit, resolve it manually and
resume the merges. The result looks like this:

late I-pipe fix-ups for 3.10
merge "3.10"
merge "commit B" <-- required manual conflict solving
merge "commit A" <-- merged without conflicts
...
I-pipe head for 3.8

The advantage of this pattern is that we get more bisection points in
case something subtly breaks between 3.8 and 3.10. The disadvantage is
that the I-pipe history becomes more complex than it already is. I only
did builds and tests after reaching 3.10 (therefore the later fix-ups).
This could still be improved by doing builds after each merge - but it
would extend the required time significantly. Please let me know your
opinion about this approach and how to improve it further.

To test the current state, a few Xenomai patches are required. Find the
basic set at

git://git.xenomai.org/xenomai-jki.git for-upstream

This currently leaves CAN and Analogy broken due to procfs changes.
Maybe I'll be able to look into them later. RTnet will need a massive
update, too.

Feedback, test reports etc. are welcome!

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

