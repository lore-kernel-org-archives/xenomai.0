Date: Fri, 3 Jun 2016 16:09:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160603140959.GQ1801@hermes.click-hack.org>
References: <CAL8zT=j3AF5CEmEsDczFbb_i7Fe72gOMENLN3yQh_WWu59jrvw@mail.gmail.com>
 <20160603091339.GM1801@hermes.click-hack.org>
 <20160603135534.GD28301@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160603135534.GD28301@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Migrating a Xenomai 2.6.4 to a 4.6 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Fri, Jun 03, 2016 at 09:55:34AM -0400, Lennart Sorensen wrote:
> On Fri, Jun 03, 2016 at 11:13:39AM +0200, Gilles Chanteperdrix wrote:
> > The APIs have not changed much. The cost is not very high. The
> > changes are documented here:
> > https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/
> > 
> > You will have to:
> > - port the I-pipe patch for Linux 4.1 to Linux 4.6
> 
> Would that not be required for xenomai 3.x as well though?
> 
> > - add to the I-pipe patches the "I-pipe legacy" support, which was
> > removed from 4.1
> > - add the missing bits to Xenomai to adapt to the kernel API changes
> > between Linux 3.18 and Linux 4.6, of which there should be a fair
> > amount, given the difference in version numbers.
> > 
> > So, the best strategy is to not migrate xenomai 2.6.4 to a 4.6
> > kernel.
> > 
> > > Would you be interested by the patches once done ?
> > 
> > No. Xenomai 2.6.5 is about to be released, will not support 4.x
> > kernel, and will be the last release in the 2.6 branch. We simply do
> > not have the man power to maintain two branches, and for this
> > reason, want to encourage the users to migrate.
> 
> That does make sense.
> 
> Of course a lot of people are scared of moving xenomai versions.  3 sounds
> quite different than 2.6, and I certainly remember having a fair bit of
> pain going from 2.5 to 2.6 years ago (some of it was probably self inflicted).

As far as I remember there were almost no API changes between 2.5
and 2.6. The main reason to switch from 2.5 to 2.6 was to fix an
issue that could not be fixed reasonably without breaking the ABI.

-- 
					    Gilles.
https://click-hack.org

