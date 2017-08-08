Date: Tue, 8 Aug 2017 11:23:57 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170808112357.0063d74d@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RFC] Xenomai3 tuneables replaced by environment variables
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: "KISZKA, JAN" <jan.kiszka@siemens.com>

Hey,

xenomai3 has its tuneables and they can be set with command-line
parameters and setup_descriptors.

1.
The command-line parameters impose on the application, it has to be
modified to skip/ignore them. And ultimately it has to keep a list of
valid ones to do so pedanticly. If there are name clashes behaviour is
unclear. i.e. "--help" ld.so vs. dlopen

2.
The setup_descriptors do work but they rely on getting the order
stricly right. They have to execute before the first xenomai_init(). In
complex applications with multithreaded init using dlopen() and
auto-init-solib that quickly turns out to be unusable.

Suggestions:
1.
1.1 completely drop the support for parameters and the fiddling
    with /proc/cmdline
1.2 or agree on a prefix "--xeno-" so the application can ignore all
    xenomai parameters without knowing all

2.
2.1 completely drop the setup_descriptors in favour of environment
    variables

That would be a drastic change but i think we should do something about
it. With environment variables it is clear what happens without messing
with the applications init or parameters, getting rid of confusing
complexity.

Please let me know what you think, i would be happy to prepare patches.

Henning

