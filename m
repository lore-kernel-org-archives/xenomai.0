References: <eg64ced20shm6v12mr5lh120.1526233045295@embeddedgreg.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cc5a42d0-62f1-66cd-bd63-43e3badeb3a9@xenomai.org>
Date: Sun, 13 May 2018 19:53:26 +0200
MIME-Version: 1.0
In-Reply-To: <eg64ced20shm6v12mr5lh120.1526233045295@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM serial illicit call from head domain 'Xenomai'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, Steve Freyder <steve@freyder.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/13/2018 07:37 PM, Greg Gallagher wrote:
> I can take a look at it this week. I'd like to trace through some of the drivers to get a better understanding of when or if they cause a domain switch.
> 

I pushed a quick fix for the i.MX serial driver, but I believe that a
general review of the oldish drivers we have there would be very useful.

-- 
Philippe.

