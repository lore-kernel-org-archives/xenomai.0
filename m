Message-ID: <535BDB20.7070100@xenomai.org>
Date: Sat, 26 Apr 2014 18:13:20 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1398502711.53016.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <535B8B43.1000109@xenomai.org>
In-Reply-To: <535B8B43.1000109@xenomai.org>
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

On 04/26/2014 12:32 PM, Philippe Gerum wrote:

> There is a single sane option: no code running on top of the SIGNOTIFY
> handler should attempt to grab any lock. notifier_callback() is simply
> wrong in acquiring a lock, only to set the suspend bit in the status.
> There is a better option for reflecting the current state locklessly.
>
> I'll issue a fix.
>

Ok, this time I grabbed the chainsaw to fix this code, dropping all 
non-sense and left overs from the early days. Feedback welcome.

http://git.xenomai.org/xenomai-forge.git/commit/?h=next&id=4f3396bf96b9fcb750d68e843c60ec9f5d22f9cd

TIA,

-- 
Philippe.

