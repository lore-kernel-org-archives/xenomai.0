Date: Fri, 14 Jul 2017 10:24:48 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170714102448.0b4c3fe3@md1em3qc>
In-Reply-To: <968f7e35-f447-40d9-0d41-0ed8f13c59f5@siemens.com>
References: <968f7e35-f447-40d9-0d41-0ed8f13c59f5@siemens.com>
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
To: "[ext] Jan Kiszka" <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Am Thu, 13 Jul 2017 21:59:06 +0200
schrieb "[ext] Jan Kiszka" <jan.kiszka@siemens.com>:

> Hi Philippe,
> 
> would it be possible to remove the generated docs from git? When doing
> full-text searches, it's extremely unhandy to have them in history
> (that's unfortunately too late now) and in the current repo (git
> grep). Moreover, they add more and more bloat to the repo.

I agree that it should not be in git. My solution is to remove them and
i do not use git-grep anyways. 
For a working git-grep just do:
"echo 'doc/**/*' >> .gitignore"

Henning

> I suppose you make use of them when generating release tarballs and
> for pushing them to the webserver. But both could also be scripted,
> I'm sure.
> 
> Jan
> 


