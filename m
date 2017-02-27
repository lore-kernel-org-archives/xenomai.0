Date: Mon, 27 Feb 2017 10:57:11 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170227105711.6d08a2ee@md1em3qc>
In-Reply-To: <19bf2d00-6d10-328b-98e8-9b8544e8b718@xenomai.org>
References: <1487858660615.24262@kth.se>
 <cac2495a-6508-6e54-b577-28f8559dcc7e@xenomai.org>
 <20170227095651.0553fcc4@md1em3qc>
 <19bf2d00-6d10-328b-98e8-9b8544e8b718@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Where can I find the ipipe patch for linux kernel
 v4.4.y
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Nitin Kulkarni <nitink@kth.se>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Mon, 27 Feb 2017 10:00:49 +0100
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 02/27/2017 09:56 AM, Henning Schild wrote:
> > Am Sat, 25 Feb 2017 18:57:56 +0100
> > schrieb Philippe Gerum <rpm@xenomai.org>:
> >   
> >> On 02/23/2017 03:04 PM, Nitin Kulkarni wrote:  
> >>> Hi,
> >>>
> >>> I am trying to apply the ipipe patch to an Ostro distribution
> >>> which has a 4.4.36 Kernel.
> >>>
> >>> I see that the latest I pipe patch on
> >>> https://xenomai.org/downloads/ipipe/v4.x/x86/? is 4.1.18.
> >>>
> >>>
> >>> Can you please give some insights on where to get the patch for
> >>> 4.4 ?
> >>>
> >>>     
> >>
> >> Same location, just uploaded.  
> > 
> > I would expect that to reflect the git-repo somehow and show up as
> > tag on the ipipe-4.4.y branch. As far as i can see there are no
> > tags on that branch yet, so i am also wondering where the -6 comes
> > from. 
> 
> From tags that were not pushed.

I see those tags are at the branch-head i am already working with. When
is the IPIPE_CORE_RELEASE reset to 0 or 1? On the 4.1 branch it
started over at 1 for all archs, in 4.4 it is between 5 and 7.

Henning

