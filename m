Message-ID: <533EDE00.9070407@xenomai.org>
Date: Fri, 04 Apr 2014 18:29:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52F9FD79.5030401@siemens.com> <533ED24C.1040103@siemens.com>
In-Reply-To: <533ED24C.1040103@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL][forge] Merging debian/* into -forge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gernot Hillier <gernot.hillier@siemens.com>, xenomai@xenomai.org

On 04/04/2014 05:39 PM, Gernot Hillier wrote:
> Hi there!
>
> On 11.02.2014 11:37, Gernot Hillier wrote:
>> The following changes since commit
>> ab722a488be1cc0b8879784551c7648503a8186c:
>>
>>    bootstrap (2014-02-09 17:43:21 +0100)
>>
>> are available in the git repository at:
>>
>>    git://github.com/siemens/xenomai-forge.git debian-for-forge
>
> I did a small bugfix to one of my patches there and also rebased this
> branch to current forge master, which is a good opportunity to say: <ping>.
>
> You, Gilles, said last year, I shall feel free to post patches if I need
> debian infrastructure in -forge. This is my third post regarding that,
> we use those patches to build and deploy test packages since months, so
> I'd say, this qualifies as "I need it". :)
>
> So how can we proceed with this?
>
> Please let me know if you need another pull request, another review
> round, another format of patches or whatever. I'd really love to see
> this included in -forge soon as this is currently a blocking point for
> me to setup automatic nightly tests for -forge in our x86 scenario.
>

I merged the core of it a week ago with other backported bits from 
recent 2.6 updates:
a3a8249023652bc31238db554ec5a788b5016b46

This still needs validation though.

-- 
Philippe.

