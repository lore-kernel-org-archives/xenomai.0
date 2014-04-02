Message-ID: <533C21A0.30502@xenomai.org>
Date: Wed, 02 Apr 2014 16:41:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <533B270F.4060702@xenomai.org>
 <20140401214539.GD17765@csclub.uwaterloo.ca>
 <20140402023531.GE17765@csclub.uwaterloo.ca> <533BB83F.5040301@xenomai.org>
 <20140402132401.GF17765@csclub.uwaterloo.ca> <533C100A.7050501@xenomai.org>
 <20140402134017.GG17765@csclub.uwaterloo.ca>
 <20140402134133.GH17765@csclub.uwaterloo.ca>
 <20140402134609.GI17765@csclub.uwaterloo.ca> <533C1709.3090305@xenomai.org>
 <20140402143809.GJ17765@csclub.uwaterloo.ca>
In-Reply-To: <20140402143809.GJ17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 04/02/2014 04:38 PM, Lennart Sorensen wrote:
> On Wed, Apr 02, 2014 at 03:56:25PM +0200, Gilles Chanteperdrix wrote:
>> On 04/02/2014 03:46 PM, Lennart Sorensen wrote:
>>> On Wed, Apr 02, 2014 at 09:41:34AM -0400, Lennart Sorensen wrote:
>>>> Here is the argv array it is getting:
>>>>
>>>> argv=[/usr/lib/xenomai/testsuite/xeno-test-run][/usr/bin/xeno-regression-test][xeno-regression-test][-l][/usr/lib/xenomai/testsuite/dohell -s 10.200.19.25 -m /mnt -l /mnt]
>>>>
>>>> No wonder it isn't working.
>>>
>>> Found it.  it can happen when the user isn't capable of operating cut and paste:
>>>
>>> root@omap5:/mnt/xenomai-2.6.3# xeno-regression-test xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -s 10.200.19.25 -m /mnt -l /mnt" -t 2
>>>
>>> Lets try fixing that shall we...
>>
>> PEBKAC then. Ok, -t 2 measures the irq latency, it may not be what you want.
>
> I don't know what I want.  I just wanted to run something to check
> xenomai is actually working.
>
> It would appear it is.
>
> So is there a time this test will run for or do I have to kill it at
> some point?
>
It will run the whole LTP testsuite twice, this should last a few hours. 
If one test gets stuck (like mallocstress with some versions of gcc), 
simply kill it, and LTP will continue. I have been running a modified 
version of LTP 2008 since, well, 2008, and have reinstalled a more 
recent version only recently and did not test if the changes I made over 
time to the 2008 version were still needed.

-- 
					    Gilles.

