Message-ID: <5362437D.2030802@xenomai.org>
Date: Thu, 01 May 2014 14:52:13 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1398502711.53016.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <535B8B43.1000109@xenomai.org> <535BDB20.7070100@xenomai.org>
 <1398944980.54240.YahooMailNeo@web171603.mail.ir2.yahoo.com>
In-Reply-To: <1398944980.54240.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue in notifier_callback while threadobj_lock is
 being held (forge/mercury)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/01/2014 01:49 PM, Matthias Schneider wrote:

> On a first glance the commit seems to work find - I am still verifying.
> Simplifying the suspend handling, would sending a SIGNOTIFY signal straight
> to the signal handler instead of using pipe read/write operations be an
> equivalent, even simpler alternative as demonstrated in the attached patch?
>

IIRC, the reason to base the logic on fasync handling was primarily to 
allow for extending the scheme to multi-processing setups (copperplate 
provides mechanisms for sharing most of its core objects between 
processes). Typically, using an AF_UNIX named socket instead of an 
anonymous pipe would have made possible to notify threads which belong 
to different processes the same way.

Simplifying the notification path would be a good thing though, we could 
use the regular (t)kill kernel interface to send the thread-directed 
SIGNOTIFY signal, instead of pthread_kill().

-- 
Philippe.

