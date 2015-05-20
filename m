Message-ID: <555CCA71.4010905@zultron.com>
Date: Wed, 20 May 2015 12:54:57 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <555C2BE9.3020001@zultron.com>
 <20150520164005.GJ10686@hermes.click-hack.org> <555CC91A.9090901@zultron.com>
In-Reply-To: <555CC91A.9090901@zultron.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 3.0 packaging fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



On 05/20/2015 12:49 PM, John Morris wrote:
>
>
> On 05/20/2015 11:40 AM, Gilles Chanteperdrix wrote:
>> On Wed, May 20, 2015 at 01:38:33AM -0500, John Morris wrote:
>>> I needed the top 5 commits here to build 3.0 packages:
>>>
>>>      https://github.com/zultron/xenomai
>>>
>>> Pick them or not, as you please.  If you prefer them in email, let me
>>> know.
>>
>> I you could put a link which lists clearly the commits you are
>> talking about, it would make looking at them simpler. But the last
>> commit, which readds autoreconf has already been discussed on this
>> list. We do not want that.
>
> Ok.  The other four:
>
> https://github.com/zultron/xenomai/commit/9e870cf1

> https://github.com/zultron/xenomai/commit/2253220c
I'm sure 2253220c will be disagreeable, and it's incorrect, since 
Xenomai has switched to `3.0 (native)` format packaging.  Please just 
take it as a reminder to update the version in `debian/changelog`.


> https://github.com/zultron/xenomai/commit/25fb98b6
> https://github.com/zultron/xenomai/commit/d95a071c
>
> Thanks-
>      John

