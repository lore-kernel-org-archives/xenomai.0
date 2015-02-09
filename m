Date: Mon, 9 Feb 2015 14:08:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150209130859.GA3200@hermes.click-hack.org>
References: <CA+C+_XRGJinM4nkPutZMO5ZUOEz9tFKhQww2_DOuM+PJquvVXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+C+_XRGJinM4nkPutZMO5ZUOEz9tFKhQww2_DOuM+PJquvVXQ@mail.gmail.com>
Subject: Re: [Xenomai] segfault
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Feb 08, 2015 at 08:20:54PM -0600, Mathew Benson wrote:
> I have a program thats segfaulting when I add additional real time threads
> that each take up resources.  By themselves or in small groups, they're
> fine.  But as I scale it up, it crashes.  I haven't got gdb to work right
> yet,

What happens when you run the application inside gdb ?

> so it crashes in such a way that prevent me from pulling any debug
> information out.  I ran dmesg, but don't see anything meaningful.  Are
> there other logs I can look at?

In your application, check all the return values of all the services
you use, especially functions like malloc returning pointers.

Also, what is the stack size of the threads you create, is it
sufficient? Is not it too much? See:

https://xenomai.org/troubleshooting-a-dual-kernel-configuration/#the_application_overconsumes_system_memory

-- 
					    Gilles.

