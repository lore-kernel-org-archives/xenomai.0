Message-ID: <5294AAB4.5030707@xenomai.org>
Date: Tue, 26 Nov 2013 15:05:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5294A4C3.9090404@grinta.net> <5294A711.2010700@xenomai.org>
 <5294A933.5050300@grinta.net>
In-Reply-To: <5294A933.5050300@grinta.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] cgit repository modification times
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Daniele Nicolodi <daniele@grinta.net>
Cc: xenomai@xenomai.org

On 11/26/2013 02:59 PM, Daniele Nicolodi wrote:
> On 26/11/2013 14:50, Gilles Chanteperdrix wrote:
>> On 11/26/2013 02:40 PM, Daniele Nicolodi wrote:
>>> Hello,
>>>
>>> I've noticed that the new cgit web interface to the git repositories
>>> does not display the correct modification times for the repository in
>>> the repository list.  I don't know what may cause this, the displayed
>>> times seems completely arbitrary to me.
>>
>> Maybe that is because the time displayed in the repository list is not
>> the modification time, but the idle time, as the title line indicates?
>
> Sorry, wrong choice of words on my side. I believe that the idle time is
> defined as (current time) - (modification time). Isn't it?

>
> Still, for example, the xenomai-force repository has two branches:
> "master" and "next", for which cgit shows an "Age" (which I believe
> should be interpreted in the same way as "Idle") of respectively 24
> hours and 3 weeks.  The "Idle" field in the repository list reports 11 days.

It seems you are mixing the time when the last push occurred with the 
time when the last commit occurred, with git the two are not necessarily 
correlated. If you look at other projects using cgit, kernel.org for 
instance, you will find the same disparities.

In the case of Xenomai, most of the repositories appear to have been 
pushed 11 days ago because this is the time when the repositories were 
cloned from the old xenomai server to the new xenomai server.

-- 
					    Gilles.

