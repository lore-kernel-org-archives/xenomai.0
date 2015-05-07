Message-ID: <554B6C3D.6040101@free.fr>
Date: Thu, 07 May 2015 15:44:29 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
References: <554B0C27.5010802@free.fr>
 <20150507090719.GC2099@hermes.click-hack.org>
In-Reply-To: <20150507090719.GC2099@hermes.click-hack.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] v3 heap mem-pool-size
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/05/2015 11:07, Gilles Chanteperdrix wrote:
> On Thu, May 07, 2015 at 08:54:31AM +0200, Stéphane ANCELOT wrote:
>> Hi,
>>
>> Is there a better way to raise mem-pool-size other than specifying in
>> cmdline ?
>>
>>     0"007.389| WARNING: [main] heapobj_init() failed for 470 bytes, raise
>> --mem-pool-size?
> A command line option is nice, it allows you to do basically
> anything you want by calling your program from a script. What is it
> you want to do that can not be achieved this way?
>
It is a nice idea, however I understand everybody needs are not the same.

Regarding my application, I setup dynamically my heap once. But this 
heap size depends will depend on some external parameters and will vary. 
And the only way to know the size to allocate is to "count" the 
databytes in my C programing structures. Honestly, I am sure a computer
will better do it than my mind.

eg. These external parameters may depend on how many motors in my 
machine, and so on.

Regards,
S.Ancelot


