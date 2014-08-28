Message-ID: <53FF8E93.6060704@xenomai.org>
Date: Thu, 28 Aug 2014 22:18:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEGbdifyuoCnxOnSfo7gXY0Ra1yUcJQY-7HXto5EvsjXEGXFNw@mail.gmail.com>
In-Reply-To: <CAEGbdifyuoCnxOnSfo7gXY0Ra1yUcJQY-7HXto5EvsjXEGXFNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Linux ATA driver issues and lockups
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthew Lindner <mattlindn@gmail.com>, xenomai@xenomai.org

On 08/28/2014 10:09 PM, Matthew Lindner wrote:
> We are using an Advantech-PCM9389 board running Linux 3.10.32 with
> Xenomai 2.6.3. Regularly there is an error that occurs. Sometimes
> operation continues as normal, sometimes the operating system freezes
> (with no panic). We have narrowed it down that when compiling a Linux
> 3.10.32 kernel there are no issues but when Xenomai patches are
> applied and Xenomai suggested kernel settings are changed these errors
> start occurring.

What happens if kernel configuration is changed but Xenomai and I-pipe
patches not applied?
If the system still works, what happens if you enable CONFIG_IPIPE and
not CONFIG_XENOMAI ?

-- 
                                                                Gilles.

