References: <48e48b6a-c767-1ae0-29cf-e59dd9c9c0d4@numalliance.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <48cfcb4c-0d7a-3d6e-1b3f-2967df5e7faf@xenomai.org>
Date: Fri, 16 Mar 2018 19:59:24 +0100
MIME-Version: 1.0
In-Reply-To: <48e48b6a-c767-1ae0-29cf-e59dd9c9c0d4@numalliance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] shared session and latest release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/16/2018 12:19 PM, Stéphane Ancelot wrote:
> Hi,
> 
> I upgraded my applications to latest release (next branch) .

The next branch is by definition NOT released, this is a development tree.

> 
> I do not manage to run the shared session , using session-label to run
> the program as user (fixed in a tunable config)
> 
> my session name is numalliance/automat (automat corresponds to my group
> user id 1000)
> 
> however , if I launch the program as root , it works.
> 
> I checked /dev/rtdm files, they all have rw access for user/ group / other
> 
> What else to check for ?
> 
> it fails as follow :
>    0"000.413| WARNING: [main] failed to initialize main shared heap
>    0"000.480| WARNING: [main] setup call copperplate failed
>    0"000.508| BUG in __xenomai_init(): [main] initialization failed,
EACCES
>

{rpm@cobalt} git grep -B2 "failed to initialize main shared heap"
lib/copperplate/init.c-	ret = heapobj_pkg_init_shared();
lib/copperplate/init.c-	if (ret) {
lib/copperplate/init.c:		warning("failed to initialize main shared heap");

You do know which error is spat out (EACCES), and you know which code is
involved. You should be able to fire a debugger, and find out what is
going on with the inits.

This would be a step in the right direction for turning the -next branch
into a release at some point.

-- 
Philippe.

