Date: Thu, 8 Feb 2018 14:51:21 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180208145121.7551c081@mmd1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai community meeting 2018, meeting minutes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>, Steven Seeger <steven.seeger@nasa.gov>, karim.yaghmour@opersys.com

Hi,

on 02/02/18 we had an open community meeting in Brussels to discuss
topics around Xenomai. Both the recent development as well as plans for
the future.

We at Siemens work closely together with Philippe Gerum. We first
considered inviting him to our office in Munich and have an internal
meeting. But i am happy we went for the open meeting instead. The crowd
was not too big and some attendees where mostly silent, i would still
call it a success. For me personally it was nice to meet in person,
after contributing to Xenomai for a few years now.
Let us see whether we can make that a more regular event and motivate
even more people to show up and speak about their usage of Xenomai in
their projects or even products.

Henning

--------

Attendees:
----------
local:
 Philippe Gerum, Karim Yaghmour, Jan Leupold, Sebastian Smolorz, Jeroen
 Van den Keybus,  Niels Wellens, Jan Kiszka, Henning Schild
remote:
 Greg Gallagher, Dmitriy Cherkasov

Ipipe:
------
- it was decided that the following arches will not be supported
  anymore:
  - blackfin, ppc64, arm32 < v7
- the remaining ones will be maintained by these people
 - Steven Seeger ppc32
 - Dimitri Cherkasov arm64
 - Philippe Gerum arm32 >= v7
 - Jan Kiszka i386/x86_64
- Philippe described the current state of the pipeline patches
 - the maintainability of these patches was identified as a critical
   issue of the project
 - hard to rebase, understand etc.
- new approach for the patches discussed
 - split "the patch" into a clear series of patches, with meaningful
   commit messages
 - and improve that split over time
 - that should mitigate the mentioned problems, increase quality and
   ease maintenance
 - authership of contributions should be kept
- supported kernel versions
 - we will aim to provide ipipe-patches for the respective latest LTS
 - patch series will be rebased onto .0 release
 - in rebase fold/squash or split patches to keep it a clear series
 - it is not fully clear whether rebase or merge workflows will be used
   within one release (i.e. from 4.4.0 to 4.4.71)
 - only _one_ LTS kernel will be officially supported at a time
 - older LTS branches can be maintained if anyone signs up for doing
   that (Siemens is likely to keep working on 4.4 for a while)
 - maintainers of such branches will have to "poll" the latest branch
   to find out about fixes that might require backporting
- upstreaming of Ipipe
 - the current patchset can not be used for upstreaming into the Linux
   kernel
 - the new split patchqueue could have some potential for getting tiny
   bits merged
 - for the real merge, Philippe has version 4 of the pipeline in the
   making
  - that could "come close" but is still in the making (with little
    time to work on it)
  - we will need a "user" of that when we propose it upstream

Workflows/Releases:
-------------------
- upcoming release of ipipe 4.14
 - x86 still has FPU issues, the rest is done
- upcoming xenomai release 3.0.7
 - contains rtnet-fixes, x86 build fixes and more
 - still waiting for ipipe-4.14 but could be released without that
- upcoming xenomai release 3.1
 - introduce arm64, see git
 - waiting for ipipe-4.14

- there will be no release plan or schedule
- users should learn to use git and forget about release tags

Infrastructure:
--------------
- xenomai and ipipe will move to gitlab of denx (should be mostly
  transparent for users)
- mailinglist moves to denx (again, should be transparent)
- open questions:
 Will issues, pull-request and wikis from gitlab be open?
 Will the website move into gitlab?

Roles:
------
- Ipipe arch maintainers (see above)
- Philippe Gerum: Ipipe Integrator
- Philippe wants to hand over most of his current duties until 09/18

Roles/Tasks we need volunteer for:
 - release manager
 - public relations
  - gather/collect information from the "inside"
   - who is using xenomai, for what, who is working on what, which
     arches are of interest, where does the community see issues
  - outside
   - talks on conferences
   - publish whitepapers on your products (so the project can reference
     you as a user)
  - annual conference ??
  - PR is a role that everyone should contribute to!
  - collect users overview, maybe start surveys
  - usage stats could be extracted from our website, downloads,
    mailinglists
   - for now we do not look at that and try to not be nosy
   - if we use it, we will make these stats available
   - usage stats could be very useful for users as well
    - get an idea how popular Xenomai is
    - where in the world
    - which versions especially
 - improve documentation
  - write a recent "hello world" tutorial
  - describe the "dual-kernel-approach" from high-level to help
    newcomers
  - such tasks should be taken over by people that do not actually know
    too much about xenomai, to cover the real painpoints that devs
    would not run into
 - testing responsible

Drivers:
--------
- drivers are the biggest issue in the "xenomai" side of the project
  - bit rot, often do not even compile and seem broken since years
- discard or keep them -> probably start discarding them bit by bit
- some serve as useful examples/templates but others are in such a bad
  state that they make very bad examples
- "analogy" is basically unmaintained since 7 years
 - how many users are actually interested in that? from the attendees
   we had a 0.5/10
 - mostly untested and barely made to work on 3.x

Documentation:
--------------
- we assume the Ipipe-side will get solved with the transformation of
  "the patch" to the perfectly understandable series ;)
- overall there is high quality documentation of almost all aspects of
  Xenomai
- it is not be structured in a way that is easy to find/consume
- hence the need for restructuring when we move the website to the new
  hoster
- and the need to write tutorial that walk newcomers through the
  technical details and introduce docs at appropriate places

- it would be nice if more users spoke openly about using xenomai
  - the typical industry consume-only way is a problem for the project
  - write a white paper and get in touch so we can publish a link on
    the website
  - or show up with your real domain on the mailinglist
  - why do you use xenomai, why not i.e. Preempt-RT
   - if we all know about each other it is much easier to stand against
     "the troll" or your manager that thinks he can just buy such a
     thing

Testing:
--------
- with the new hoster we will have gitlab-ci to control or run all
  sorts of tests
- at the end we would like to have all that in CI:
  - compile tests for all arches and multiple configs
  - full OS image generation for testing on reference boards
  - functional testing "smokey"
  - performance testing ("latency", "switch-test" etc. combined with
    stress, dd, ...)
- we will have to divide and conquer and start with the low-hanging
  fruits like compile-only
- all testing infrastructure should be open, ideally contributers
  should be able to use it as well, or at least see the reports
- Gilles used to run a CI that could do a lot of the above
 - but that was pretty custom and would be hard to use/maintain without
   Gilles ... given the code can still be found

