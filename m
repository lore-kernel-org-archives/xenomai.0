Message-ID: <51C800C7.3040707@siemens.com>
Date: Mon, 24 Jun 2013 10:18:15 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <011001ce6f6b$44fb8080$cef28180$@z9.com>
In-Reply-To: <011001ce6f6b$44fb8080$cef28180$@z9.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on 3.8.13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <gpontis@z9.com>
Cc: xenomai@xenomai.org

On 2013-06-22 19:09, George Pontis wrote:
> 2013/6/11 Jan Kiszka <jan.kiszka@siemens.com>:
>> Hi all,
>>
>> I've merged 3.8.13 into our stable 3.8 branch. This triggered some 
>> minor conflicts in generic and ARM code. Please see
>>
>> git://git.xenomai.org/ipipe-jki for-upstream/3.8
>>
>> for details. The result works fine for x86, and if it's also OK for 
>> the other arch, I'd propose this to be merged into the official 3.8 
>> stable branch.
>>
>> Jan
>>
> 
> Would this be used with Xenomai 2.6 current git ?

Yes, you need Xenomai 2.6 to be able to build for 3.x kernels. The last
release 2.6.2.1 is fine.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

