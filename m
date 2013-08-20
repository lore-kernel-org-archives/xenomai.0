Message-ID: <5213F7DA.1010200@xenomai.org>
Date: Wed, 21 Aug 2013 01:12:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52138425.2030000@steinkuehler.net> <5213B7D3.5030606@xenomai.org>
	<5213C836.403@steinkuehler.net> <5213C9AD.2010903@xenomai.org>
	<5213D09E.80103@steinkuehler.net> <5213EFBA.90608@steinkuehler.net>
In-Reply-To: <5213EFBA.90608@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Building BeagleBone kernel from git
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 08/21/2013 12:37 AM, Charles Steinkuehler wrote:
> On 8/20/2013 3:25 PM, Charles Steinkuehler wrote:
>> On 8/20/2013 2:55 PM, Gilles Chanteperdrix wrote:
>>> You want the I-pipe patch. To generate it, in the I-pipe tree,
>>> try:
>>> 
>>> ./scripts/ipipe/genpatches.sh
>>> 
>>> You should then find a file ipipe-core-3.8.13-arm-1.patch which
>>> you can try and apply to another tree, possibly additionally
>>> patching with pre and post patches (respectively before and
>>> after the I-pipe patch).
>> 
>> Yep, that sounds like exactly what I want!  Thanks for the
>> help!!
>> 
>> I'll report back if I run into more issues or if everything works
>> out OK.  I am trying to integrate the xenomai patches into a
>> customized version of Robert C. Nelson's BeagleBone kernel build
>> scripts:
> 
> Problem #1 (solved): The genpatches.sh script calls awk, but seems
> to be incompatible with the stock awk (mawk) on my Debian Wheezy
> system.  I was getting errors on all the match ($0, ...) lines
> until I installed gawk:

I knew that, sorry for not mentioning it. And by the way, if you know
how to rewrite this in portable awk, patches are welcome.


-- 
                                                                Gilles.

