References: <55DC2940.90805@free.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55DC772F.7050505@xenomai.org>
Date: Tue, 25 Aug 2015 16:09:51 +0200
MIME-Version: 1.0
In-Reply-To: <55DC2940.90805@free.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] killall can not kill xenomai programs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_ANCELOT?= <sancelot@free.fr>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/25/2015 10:37 AM, Stéphane ANCELOT wrote:
> Hi,
> 
> killall is not working with xenomai programs.
> killall uses "short" process name, we can see it in /proc/<pid>/stat
> (second item).
> unfortunately all processes name have for short name "main", and thus it
> does not work.
> 
> Hope this helps to solve the problem.
> 

This should help:

http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=70700428810333bf60aef7a26d8a3f7f2a9ee949

-- 
Philippe.

