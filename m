Date: Tue, 10 Jan 2017 16:07:57 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170110160757.5eb8ccee@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] xenomai 2 LDFLAGS wrappers, posix only
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

i am about to include three more wrappers into xenomai2 to assert_nrt,
later i plan to create a xenomai3 patch as well. The functions to wrap
are __cxa_guard_(acquire|release|abort). They contain mutexes
protecting the initialization state of static objects in c++ code,
often found when people implement the singleton pattern.

I have got the wrapping code but found that xeno-config will create the
wrapping LDFLAGS only for the posix skin. Is that intentional or an
inconsistency?
Even the wrappers in the "common" skin get applied for posix only.

I tried calling malloc/free in a "--skin=native" example and did not
get the SIGXCPU.

Now i am guessing that the way wrappers are applied in xenomai2 is
somehow inconsistent. Is that something that should be fixed by having
common and per skin wrappers, or would it be ok to simply always append
the posix LDFLAGS as well?

Henning

