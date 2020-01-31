Subject: Re: [PATCH 0/8] Assorted fixes
References: <20200131152713.1811748-1-rpm@xenomai.org>
 <0c811fd4-dc46-0bce-99b3-64c150725d3d@siemens.com>
 <230535ea0245408dbd941bc26c4f6df9@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bbab7ccf-0f5e-617a-2d94-afc79f2d7efa@siemens.com>
Date: Fri, 31 Jan 2020 18:52:23 +0100
MIME-Version: 1.0
In-Reply-To: <230535ea0245408dbd941bc26c4f6df9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meng, Fino" <fino.meng@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Fino,

On 31.01.20 17:25, Meng, Fino wrote:
> Hi Jan
> 
> Regarding to torture tests, do we have a recommend test suite & working flow  from the community?
> I searched xenomai wiki but didn't find a guide for this.

Out testing leaves a bit of room for improvement, but it is getting 
better. What we have so far is the smokey testsuite which is part of 
many of our test runs. It has some shortcomings, e.g. unstructured 
reporting, but it is at least a baseline. There are some further tests, 
like switchtest, that are also included when running xeno-test. And then 
there are loose ends like lib/*/testsuite that should probably be hooked up.

> We plan to recommend UP Extreme board (https://up-board.org/up-xtreme/)  to public users since it's easy to buy for anyone
> And we want to write a guide for torture test, at least for these boards,

Defining reference boards is indeed another topic. I think we started 
that at some point on the list, but it did not go very far.

On x86, the situation is rather comfortable as the reference image we 
produce with xenomai-images works well on many boards and larger 
systems. I don't have an UP board around but many products that have at 
least similar SoCs. We once played with a Minnow board but that was, 
well, not recommendable. The UP Xtreme could be another option.

The next level is then automated execution of tests. There are many 
ways, the one we are preparing so far is LAVA-based. Quirin started that 
in 
https://code.siemens.com/ebsy/debian/xenomai-images/tree/master/tests. 
He is busy the next weeks but he wants to follow-up on that with more 
details afterwards so that we can discuss in the community if that could 
become an official pattern for Xenomai.

Any comments, suggestions in this area are of course welcome!

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

