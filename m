Date: Fri, 3 Jun 2016 11:13:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160603091339.GM1801@hermes.click-hack.org>
References: <CAL8zT=j3AF5CEmEsDczFbb_i7Fe72gOMENLN3yQh_WWu59jrvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL8zT=j3AF5CEmEsDczFbb_i7Fe72gOMENLN3yQh_WWu59jrvw@mail.gmail.com>
Subject: Re: [Xenomai] Migrating a Xenomai 2.6.4 to a 4.6 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Jun 03, 2016 at 10:06:10AM +0200, Jean-Michel Hautbois wrote:
> Hi !
> 
> I have a 3.18 kernel which is currently built with xenomai 2.6.4.
> I need to keep xenomai 2.6.4, as a lot of applications are using the API,
> and I don't want to migrate, the cost would be very high ATM.

The APIs have not changed much. The cost is not very high. The
changes are documented here:
https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/

> 
> What is the best strategy to migrate xenomai to a 4.6 kernel ?

You will have to:
- port the I-pipe patch for Linux 4.1 to Linux 4.6
- add to the I-pipe patches the "I-pipe legacy" support, which was
removed from 4.1
- add the missing bits to Xenomai to adapt to the kernel API changes
between Linux 3.18 and Linux 4.6, of which there should be a fair
amount, given the difference in version numbers.

So, the best strategy is to not migrate xenomai 2.6.4 to a 4.6
kernel.

> Would you be interested by the patches once done ?

No. Xenomai 2.6.5 is about to be released, will not support 4.x
kernel, and will be the last release in the 2.6 branch. We simply do
not have the man power to maintain two branches, and for this
reason, want to encourage the users to migrate.

-- 
					    Gilles.
https://click-hack.org

