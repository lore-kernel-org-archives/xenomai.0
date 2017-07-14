References: <968f7e35-f447-40d9-0d41-0ed8f13c59f5@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <33b9c7be-a9c3-04d7-1ba6-88a2670b9717@xenomai.org>
Date: Fri, 14 Jul 2017 11:08:40 +0200
MIME-Version: 1.0
In-Reply-To: <968f7e35-f447-40d9-0d41-0ed8f13c59f5@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 07/13/2017 09:59 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> would it be possible to remove the generated docs from git? When doing
> full-text searches, it's extremely unhandy to have them in history
> (that's unfortunately too late now) and in the current repo (git grep).
> Moreover, they add more and more bloat to the repo.
> 
> I suppose you make use of them when generating release tarballs and for
> pushing them to the webserver. But both could also be scripted, I'm sure.
> 

I agree, the need for such pre-built documentation in the tree
disappeared when the same stuff could be found on the website. I'll drop
this in 3.1.

-- 
Philippe.

