Message-ID: <555AFAC1.5000003@xenomai.org>
Date: Tue, 19 May 2015 10:56:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CANWkrRN33Hvv-ZLh5+op0mYE7gnuZVv-59nWeACSzF1kRR9=5A@mail.gmail.com>
 <CANWkrRP0Fi8bn2FtDdmX54BGH3HBbfkLUsqc7ZbO+BqP6TJu9A@mail.gmail.com>
In-Reply-To: <CANWkrRP0Fi8bn2FtDdmX54BGH3HBbfkLUsqc7ZbO+BqP6TJu9A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno-config packaging issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/19/2015 10:50 AM, Michael Smith wrote:
> On Tue, May 12, 2015 at 2:05 PM, Michael Smith <2michael.smith@gmail.com> wrote:
>> Hi
>> I have compiled the newest 3.x HEAD (5e81f9e) form the GIT repository
>> by creating Debian packages.
>> And when those packages are installed after the compile there is a
>> clash between the "xenomai-runtime" and the "libxenomai-dev" packages.
>> Because "xeno-config" has been included both in packages.
>>
>> So as a result xeno-runtime that contains the testsuite and binaries
>> located under /usr/bin/
>> are not installed because /usr/bin/xeno-config have already been
>> included in the libxenomai-dev
>> package, and so the apt package manager aborts the install of xeno-runtime.
>>
>> My architecture is as follows:
>> Real-time used: Cobalt
>> OS: Ubuntu 14.04
>> Vanilla Kernel: 3.16
>> Arch: x86_64
>>
>> I suspect some or other changes in the make files have created this
>> conflict, because I have compiled a version older than rc3 previously,
>> namely 590aa2a and there were no package
>> issues like the above.
>>
>> Regards
>> Michael
> 
> I have found the issue on the problem listed above.
> The commit (8871363..) that was made on 2015-02-26 was the issue.
> I added the lines back in that was removed in debian/rules on that commit,
> into the newest git HEAD and all the packages compiled and installed
> correctly as expected.
> 
> I don't have the bigger picture about why the changes were made on
> 8871363, but on my
> system it broke the package install mechanism, and I was unable to
> install xeno-runtime as a result.
> So I'm just reporting what I found.
> 

xeno-config should be present in the base package and dropped from the
-dev one, this may be the issue.


-- 
Philippe.

