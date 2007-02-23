Message-ID: <45DE33BF.7090601@domain.hid>
Date: Fri, 23 Feb 2007 00:22:23 +0000
From: Roland Tollenaar <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [Xenomai-help] hello xenomai world?]
References: <45DE006F.5000400@domain.hid>
In-Reply-To: <45DE006F.5000400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,
>> Invoke make like this: make /path to xeno-config/. Which is why I was
>> going on about the config variables. I wil now try and find
>> xeno-config if it exists and see how that works. On the other hand I
>> don;t doubt that the application will compile. I need to find out what
>> libraries to include for this particular one for the next steps. See
>> later.
> 
> Ack, my bad. The example makefiles do not assume /usr/xenomai (or,
> alternatively, /usr/xenomai/bin/xeno-config) as default for XENO. Will fix.
> 
> Meanwhile try "make XENO=/usr/xenomai".
Ok this does compile. however when running the resulting sigxcpu there 
is an error while loading the shared libraries. cannot find 
libnative.so.0. This may be a result of the library installation. From 
long ago I remember that to install a library ldsomethingorother must be 
run to amend a certain library file. Due to the live nature of my 
installation this file whatever it is called might get overwritten.
What is strange is that the other applications don't seem to have this 
problem. Latency testsuitapp runs for example.


> Your feedback is appreciated and helps improving things. Just a certain
> part of your verbosity might have been avoidable by digging a bit deeper
> and checking twice, no? :)
:)
Perhaps. We are all in a big hurry and there are lots of bits and pieces 
with lots of documentation. Most of it not so bad actually but not 
really unified. If I from my point of view were to comment, then I would 
say that a single unified manual would have really made life a lot 
easier. Then again I have a handicap with my distribution so it may have 
been a lot simpler had I been working on a fixed installation instead of 
a windows laptop which turns into linux when it has a usb stick in it. 
On yet a third hand, I do think that a lot of people will only start 
recompiling kernels when they enter this real-time story. A combined 
really slow step-by-step instruction set of how to compile the kernel 
with xenomai would make it a lot more accessible.

On even yet another hand (I'm counting with my feet by now) I don;t 
really know what the objective of xenomai is. So far it appears to be an 
impressively engineered product for which I don't doubt there should be 
decent interest. Industry however is rather demanding when it comes to 
development time (which is where my hurry comes from) and would 
generally not go through the motions I am trying to rush through here. 
We typically want a platform on which one can start developing for the 
application ASAP. Now even though what I am doing is relatively speaking 
the easy bit (compared to developing the rt-patches and drivers), there 
are still too many man hours involved in just getting to the final platform.

Apparently -from how I understand the documentation- the objective, or 
one of the objectives of xenomai, is to make porting to it from other RT 
operating systems as easy as possible. Having to struggle ones bottom 
off to get xenomai installed and understanding how it works, would rub a 
lot of the shine off this (I speak based only on the twinkels I have 
seen so far :)) otherwise hyper-promising bit of software engineering.

Anyhow, must catch some quick sleep. Sorry again for all the questions. 
Especially the stupid ones :)

Thanks for tolerating and responding to them.

Ah, one last thing, if you want to remind me about our contribution to 
the documentation that would be good.

Regards,

Roland.





> 
> Jan
> 
> 

