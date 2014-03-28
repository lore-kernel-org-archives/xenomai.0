Message-ID: <5335B0DD.80709@xenomai.org>
Date: Fri, 28 Mar 2014 18:26:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAK4EZFSwAxewjWsgzXkjNaixnN8o5iWFzvx91VKdsB+F5pg-bA@mail.gmail.com>
In-Reply-To: <CAK4EZFSwAxewjWsgzXkjNaixnN8o5iWFzvx91VKdsB+F5pg-bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Patch for ipipe-core-3.8.13-raspberry-post-2.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Adam Vaughan <vaughana@umich.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/28/2014 06:22 PM, Adam Vaughan wrote:
> Hi Gilles,
>
> Do you want to include this -post patch in Xenomai 2.6 for now while
> work is done on the 3.10 kernel?  It includes all the changes that were
> discussed on the forum earlier.

The fix of asm/ipipe_hwirq.h should not be put into this patch, but in 
the generic patch.

-- 
					    Gilles.

