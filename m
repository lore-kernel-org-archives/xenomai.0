Date: Fri, 14 Jul 2017 13:11:46 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170714131146.61d08c59@md1em3qc>
In-Reply-To: <029e78a9-49de-cfea-fd1a-7c07a3513d5c@siemens.com>
References: <968f7e35-f447-40d9-0d41-0ed8f13c59f5@siemens.com>
 <20170714102448.0b4c3fe3@md1em3qc>
 <029e78a9-49de-cfea-fd1a-7c07a3513d5c@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Remove generated docs from git
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Am Fri, 14 Jul 2017 10:26:31 +0200
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 2017-07-14 10:24, Henning Schild wrote:
> > Am Thu, 13 Jul 2017 21:59:06 +0200
> > schrieb "[ext] Jan Kiszka" <jan.kiszka@siemens.com>:
> >   
> >> Hi Philippe,
> >>
> >> would it be possible to remove the generated docs from git? When
> >> doing full-text searches, it's extremely unhandy to have them in
> >> history (that's unfortunately too late now) and in the current
> >> repo (git grep). Moreover, they add more and more bloat to the
> >> repo.  
> > 
> > I agree that it should not be in git. My solution is to remove them
> > and i do not use git-grep anyways. 
> > For a working git-grep just do:
> > "echo 'doc/**/*' >> .gitignore"  
> 
> This doesn't work, unfortunately.

Sorry, got confused because my doc/ was deleted already. To solve the
messed up status i commit that away. But actually this thread is about
solving that upstream and not finding local workarounds.

Henning

> Jan


