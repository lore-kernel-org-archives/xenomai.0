Message-ID: <542706E2.50403@xenomai.org>
Date: Sat, 27 Sep 2014 20:50:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABVE6k3zmPJBYMGvN9H_GVNyBT=WJFGgpBmJiDzw6=H3NekwTw@mail.gmail.com>
In-Reply-To: <CABVE6k3zmPJBYMGvN9H_GVNyBT=WJFGgpBmJiDzw6=H3NekwTw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] error about patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?SGFzcmV0IFNhcsSxeWVy?= <hsrtsryr@gmail.com>, Xenomai@xenomai.org

On 09/27/2014 08:45 PM, Hasret Sarıyer wrote:
> I used this guide <http://xenomai.org/2014/06/building-debian-packages/> for
> installation xenomai. And until I run a command, everything was nice. But
> when I run this command, I get an error message.
> 
> The command is :
> linux-3.10.32$ /usr/src/xenomai-kernel-sources/scripts/prepare-kernel.sh
> --linux=. --adeos=/usr/src/ipipe-core-3.10.32-x86-2.patch
> 
> The output şs :
> 
> bash: /usr/src/xenomai-kernel-sources/scripts/prepare-kernel.sh: No such
> file or directory

Could you run
dpkg -L xenomai-kernel-sources
?


-- 
                                                                Gilles.

