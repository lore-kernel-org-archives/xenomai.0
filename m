References: <20170110160757.5eb8ccee@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <406ae4f5-885c-c624-0b7a-ece67c553b14@xenomai.org>
Date: Wed, 11 Jan 2017 12:03:23 +0100
MIME-Version: 1.0
In-Reply-To: <20170110160757.5eb8ccee@md1em3qc>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai 2 LDFLAGS wrappers, posix only
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 01/10/2017 04:07 PM, Henning Schild wrote:
> Hi,
> 
> i am about to include three more wrappers into xenomai2 to assert_nrt,
> later i plan to create a xenomai3 patch as well. The functions to wrap
> are __cxa_guard_(acquire|release|abort). They contain mutexes
> protecting the initialization state of static objects in c++ code,
> often found when people implement the singleton pattern.
> 
> I have got the wrapping code but found that xeno-config will create the
> wrapping LDFLAGS only for the posix skin. Is that intentional or an
> inconsistency?
> Even the wrappers in the "common" skin get applied for posix only.
> 
> I tried calling malloc/free in a "--skin=native" example and did not
> get the SIGXCPU.
> 
> Now i am guessing that the way wrappers are applied in xenomai2 is
> somehow inconsistent. Is that something that should be fixed by having
> common and per skin wrappers, or would it be ok to simply always append
> the posix LDFLAGS as well?

--posix is supposed to be passed only when a wrapping is expected.
Omitting it allows to build apps over non-POSIX Xenomai APIs, while
assuming that any POSIX call also present in the code can only be
obtained from the glibc.

-- 
Philippe.

