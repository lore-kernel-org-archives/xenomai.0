Date: Thu, 2 Apr 2015 12:31:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150402103145.GE31175@hermes.click-hack.org>
References: <9BA84827B30CBE4996725F98F7DC912342962237@SMExchange01.siebmeyer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342962237@SMExchange01.siebmeyer.org>
Subject: Re: [Xenomai] git clone https ipipe.git fetch failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Apr 02, 2015 at 10:16:40AM +0000, Hänel-Baas, Alexander wrote:
> Hi Philippe,
> 
> I have tried again, here the error:
> 
> git clone https://git.xenomai.org/ipipe.git
> Cloning into 'ipipe'...
> error: Unable to get pack index https://git.xenomai.org/ipipe.git/objects/pack/pack-fc3c9da4f48cfea58e4448f81f2f88cee2a4c047.idx
> error: Unable to find ea34abcc6db809d3a2c747bb58bb31a23bb61d6b under https://git.xenomai.org/ipipe.git
> Cannot obtain needed object ea34abcc6db809d3a2c747bb58bb31a23bb61d6b
> error: Fetch failed.
> 
> By the way,  the http git works fine. It is only the https git that have this trouble.
> Now I am at the weekend, back at Tuesday than I can make some git test for you.

Just tried

wget 'https://git.xenomai.org/ipipe.git/objects/pack/pack-fc3c9da4f48cfea58e4448f81f2f88cee2a4c047.idx'

And it works fine too.
I suggest you run that wget command to see what error you get.

-- 
					    Gilles.

