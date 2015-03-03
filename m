MIME-Version: 1.0
In-Reply-To: <CA+C+_XQZVy=ryVnWCzXyFCOS+SMfAC8p66-PLWMQuZNOn+hG0w@mail.gmail.com>
References: <CA+C+_XRjP-YeDZgOmumU+AMbuUOJEtiuJ7v5U-ijRrTQWv-qrw@mail.gmail.com>
 <20150303004406.GA30672@hermes.click-hack.org>
 <CA+C+_XTpLYq94Vxvcz3snmx7hCPbz41FajCQm3Vc=DHvYXue0A@mail.gmail.com>
 <CA+C+_XQZVy=ryVnWCzXyFCOS+SMfAC8p66-PLWMQuZNOn+hG0w@mail.gmail.com>
Date: Tue, 3 Mar 2015 08:14:52 -0600
Message-ID: <CA+C+_XR=BrBzNX4EJpLob1Bmn6uhM6rAfUxS7acPPCUpBM2TVg@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] gdbserver hangs on rt_task_create()
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

Slide 13 of a presentation I found at
http://www.denx.de/en/pub/News/Xum2009AbstractsAndPresentations/About_the_Challenges_and_Successes_with_Xenomai_in_an_Industrial_Environment.pdf,
states:

">=Linux-2.6.30:  gdbserver freezes when debugging code where a thread is
created inside of another thread."

This is exactly what I'm seeing now.  It looks like this presentation was
written in 2009.  Is this still a known problem?

On Mon, Mar 2, 2015 at 9:07 PM, Mathew Benson <mathew.benson@gmail.com>
wrote:

> It doesn't look like that bone67 build is completed yet so I rolled back
> to the original bone53 build.  With a clean load, I get the same behavior.
> When I run 'cat /proc/ipipe/version', I get '3'.  Also, I'm running Xenomai
> 2.6.3, not 2.6.4.  Is there an additional patch?  If so, how can I tell if
> the patch is applied?
>
> On Mon, Mar 2, 2015 at 7:14 PM, Mathew Benson <mathew.benson@gmail.com>
> wrote:
>
>> To make life a bit easier, I used a prebuilt machinekit image from
>> http://www.machinekit.net/deb/wheezy-armhf/v3.8.13xenomai-bone53/.  I'm
>> stepping up to
>> http://www.machinekit.net/deb/wheezy-armhf/v3.8.13xenomai-bone67/ right
>> now.  I can give you details when I get a working build again.
>>
>> On Mon, Mar 2, 2015 at 6:44 PM, Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org> wrote:
>>
>>> On Mon, Mar 02, 2015 at 06:16:42PM -0600, Mathew Benson wrote:
>>> > When I step through my code, gdbserver hangs on rt_task_create() and
>>> never
>>> > comes back.  I'm using Xenomai 2.6.4.  I noticed in the archives
>>> several
>>> > other people ran into similar or identical problems in previous
>>> versions,
>>> > but I don't see a fix or workaround.
>>>
>>> As far I know there has been several such cases which have all been
>>> solved. But such fixes may be in the I-pipe patches, so, what
>>> version of the I-pipe patch are you using ?
>>>
>>> --
>>>                                             Gilles.
>>>
>>
>>
>
