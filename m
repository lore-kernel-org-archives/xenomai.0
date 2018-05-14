References: <eg64ced20shm6v12mr5lh120.1526233045295@embeddedgreg.com>
 <cc5a42d0-62f1-66cd-bd63-43e3badeb3a9@xenomai.org>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5AF90461.6040404@freyder.net>
Date: Sun, 13 May 2018 22:37:05 -0500
In-Reply-To: <cc5a42d0-62f1-66cd-bd63-43e3badeb3a9@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] RTDM serial illicit call from head domain 'Xenomai'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

   Did a build with that fix, and then installed it and ran the same
   test program - no more traceback - excellent!
   Thanks!
   Steve

   On 5/13/2018 12:53 PM, Philippe Gerum wrote:

On 05/13/2018 07:37 PM, Greg Gallagher wrote:

I can take a look at it this week. I'd like to trace through some of the drivers
 to get a better understanding of when or if they cause a domain switch.


I pushed a quick fix for the i.MX serial driver, but I believe that a
general review of the oldish drivers we have there would be very useful.
