From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Mon, 21 Feb 2011 22:50:44 +0100
References: <AANLkTikH_NciDFN402p-bvPW__K2du9bZRgcS7AUfz+t@domain.hid>
	<1298318410.2075.5.camel@domain.hid> <4D62CC31.5050800@domain.hid>
In-Reply-To: <4D62CC31.5050800@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201102212250.44939.kisda@domain.hid>
Subject: Re: [Xenomai-help] rt_pipe_stream: not getting EPIPE
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Am Montag 21 Februar 2011, 21:33:53 schrieb varname:
> Philippe Gerum wrote:
> > On Mon, 2011-02-21 at 18:54 +0100, varname wrote:
> >> trying to write a simple producer / consumer using message pipes in
> >> the native API, this phrase from the documentation (found here [1])
> >> confuses me:
> >> 
> >> "-EPIPE is returned if the associated special device is not yet open."
> >> 
> >> It's not so much the sentence itself, but more the fact that I'm not
> >> getting that return value from rt_pipe_stream() when streaming bytes
> >> to a RT_PIPE that hasn't had its "special device" opened in secondary
> >> domain.
> >> 
> >> I've attached a modified trivial-periodic.c that demonstrates what I'm
> >> seeing. Afaik there is nothing open(2)-ing the /dev/rtp9 in the
> >> secondary domain. All writes succeed, up to about write 31 (*1024),
> >> after which all writes return 0.
> >> 
> >> [..]
> >> wrote: 1024, res: 1024
> >> wrote: 1024, res: 948
> >> wrote: 1024, res: 0
> >> wrote: 1024, res: 0
> >> [..]
> >> 
> >> Is the documentation incorrect, or am I misunderstanding something?
> > 
> > The doc is wrong (former implementation, 2.1.x series), the pipe
> > services do buffer real-time output until the special device is
> > eventually opened starting with Xenomai 2.2.x. Since you are using
> > rt_pipe_stream(), the output is directed to an internal buffer until
> > there is no more space there, which causes the final 0-byte returns.
> > 
> > So everything looks ok, except the doc.
> 
> ok, so there is actually no way to detect whether or not the special
> device has been opened? 

as a workaround you could use for example a named semaphore to do the 
synchronisation on pipe creation. (only if both task are xenomai tasks):

receiver:
  rt_pipe_create()
  rt_sem_create( NAME )
  rt_pipe_read()

sender:
  rt_sem_bind( NAME )
  rt_pipe_create()
  rt_pipe_send()

If rt_sem_bind() succeeds, the receiver should have created the pipe...

Stefan

> > As I understood from earlier mails on the list,
> writes to a full pipe buffer just fail, correct?
> 
> Is there any way to flush a message pipe from a userspace task (as
> opposed to a kernelspace one, where rt_pipe_flush is available)?
> 
> 
> thanks for the swift reply
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


