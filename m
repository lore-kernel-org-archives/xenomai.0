From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Sat, 6 Sep 2014 12:55:32 -0400
Message-ID: <20140906165532.GT17690@csclub.uwaterloo.ca>
References: <20140905184346.GN17690@csclub.uwaterloo.ca>
 <20140905211515.GR17690@csclub.uwaterloo.ca>
 <540A286C.2050803@xenomai.org>
 <201409052226.00161.paul_c@tuxcnc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201409052226.00161.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] How to get debug symbols in xenomai libraries
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: xenomai@xenomai.org

On Fri, Sep 05, 2014 at 10:25:59PM +0100, Paul wrote:
> dh_strip in debian/rules is the guilty party here - It is responsible 
> for stripping debug symbols from binary executables and libraries.

Not when you set DEB_BUILD_OPTIONS to nostrip.

-- 
Len Sorensen

