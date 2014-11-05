Message-ID: <545A3266.80908@xenomai.org>
Date: Wed, 05 Nov 2014 15:21:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAB6vvjntO_zseYw-nKrGUKAX2k9D-FhMvwRsY8Hz7pnE1TkUXw@mail.gmail.com>
 <545A28FA.2040204@xenomai.org>
In-Reply-To: <545A28FA.2040204@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Error building cobalt kernel (xenomai3 on 3.14.17)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <hoarau.robotics@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/05/2014 02:41 PM, Philippe Gerum wrote:
> On 11/05/2014 02:03 PM, Antoine Hoarau wrote:
>> Hello everyone,
>>
>> I'm trying to build a 3.14.17 cobalt kernel with xenomai 3, but I'm facing
>> an error in syscall32.h : cobalt/kernel/compat.h no such file or directory.
>>
>> Any clues ?
>>
>> Thank you!
>>
> 
> This looks like a packaging issue with the latest -rc tarball, please
> pull from git://git.xenomai.org/xenomai-3.git, master branch.
> 

The tarball has been fixed on the dl area. Thanks for the heads up.

-- 
Philippe.

