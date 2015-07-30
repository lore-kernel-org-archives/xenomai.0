References: <55B91E8E.9010304@xenomai.org>
 <1152732986.5695318.1438266535029.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55BA4997.6040207@xenomai.org>
Date: Thu, 30 Jul 2015 17:58:15 +0200
MIME-Version: 1.0
In-Reply-To: <1152732986.5695318.1438266535029.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/30/2015 04:28 PM, Frederik Bayart wrote:

> I found already that 'select' on  socket(PF_UNIX, SOCK_STREAM, 0)  causes Interrupted system call (errno 4).
> If I replace 'select' with '__real_select' the problem seems to be solved, and the select timeout works.
> But the select doesn't seem to react on connect. I'm looking at the problem.
> 

It all depends on the flags passed to xeno-config (*): if --posix or
--rtdm is given (alone, or along with --native, --alchemy or whatever
other non-POSIX API), then POSIX calls will be wrapped to the
Xenomai/cobalt counterparts, in which case select() would call the
Xenomai implementation for instance.

If neither --posix nor --rtdm are given, then no wrapping takes place,
and select() will call the regular linux implementation.

If __real_select() works successfully in your app and differently than
select(), then wrapping is in effect, and this means that your file
descriptors are plain regular ones, obtained by standard linux syscalls
(__real_open, __real_socket), not by Xenomai syscalls (open, socket).

You may want to check for a mismatch due to POSIX symbol wrapping in
your app.

(*)
http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html

-- 
Philippe.

