Date: Wed, 18 Feb 2015 21:52:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150218205228.GN30317@hermes.click-hack.org>
References: <CA+C+_XS5KxwQ=YKXD6YZ_T41+xdh8q+ag4Xh-Me6EoHLHJ3-Dg@mail.gmail.com>
 <20150218195219.GL30317@hermes.click-hack.org>
 <CA+C+_XSPcEAc3EKJWVZUvkVCf617j-WygceMjUXYOXWAJc8gzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+C+_XSPcEAc3EKJWVZUvkVCf617j-WygceMjUXYOXWAJc8gzQ@mail.gmail.com>
Subject: Re: [Xenomai] Remote debugging problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Feb 18, 2015 at 02:49:26PM -0600, Mathew Benson wrote:
> That's what I thought.  I also gave you the wrong gdbserver version.  Its
> 7.4.1.  The Fedora repos for my host have arm-linux-gnueabihf 7.6.2, but
> I'm not finding 7.4.1 yet.  Do you have any recommendations of where to
> find an RPM for gdb 7.4.1 on Fedora 21 x86_64?  I haven't found an rpm yet
> and I prefer not to have to compile from source.  Or, should I upgrade the
> target gdbserver to to 7.6.2?

A well behaved toolchain provides the gdbserver and the
corresponding cross gdb for the architecture for which you are
compiling.

-- 
					    Gilles.

