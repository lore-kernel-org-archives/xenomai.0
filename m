Message-ID: <50B8F21B.5090503@xenomai.org>
Date: Fri, 30 Nov 2012 18:51:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMgy_J0idydJq8wzH3CwQoCa+BEbSyUyOJoWmvwc+oAB3jpZ6w@mail.gmail.com>	<CAKvQZ_2Nzfgj7oK12+t3CtLj-YWBCB=nFYSDU6B4KqW4aWQpnQ@mail.gmail.com>	<50B88506.6000002@xenomai.org>
	<CAKvQZ_3LJ-u2B0zc0+pobSGnMZ4nNviyxfuP1uiVRVuHw9Y9pQ@mail.gmail.com>
In-Reply-To: <CAKvQZ_3LJ-u2B0zc0+pobSGnMZ4nNviyxfuP1uiVRVuHw9Y9pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Frustrating experience with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Willy Lambert <lambert.willy@gmail.com>
Cc: Shamju Joseph <shamju.joseph@gmail.com>, xenomai@xenomai.org

On 11/30/2012 03:29 PM, Willy Lambert wrote:
> 2012/11/30 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>> On 11/30/2012 09:45 AM, Willy Lambert wrote:
>>> P.S. : to xenomai community, is there a problem if I continue some
>>> support here, or should we go somewhere else more on topic ?
>>
>> Absolutely no problem, this is a recurring problem, so, we can not
>> really ignore it. The thingx I would add is:
>> - if you have a very recent computer, you will have more trouble
>> installing really old kernels than install the latest revision, so, I
>> would advise to use the I-pipe patch for Linux 3.2 with xenomai 2.6.1
>> - we can give you write access to the wiki if you wish to write some
>> documents about this.
>>
> 
> Ok, let me know where I should write something.
> 
> I'll rewrite something like my first mail in the "old debian way"
> (should be ok for debian and ubuntu) :
> _ explaining the idea "first compile your vanilla kernel before
> patching it, try boot, and add xenomai".
> _ getting compile tools
> _ getting linux source with ketchup (cause it's really no brain)
> _ getting current config, configuring personnal version
> _ compile command (producing .deb)
> _ install command / remove
> Keeping the aim to show a simple method without getting into details,
> and providing some general linux doc to read.
> 
> I don't have time to update my process to "latest pratices", but at
> least it a starting point.

Ok, I will create a login/password on the wiki.

However, for the particular case of Debian, starting with the I-pipe for
Linux 3.4, we can probably provide a precompiled kernel with a
debian-like configuration which will run on any platform.

-- 
					    Gilles.

