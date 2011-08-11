From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4E43A2BE.4080903@domain.hid>
References: <20110809174031.7B1346B2@domain.hid>
	<1312905835.2112.106.camel@domain.hid> <20110811103352.902F5E9E@centrum.cz>
	<1313053817.2133.71.camel@domain.hid>  <4E43A2BE.4080903@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 11 Aug 2011 12:03:36 +0200
Message-ID: <1313057016.2133.79.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_queue_bind() returns -EACCES
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>

On Thu, 2011-08-11 at 11:37 +0200, Gilles Chanteperdrix wrote:
> On 08/11/2011 11:10 AM, Philippe Gerum wrote:
> > On Thu, 2011-08-11 at 10:33 +0200, Petr Cervenka wrote:
> >> Hello.
> >>
> >> I created a simple examples which describe my problem.
> >> It is some kind of server and client.
> >> At first run a qserver and then qclient.
> >> After that close the qserver and try to run it again.
> >> It disallows (in my configuratio) to create the queue because it already exists and also the binding to it fails with error -EACCES.
> >> This behavior continues till the qclient is closed. It's perhaps caused by the rt_queue_delete() at the end of qserver.
> > 
> > That is the intended behavior. When deleted, the queue is maintained
> > internally until the last client bound to it exits, which also disallows
> > creating another queue with the same name until the latter event
> > happens.
> > 
> > However, deleting the queue also makes it unreachable for further
> > bindings, until it is completely dismantled after the last client exits.
> > At which point you may re-create a queue with the same name and bind to
> > it. Logically speaking, that deleted queue does not exist anymore,
> > except for the currently bound client(s), for consistency reasons.
> 
> Maybe we could return -EIDRM instead of -EEXIST when in this case?
> 

Not sure. EIDRM is conventionally about telling the caller that some
previously valid identifier has been revoked while the operation was
ongoing, which does not match the case of trying to establish a fresh
binding to a zombie object. In the first case, we did have a valid
object on entry, in the second one, that object has never been valid
from the caller's standpoint.

I'm unsure that returning EIDRM would be trivial to implement anyway. We
would have to make the registry layer aware of the "magic" tags used by
the upstream interfaces, so that it could check atomically EIDRM vs
EEXIST when failing to hash the object key. Granted, we could move this
magic into the xnobject struct directly though and get rid of it
elsewhere. Some work ahead in such a case.

-- 
Philippe.



