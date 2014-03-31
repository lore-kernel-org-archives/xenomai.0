Message-ID: <5339BFCF.40900@xenomai.org>
Date: Mon, 31 Mar 2014 21:19:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140331174555.GO17765@csclub.uwaterloo.ca>
 <5339B015.3080008@xenomai.org> <20140331182404.GP17765@csclub.uwaterloo.ca>
In-Reply-To: <20140331182404.GP17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 03/31/2014 08:24 PM, Lennart Sorensen wrote:
> On Mon, Mar 31, 2014 at 08:12:37PM +0200, Gilles Chanteperdrix wrote:
>> On what platform do you get this? If on cortex A8, and the
>> user-space is compiled in thumb2 mode, note that an erratum
>> workaround is needed, flushing the BTB at each context switch to
>> avoid problem when ARM code is replaced by THUMB code at the same
>> (virtual) address when switching context.
> 
> Cortex-A15 (Omap5 system).  User space is thumb2 (Debian Wheezy armhf
> based).

I have an omap5 here, but did not finish the port. In particular, omap5
seems to hang after a while if unlocked context switch is enabled.
> 
>> My advice would be to wait, Philippe is currently merging the I-pipe
>> git with 3.14 (you can actually find the 3.12 merge in my git tree,
>> under the branch raw/for-ipipe-3.12.0, it has been lightly tested
>> though, as I wait for 3.14 to be ready to test more thoroughly).
> 
> Unfortunately the drivers are not fully merged upstream yet, so I am
> using the 3.12 branch from ti's git tree.  I was able to boot 3.14 but
> without ethernet and usb and a few other things.
> 
> Comparing the ipipe changes for 3.14 would be useful though.
> 
> I only saw 3.11 raw in the tree when I was doing that part on thursday.
> Is this new?  Or did I look in the wrong git tree?  No, I did a pull,
> and it is there now.  I guess I was a day or two early. :)

I think Philippe started the port last week, and I fixed the two arm
conflicts during the week-end, so yes, this is fairly recent.

-- 
                                                                Gilles.

