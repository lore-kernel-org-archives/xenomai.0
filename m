Message-ID: <536E1962.30008@xenomai.org>
Date: Sat, 10 May 2014 14:19:46 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMbo_3DjWPb2xt27WAR6MF6bLHf-QZM-n-VduNTugx34cQ0LPg@mail.gmail.com>
 <536DF390.9000604@xenomai.org>
In-Reply-To: <536DF390.9000604@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on v3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Brian Morel <brianmorel99@gmail.com>, xenomai@xenomai.org

On 05/10/2014 11:38 AM, Philippe Gerum wrote:
> On 05/10/2014 04:35 AM, Brian Morel wrote:
>> I want to start working on Xenomai & I-pipe on kernel 3.14 for arm
>> (beagle
>> bone black).  I was hoping for a little advise on which git
>> repositories to
>> use for both Xenomai & I-Pipe.  It looks like I would need the I-Pipe
>> patch
>> from either the main I-Pipe repo. or one of the named repos.
>
> ipipe-3.14 has just landed in git://git.xenomai.org/ipipe.git, with the
> latest ARM bits merged. The I-pipe support for ARM usually brews in this
> tree: git://git.xenomai.org/ipipe-gch.git, then gets merged in our
> mainline tree as mentioned earlier.
>

Make sure to disable CONFIG_CONTEXT_TRACKING for now. We are still 
investigating an issue with this feature.

-- 
Philippe.

