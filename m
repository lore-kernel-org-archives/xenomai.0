From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 3 Jun 2016 09:49:32 -0400
Message-ID: <20160603134932.GC28301@csclub.uwaterloo.ca>
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
> 
> What is the best strategy to migrate xenomai to a 4.6 kernel ?
> Would you be interested by the patches once done ?

Well I managed to take the ipipe for 4.1 and then add xenomai-2.6 latest
git to that and with just a couple of minor tweaks the patches applied
and built and seemed to pass all the tests I threw at it.  I can't
imagine 4.4 would be much harder than 4.1, although I didn't check if
ipipe work had been done for 4.4 yet.  Didn't get a chance to full test
it though and I moved to a new job a few weeks ago, so I don't have the
code handy either unfortunately (although I could probably ask for it).

-- 
Len Sorensen

